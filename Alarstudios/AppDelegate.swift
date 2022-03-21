//
//  AppDelegate.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var useCase: LoginUseCase?
    var pageuc: LoadListsPageUseCase?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}

