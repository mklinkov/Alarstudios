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
    private let viewModel: LoginViewModelInput
    
    init(view: LoginPresenterOutput,
         router: LoginRouter,
         viewModel: LoginViewModelInput) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
    }
}

extension LoginPresenter: LoginPresenterInput {
    func loginAction(_ login: String?, _ passwor: String?) {
        viewModel.login(login, passwor)
    }
}

extension LoginPresenter: LoginViewModelOutput {
    func showError(_ error: DisplayFailure) {
        view?.loginDidFail(error)
    }
    
    func loginDidSuccess() {
        router.openListView()
    }
}
