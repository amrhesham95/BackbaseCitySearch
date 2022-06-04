//
//  AppDelegate.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 02/06/2022.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var coordinator: AppCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coordinator = DefaultAppCoordinator(navigationController: UINavigationController())
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator?.start()
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

