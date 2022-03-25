//
//  LoginRepositoryUseCaseMockSuccess.swift
//  AlarstudiosTests
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation
@testable import Alarstudios

struct ConstsForTests {
    static let mockSessionKey = "12345"
    static let mockLogin = "test"
    static let mockPassword = "1234"
}

struct LoginRepositoryUseCaseMockSuccess: LoginRepositoryProtocol {
    func signeIn(_ login: String,
                 _ password: String,
                 _ complection: @escaping (Result<LoginRequest.Response, CustomError>) -> Void) {
        complection(.success(.init(status: .ok, code: ConstsForTests.mockSessionKey)))
    }
    
    func getSessionKey() -> String? {
        ConstsForTests.mockSessionKey
    }
    
    func setSessionKey(_ sessionKey: String) {
        
    }
    
}

struct LoginRepositoryUseCaseMockFailure: LoginRepositoryProtocol {
    func signeIn(_ login: String,
                 _ password: String,
                 _ complection: @escaping (Result<LoginRequest.Response, CustomError>) -> Void) {
        complection(.failure(.wrongLoginPassword))
    }
    
    func getSessionKey() -> String? {
        nil
    }
    
    func setSessionKey(_ sessionKey: String) {
        
    }
}
