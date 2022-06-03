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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView: CitiesView(viewModel: CitiesViewModel()))
        window?.makeKeyAndVisible()
        return true
    }
}

