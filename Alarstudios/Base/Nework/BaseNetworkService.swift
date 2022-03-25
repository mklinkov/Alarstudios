//
//  BaseNetworkService.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<Request: DataRequest>(_ request: Request,
                                       _ completion: @escaping (Result<Request.Response, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case errorSendRequest
    case errorResponse
    case customError(Error)
}

final class DefaultNetworkService: NetworkServiceProtocol {
    
    func request<Request: DataRequest>(_ request: Request,
                                       _ completion: @escaping (Result<Request.Response, NetworkError>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            return completion(.failure(.errorSendRequest))
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return completion(.failure(.errorSendRequest))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(.customError(error)))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(.errorResponse))
            }
            
            guard let data = data else {
                return completion(.failure(.errorResponse))
            }
            
            do {
                let model = try request.decode(data)
                completion(.success(model))
            } catch let error {
                completion(.failure(.customError(error)))
            }
        }
        .resume()
    }
}
