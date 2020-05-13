//
//  ViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 02.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class Main: UIViewController {

//    Example for Global Varibales
    struct GlobalVariables {
        static let APIURL = "/index.php/apps/passwords/api/1.0"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetPasswords()

    }
    
    
    func GetPasswords(){
//      Build API Call
        let SessionAPIURL = URL(string: KeychainWrapper.standard.string(forKey: "LoginURL")! + Main.GlobalVariables.APIURL + "/password/list")
        print(SessionAPIURL as Any)
                                
//      URL Request
//        var request = URLRequest(url: SessionAPIURL!)
                                
// credentials encoded in base64
        let username = KeychainWrapper.standard.string(forKey: "LoginUsername")!
        let password = KeychainWrapper.standard.string(forKey: "LoginPassword")!
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
                                 
        // create the request
        var request = URLRequest(url: SessionAPIURL!)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
                                 
        //making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(error)")
                return
            }
            print("\(data)")
            if error == nil && data != nil {
                            
//                Parse JSON
            let decoder = JSONDecoder()
                            
                do{
                    let NCPasswordsGET = try decoder.decode(NCPasswords.self, from: data)
                    print(NCPasswordsGET)
                }
                catch{
                    print("Error in JSON parsing")
                }
            }
                                 
            if let httpStatus = response as? HTTPURLResponse {
            // check status code returned by the http server
                print("Password GET status code = \(httpStatus.statusCode)")
                                            
//              Debug!!
                if httpStatus.statusCode != 200 {
                    print("Username, Password or URL are false or the URL is not reachable!")
                }
                else{
                    
//              open HomeScreen ViewController
                                                
                }
            }
        }
        task.resume()
    }
    
    
    
    //      check if UserDefaults are empty

    
    

    @IBAction func pressmeanother(_ sender: Any) {
    }
    
    
    
}

