//
//  LoginViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 04.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit
import LocalAuthentication
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var loginURLTextField: UITextField!
    @IBOutlet weak var loginUsernameTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
//  Declare Variables
    let KeyChainURL = KeychainWrapper.standard.string(forKey: "LoginURL")!
    let KeyChainUsername = KeychainWrapper.standard.string(forKey: "LoginUsername")!
    let KeyChainPassword = KeychainWrapper.standard.string(forKey: "LoginPassword")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//      Proof if User has logged in before
        
        if KeyChainURL != nil && KeyChainUsername != nil && KeyChainPassword != nil{
//            print("Keychain is full")
            let context:LAContext = LAContext()
                
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
                context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "For secure login") { (Successfull, error) in
                        if Successfull {
                            print("Successfully logged in")
                        }
                        else{
                            print("Please try again")
                        }
                    }
            }
        }
        else{
//            print("KeyChain is emtpy")
        }
    }
        
        // Do any additional setup after loading the view
    

    
    @IBAction func loginTapped(_ sender: Any) {
        self.ErrorLabel.text = ""
        KeychainWrapper.standard.set(loginURLTextField.text ?? "", forKey: "LoginURL")
        KeychainWrapper.standard.set(loginUsernameTextField.text ?? "", forKey: "LoginUsername")
        KeychainWrapper.standard.set(loginPasswordTextField.text ?? "", forKey: "LoginPassword")

        //      Build API Call
        let headers: HTTPHeaders = [
            .authorization(username: KeychainWrapper.standard.string(forKey: "LoginUsername")!, password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),
            .accept("application/json")
        ]
        
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + Main.GlobalVariables.APIURL + "/session/request", headers: headers).response { response in
//            debugPrint(response)
            let statusCode = response.response?.statusCode
            print(statusCode as Any)
            
            if statusCode != 200 {
                self.ErrorLabel.text = "Can not sign in"
            }
            
        }
        // End of API Call
        
        
    }
    
    
    
}
