//
//  AppDelegate.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: OrdersViewController())
        window?.makeKeyAndVisible()
        return true
    }
}
