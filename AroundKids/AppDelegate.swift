//
//  AppDelegate.swift
//  AroundKids
//
//  Created by Tai Le on 23/05/2021.
//

import UIKit
import SideMenuSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SideMenuController(
            contentViewController: ViewController(),
            menuViewController: SideMenuViewController()
        )

        SideMenuController.preferences.basic.menuWidth = 240
        SideMenuController.preferences.basic.position = .above
        SideMenuController.preferences.basic.direction = .right
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true

        window?.makeKeyAndVisible()

        return true
    }

}

