//
//  LoginPresenter.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

/// протокол для view
protocol LoginPresenterOutput: AnyObject {
    func loginDidFail(_ error: LoginPresenter.DisplayFailure)
}

/// протокол для получения событий с view
protocol LoginPresenterInput: AnyObject {
    func loginAction(_ login: String?, _ passwor: String?)
}

final class LoginPresenter {
    enum DisplayFailure {
        case showAlert(title: String, message: String)
        case unownedError
    }
    
    private let router: LoginRouter
    private weak var view: LoginPresenterOutput?
    private let loginUseCase: LoginUseCase
    
    init(view: LoginPresenterOutput,
         router: LoginRouter,
         loginUseCase: LoginUseCase) {
        self.view = view
        self.router = router
        self.loginUseCase = loginUseCase
    }
}

extension LoginPresenter: LoginPresenterInput {
    func loginAction(_ login: String?, _ passwor: String?) {
        self.login(login, passwor)
    }
}

extension LoginPresenter {
    
    private func showError(_ error: CustomError) {
        let title = "Ошибка"
        var message = "Не известаня ошибка!"
        switch error {
        case .wrongLoginPassword:
            message = "Ошибка авторизации"
        case .validationLoginError:
            message = "Ошибка валидации логина"
        case .validationPassworError:
            message = "Ошибка валидации пароля"
        case .netwokError(let error):
            message = "Ошибка сети: \(error.localizedDescription)"
        default:
            break
        }
        view?.loginDidFail(.showAlert(title: title, message: message))
    }
    
    private func login(_ login: String?, _ password: String?) {
        loginUseCase.invoke(login, password) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showError(error)
            case .success:
                self?.router.openListView()
            }
        }
    }
    
}
