//
//  Router.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import UIKit

protocol Routing: AnyObject {
    var view: UIViewController { get }
    init(view: UIViewController)
    func push(_ destinationView: UIViewController)
}

extension Routing {
    func push(_ destinationView: UIViewController) {
        view.navigationController?.pushViewController(destinationView, animated: true)
    }
    
    func present(_ destinationView: UIViewController) {
        destinationView.modalPresentationStyle = .fullScreen
        view.present(destinationView, animated: false, completion: nil)
    }
}

class Router: Routing {
    var view: UIViewController
    required init(view: UIViewController) {
        self.view = view
    }
}

extension Router {
    class func loginScreen() -> UIViewController {
        let loginRepository = LoginRepository(dataSource: NetwokService(), store: LoginInMemoryStore.instance)
        let loginUsecase = LoginUseCase(loginRepository: loginRepository)
        
        let viewController = LoginViewController()
        let router = LoginRouter(view: viewController)
        
        let presenter = LoginPresenter(view: viewController, router: router, loginUseCase: loginUsecase)
        
        viewController.presenter = presenter
        return viewController
    }
}
