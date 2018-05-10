//
//  AppDelegate.swift
//  POCAuth0
//
//  Created by Tatiana Magdalena on 07/05/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit
import Lock

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.authentication = Auth0Wrapper()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        print("💡 Asked to open url: \(url.absoluteString)")
        return Lock.resumeAuth(url, options: options)
    }
    
}

