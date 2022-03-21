//
//  LoginRouter.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation
import UIKit

final class LoginRouter: Router {
    func openListView() {
        let network = NetwokService()
        let loginRepository = LoginRepository(dataSource: network, store: LoginInMemoryStore.instance)
        let listRepository = ListRepository(dataSource: network)
        let loadPageUseCase = LoadListsPageUseCase(listRepository: listRepository, loginRepository: loginRepository)
        
        let viewModel = ListViewModel(listUseCase: loadPageUseCase)
        
        let listViewController = ListViewController()
        let router = ListRouter(view: listViewController)
        let presenter = ListPresenter(view: listViewController, router: router, viewModel: viewModel)
        
        listViewController.presenter = presenter
        viewModel.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: listViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "barColor")
        navigationController.navigationBar.standardAppearance = appearance;
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        pop(navigationController)
    }
}
