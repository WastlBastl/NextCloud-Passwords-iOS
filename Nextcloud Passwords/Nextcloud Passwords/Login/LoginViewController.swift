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
            print("Keychain is full")
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
            print("KeyChain is emtpy")
        }
    }
        
        // Do any additional setup after loading the view
    

    
    @IBAction func loginTapped(_ sender: Any) {
        
        KeychainWrapper.standard.set(loginURLTextField.text ?? "", forKey: "LoginURL")
        KeychainWrapper.standard.set(loginUsernameTextField.text ?? "", forKey: "LoginUsername")
        KeychainWrapper.standard.set(loginPasswordTextField.text ?? "", forKey: "LoginPassword")

        //      Build API Call
                let SessionAPIURL = URL(string: KeyChainURL + Main.GlobalVariables.APIURL + "/session/request")
                print(SessionAPIURL as Any)
                
        //      URL Request
        //        var request = URLRequest(url: SessionAPIURL!)
                
                // credentials encoded in base64
                let username = KeyChainUsername
                let password = KeyChainPassword
                let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
                let base64LoginData = loginData.base64EncodedString()
                 
                    // create the request
        //            let url = URL(url: SessionAPIURL)!
                var request = URLRequest(url: SessionAPIURL!)
                request.httpMethod = "GET"
                request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
                 
                    //making the request
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print("\(error)")
                        return
                    }
                 
                    if let httpStatus = response as? HTTPURLResponse {
                        // check status code returned by the http server
                        print("Login status code = \(httpStatus.statusCode)")
                        
        //              Debug!!
                        if httpStatus.statusCode != 200 {
                            self.ErrorLabel.text = "Username, Password or URL are false or the URL is not reachable!"
                        }
                        else{
                            
//                          open HomeScreen ViewController
                            
                        }
                    // process result
                    }
                }
                    task.resume()
                
                
        // End of API Call
        
    }
    
    
    
}
