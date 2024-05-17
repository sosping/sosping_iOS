//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation
import Domain
import Shared

final class NetworkManager {
    private var accessToken: String? = "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjpbIlJPTEVfVFVUT1IiXSwiYXVkIjoiMSIsImlhdCI6MTcxNTk4Mzc4MywiZXhwIjoxNzE1OTkwOTgzfQ.s6Pkr12ia__9RnlEIfIrsnx0v2J93TBW0O-Tdtka0i0dc2sMbhoCLi5xG0pQOquOp8r06iubiDbtvcBO4yWxlQ"
    private var refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
    
    public static var shared: NetworkManager = .init()
    
    private var jsonDecoder: JSONDecoder {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return decoder
    }
    
    private var serverURL: String {
        return "http://ec2-13-125-76-129.ap-northeast-2.compute.amazonaws.com:8080"
    }
    
    private func responseHanding<T: Codable>(request: URLRequest) async throws -> T {
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw APIError.unknown
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        guard (200...204).contains(httpResponse.statusCode) else {
            switch httpResponse.statusCode {
            case 400:
                throw APIError.code400
            case 401:
                throw APIError.token
            default:
                throw APIError.unknown
            }
        }
        
        guard let decodedData = try? self.jsonDecoder.decode(T.self, from: data) else {
            throw APIError.json
        }
        
        return decodedData
    }
    
    public func requestAccessToken() async -> Bool {
        guard let url = URL(string: "\(self.serverURL)\("")") else {
            return false
        }
        guard let refreshToken else {
            debugPrint("\(#function): refresh token is nil")
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(refreshToken)", forHTTPHeaderField: "RefreshToken")
        
        guard let (_, response) = try? await URLSession.shared.data(for: request) else {
            return false
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        
        guard (200...204).contains(httpResponse.statusCode) else {
            debugPrint("\(#function): invalid status code = \(httpResponse.statusCode)")
            return false
        }
        
        self.accessToken = httpResponse.value(forHTTPHeaderField: "Authorization")
        return true
    }
    
    public func authenticate(body: Login, completion: @escaping (Result<User, APIError>) -> Void) async {
        guard let url = URL(string: "\(self.serverURL)\("")") else {
            completion(.failure(APIError.unknown))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let bodyData = try? JSONEncoder().encode(body) else {
            completion(.failure(APIError.json))
            return
        }
        request.httpBody = bodyData
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            completion(.failure(APIError.unknown))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(APIError.unknown))
            return
        }
        
        guard (200...204).contains(httpResponse.statusCode) else {
            switch httpResponse.statusCode {
            case 400:
                completion(.failure(APIError.code400))
            default:
                completion(.failure(APIError.response(code: httpResponse.statusCode)))
            }
            return
        }
        
        self.accessToken = httpResponse.value(forHTTPHeaderField: "Authorization")
        UserDefaults.standard.set(httpResponse.value(forHTTPHeaderField: "RefreshToken"), forKey: "refresh_token")
        
        guard let decodedData = try? self.jsonDecoder.decode(User.self, from: data) else {
            completion(.failure(APIError.json))
            return
        }
        
        completion(.success(decodedData))
    }
    
    public func get<T: Codable>(path: String, completion: @escaping (Result<T, APIError>) -> Void) async {
        guard let url = URL(string: "\(self.serverURL)\(path)") else {
            completion(.failure(APIError.unknown))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let accessToken else {
            completion(.failure(APIError.token))
            return
        }
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        debugPrint("\(#function): request = \(request)")
        
        do {
            let data: T = try await responseHanding(request: request)
            completion(.success(data))
        } catch {
            completion(.failure(.convert(error: error)))
            return
        }
    }
    
    public func post<T: Codable, S: Codable>(path: String, body: T?, completion: @escaping (Result<S, APIError>) -> Void) async {
        guard let url = URL(string: "\(self.serverURL)\(path)") else {
            completion(.failure(APIError.unknown))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let accessToken else {
            completion(.failure(APIError.token))
            return
        }
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        if let body {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let bodyData = try? JSONEncoder().encode(body) else {
                completion(.failure(APIError.json))
                return
            }
            request.httpBody = bodyData
        }
        
        do {
            let data: S = try await responseHanding(request: request)
            completion(.success(data))
        } catch {
            completion(.failure(.convert(error: error)))
            return
        }
    }
}
