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
    
//    Declare
    let KeyChainURL = KeychainWrapper.standard.string(forKey: "LoginURL")
    let KeyChainUsername = KeychainWrapper.standard.string(forKey: "LoginUsername")
    let KeyChainPassword = KeychainWrapper.standard.string(forKey: "LoginPassword")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//      Build API Call
        let SessionAPIURL = URL(string: KeyChainURL! + Main.GlobalVariables.APIURL + "/password/list")
        print(SessionAPIURL as Any)
        
//      Build Basic Authorization
        let loginString = String(format: "%@:%@", KeyChainUsername!, KeyChainPassword!)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
//      URL Request
        var request = URLRequest(url: SessionAPIURL!)
        
//      Speicify Headers
        let headers = [
            "Authorization": base64LoginString,
            "content-type": "application/json"
        ]
        
        request.allHTTPHeaderFields = headers
        
//      Specify the body
//        let jsonObject = [
//            "URL": "https://test.test",
//            "Test": true
//        ] as [String:Any] -> for matching, because there is an boolean in there
        
//      Make it as an Data Object
//        do{
//        let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
//        request.httpBody = requestBody
//        }
//        catch {
//            print("Error creating the data object from json")
//        }
        
//        Set HTTP Request Type
        request.httpMethod = "GET"
        
//        Get the URLSession
        let session = URLSession.shared
        
//        Create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil && data != nil {
                
//                Parse JSON
                let decoder = JSONDecoder()
                
                do{
                    let NCPasswordsGET = try decoder.decode(NCPasswords.self, from: data!)
                    print(NCPasswordsGET)
                    }
                catch{
                    print("Error in JSON parsing")
                }
                
            }
        }
        
//            Fire up dataTask
            dataTask.resume()
        
// End of API Call
        
        
        
        
        
        
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
// Tastatur lässt sich nicht minimieren im Login Screen am iPhone!! Dies muss geändert werden.
        
    }
    
    
    
}
