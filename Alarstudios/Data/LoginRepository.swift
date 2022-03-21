//
//  LoginRepository.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

/// Репозиторий авторизации пользователя
/// отвественность репозитория это выбор источника информации сеть, память, база
/// репозиторий  абстракция чтобы логика была изолирована от источника данных
/// репозиторий всегда описывается через протокол
/// в репозитории всегда возврает результат в main
protocol LoginRepositoryProtocol {
    func signeIn(_ login: String, _ password: String, _ complection: @escaping (Result<LoginRequest.Response, CustomError>)->())
    func getSessionKey() -> String?
    func setSessionKey(_ sessionKey: String)
}

final class LoginRepository: LoginRepositoryProtocol {
    
    private var dataSource: NetwokService?
    private weak var store: LoginInMemoryStoreProtocol?
    init(dataSource: NetwokService, store: LoginInMemoryStoreProtocol ) {
        self.dataSource = dataSource
        self.store = store
    }
    
    func signeIn(_ login: String,
                 _ password: String,
                 _ complection: @escaping (Result<LoginRequest.Response, CustomError>)->()) {
        dataSource?.signeIn(login, password) { result in
            DispatchQueue.main.async {
                complection(result)
            }
        }
    }
    
    func setSessionKey(_ sessionKey: String) {
        store?.sessionkey = sessionKey
    }

    func getSessionKey() -> String? {
        store?.sessionkey
    }
    
}

public enum CustomError: Error {
    case wrongLoginPassword
    case validationPassworError
    case validationLoginError
    case unknownError
    case sessionNotfound
    case netwokError(Error)
}

extension CustomError: Equatable {
    public static func == (lhs: CustomError, rhs: CustomError) -> Bool {
        switch (lhs, rhs) {
        case (.netwokError, .netwokError):
            return true
        case (.sessionNotfound, .sessionNotfound),
            (.unknownError, .unknownError),
            (.validationLoginError, .validationLoginError),
            (.validationPassworError, .validationPassworError),
            (.wrongLoginPassword, .wrongLoginPassword):
            return true
        default:
            return false
        }
    }
}

/// хранилище в памяти, можно заменить на любой вариант хранения
protocol LoginInMemoryStoreProtocol: AnyObject {
    var sessionkey: String? { get set }
}
final class LoginInMemoryStore: LoginInMemoryStoreProtocol {
    static let instance = LoginInMemoryStore.init()

    private init() { }
    var sessionkey: String?
}
