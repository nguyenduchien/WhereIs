//
//  AppDelegate.swift
//  MyApp
//
//  Created by Quang Dang N.K on 5/9/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
import IQKeyboardManager

let userDefault = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let shared: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast to AppDelegate.")
        }
        return delegate
    }()
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let tabbar = TabbarViewController()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared().isEnabled = true
        return true
    }
}
