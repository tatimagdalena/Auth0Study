//
//  ViewController.swift
//  POCAuth0
//
//  Created by Tatiana Magdalena on 07/05/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    var authentication: AuthenticationProtocol!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Bundle.main.bundleIdentifier ?? "")
    }
    
    @IBAction func logout(_ sender: UIButton) {
        authentication.logout()
    }
    
    @IBAction func openAuth0(_ sender: UIButton) {
        
        if authentication.hasValidCredentials() {
            authentication.retrieveCredentials()
        } else {
            authentication.presentLoginPage(from: self)
        }
        
    }
    
    
}

