//
//  AuthenticationWrapper.swift
//  POCAuth0
//
//  Created by Tatiana Magdalena on 08/05/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import Lock
import Auth0

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
        
        Lock
            .classic()
            // withConnections, withOptions, withStyle, and so on
            .withOptions {
                $0.logLevel = .all
                $0.logHttpRequest = true
                $0.oidcConformant = true
                $0.scope = "openid profile offline_access"
                $0.closable = true
                $0.passwordManager.enabled = false
            }
            .withStyle {
                $0.title = "Company LLC"
                $0.logo = LazyImage(name: "logo_placeholder")
                $0.primaryColor = Color.brandbookPalette.midDarkGreen
                $0.headerBlur = .extraLight
            }
            .onAuth { credentials in
                // Let's save our credentials.accessToken value
                self.saveToKeychain(credentials: credentials)
            }
            .onError { error in
                print("❗️ Error: \(error)")
            }
            .present(from: presenter)
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
