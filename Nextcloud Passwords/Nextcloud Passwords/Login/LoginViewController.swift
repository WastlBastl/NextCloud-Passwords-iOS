//
//  LoginViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 04.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginURLTextField: UITextField!
    @IBOutlet weak var loginUsernameTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func loginTapped(_ sender: Any) {
        
//       Get URL from loginURLTextField
//        var NCUrl: String = loginURLTextField.text!
//        Get Username from loginUsernameTextField
//        var NCUsername: String = loginUsernameTextField.text!
//      Get Password from loginUsernamePasswordField
//        var NCPassword: String = loginPasswordTextField.text!
    
        
        Main.GlobalVariables.loginDefaults.set(loginUsernameTextField.text, forKey: "DefaultsUsername")
        Main.GlobalVariables.loginDefaults.set(loginPasswordTextField.text, forKey: "DefaultsPassword")
        Main.GlobalVariables.loginDefaults.set(loginURLTextField.text, forKey: "DefaultsURL")
        
//        print(NCUrl, NCUsername, NCPassword)
        
        
// Tastatur lässt sich nicht minimieren im Login Screen am iPhone!! Dies muss geändert werden.
        
    }
    
    
    
}
