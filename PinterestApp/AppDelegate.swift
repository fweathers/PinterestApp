//
//  AppDelegate.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 2/28/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        PinterestClient.configureClient()

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return PDKClient.sharedInstance().handleCallbackURL(url)
    }
}
