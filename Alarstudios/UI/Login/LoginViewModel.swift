//
//  LoginViewModel.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

/// протокол для presenter
protocol LoginViewModelOutput: AnyObject {
    func showError(_ error: LoginPresenter.DisplayFailure)
    func loginDidSuccess()
}

/// протокол для получения событий из presenter
protocol LoginViewModelInput: AnyObject {
    func login(_ login: String?, _ password: String?)
}

final class LoginViewModel {
    private let loginUseCase: LoginUseCase
    weak var presenter: LoginViewModelOutput?
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    func showError(_ error: CustomError) {
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
        presenter?.showError(.showAlert(title: title, message: message))
    }
}

extension LoginViewModel: LoginViewModelInput {
    func login(_ login: String?, _ password: String?) {
        loginUseCase.invoke(login, password) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showError(error)
            case .success:
                self?.presenter?.loginDidSuccess()
            }
        }
    }
}
