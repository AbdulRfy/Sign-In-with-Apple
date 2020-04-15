//
//  ViewController.swift
//  LoginWithApple
//
//  Created by AbdurRafay on 12/04/2020.
//  Copyright © 2020 AbdurRafay. All rights reserved.
//

import UIKit
//import AuthenticationServices

class ViewController: UIViewController { //, ASAuthorizationControllerDelegate {

    var loginWithApple : NSObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            setupLoginWithApple()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            checkAppleAutoLogin()
        }
    }
	
	@available(iOS 13.0, *)
	func checkAppleAutoLogin() {
        if let loginApple = loginWithApple as? LoginWithApple {
            loginApple.checkAutoLogin()
        }
	}
    
    @available(iOS 13.0, *)
    func setupLoginWithApple() {
        loginWithApple = LoginWithApple(onView: self.view)
        if let loginApple = loginWithApple as? LoginWithApple {
            loginApple.successClosure = appleLoginSuccessfull
            loginApple.successClosureWith = appleLoginSuccessfullWith
            loginApple.failureClosure = appleLoginFailure
            loginApple.failureClosureWith = appleLoginFailureWith
        }
    }
    
    let appleLoginSuccessfull: () -> Void = {
        print("Successfull")
    }
    
    let appleLoginSuccessfullWith : (String, PersonNameComponents?, String?) -> Void = { (userId, nameComponents, email) in
        print("Successfull with UserId: \(userId)    name: \(nameComponents?.givenName ?? "NA")    email: \(email ?? "NA")")
    }
    
    let appleLoginFailure : (AppleLoginFailError) -> Void = { (failureType) in
        print("Failure failureType: \(failureType)")
    }
    
    let appleLoginFailureWith : (AppleLoginFailError, Error) -> Void = { (failureType, error) in
        print("Failure failureType: \(failureType)   error \(error.localizedDescription)")
    }
}


