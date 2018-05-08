//
//  AppDelegate.swift
//  POCAuth0
//
//  Created by Tatiana Magdalena on 07/05/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit
import Auth0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        print(url.absoluteString)
        return Auth0.resumeAuth(url, options: options)
    }


}

