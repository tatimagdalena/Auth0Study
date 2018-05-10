//
//  AuthenticationWrapper.swift
//  POCAuth0
//
//  Created by Tatiana Magdalena on 08/05/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Auth0
import UIKit

protocol AuthenticationProtocol {
    func retrieveCredentials()
    func presentLoginPage(from presenter: UIViewController)
    func hasValidCredentials() -> Bool
    func logout()
}

class Auth0Wrapper: AuthenticationProtocol {
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    var credentials: Credentials?
    
    func retrieveCredentials() {
        credentialsManager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
                // Handle error
                print("❗️ Error: \(error?.localizedDescription ?? "")")
                return
            }
            // You now have a valid credentials object, you might want to store this locally for easy access.
            // You will use this later to retrieve the user's profile
            self.printCredentials(credentials)
            self.credentials = credentials
        }
    }
    
    func presentLoginPage(from presenter: UIViewController) {
        Auth0
            .webAuth()
            .scope("openid profile offline_access")
            .audience("https://tatimagdalena.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    self.saveToKeychain(credentials: credentials)
                }
            }
    }
    
    func hasValidCredentials() -> Bool {
        return credentialsManager.hasValid()
    }
    
    func logout() {
        let result = credentialsManager.clear()
        print("📝 ❔ Logout successfull? \(result)")
    }
    
    private func saveToKeychain(credentials: Credentials) {
        printCredentials(credentials)
        let result = self.credentialsManager.store(credentials: credentials)
        print("📝 ❔ Saving credentials successfull? \(result)")
    }
    
    private func printCredentials(_ credentials: Credentials) {
        print("📝 Credentials: \(credentials)")
        print("Access token: \(credentials.accessToken ?? "")")
        print("Access token type: \(credentials.tokenType ?? "")")
        print("Expires in: \(String(describing: credentials.expiresIn))")
        print("Refresh token: \(credentials.refreshToken ?? "")")
    }
}
