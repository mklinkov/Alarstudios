//
//  NetwokService+Login.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

struct LoginRequest: DataRequest {
    var url: String = "https://www.alarstudios.com/test/auth.cgi"
    var method: HTTPMethod = .get
    let password: String
    let login: String
    typealias Response = LoginResponseModel
    
    var queryItems: [String: String] {
        ["username": "\(login)",
         "password": password ]
    }
    
    init(_ login: String, _ password: String) {
        self.login = login
        self.password = password
    }
    
}

struct LoginResponseModel: Decodable {
    enum LoginResponseModelStatus: String, Codable {
        case ok
        case error
    }
    
    let status: LoginResponseModelStatus
    let code: String?
}

extension LoginResponseModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.status == rhs.status && lhs.code == rhs.code
    }
}

extension NetwokService {
    func signeIn(_ login: String,
                 _ password: String,
                 _  complection: @escaping (Result<LoginRequest.Response, CustomError>) -> Void) {
        let request = LoginRequest(login, password)
        network.request(request) { response in
            switch response {
            case.success( let result ):
                complection(.success(result))
            case .failure(let error):
                complection(.failure(.netwokError(error)))
            }
        }
    }
}
