//
//  AppCoordinator.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 04/06/2022.
//

import Foundation
import UIKit
import SwiftUI

protocol AppCoordinator: AnyObject {
    var navigationController: UINavigationController { get set}
    func start()
    func showDetailsFor(_ city: City)
}

class DefaultAppCoordinator: AppCoordinator {
    var navigationController: UINavigationController
    var flag = true
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }

    
    func showDetailsFor(_ city: City) {
    }
}
