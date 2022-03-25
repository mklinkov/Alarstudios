//
//  LoginUseCase.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

/// UseCase - единица бизнеслогики
/// UseCase может инжектить только репозитории
/// UseCase имеет одну публичную функцию invoke
/// UseCase должен быть покрыт юнит тестами
final class LoginUseCase {
    private var loginRepository: LoginRepositoryProtocol
    
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }
    
    /// метод авторизации пользователя singeIn
    ///  Метод проводит валидацию введенных данных
    /// - Parameters:
    ///  - login: опциональлный параметр для передачи логина польлзователя
    ///  - password: опциональный параметр для передачи пароля польлзователя
    ///  - complection:  замыкание обработки завершения
    func invoke(_ login: String?,
                _ password: String?,
                _ complection: @escaping (Result<LoginRequest.Response, CustomError>) -> Void) {
        guard let login = login, !login.isEmpty else {
            return complection(.failure(.validationLoginError))
        }
        
        guard let password = password, !password.isEmpty else {
            return complection(.failure(.validationPassworError))
        }
        
        loginRepository.signeIn(login, password) { [weak self] result in
            guard let self = self else {
                assertionFailure("LoginUseCase is nil")
                return complection(.failure(.unknownError))
            }
            
            switch result {
            case .success(let response):
                guard response.status == .ok else {
                    complection(.failure(.wrongLoginPassword))
                    return
                }
                
                if  let sessonKey = response.code, !sessonKey.isEmpty {
                    self.loginRepository.setSessionKey(sessonKey)
                    complection(.success(response))
                } else {
                    complection(.failure(.unknownError))
                }
            case .failure(let error):
                complection(.failure(error))
            }
        }
    }
    
}
