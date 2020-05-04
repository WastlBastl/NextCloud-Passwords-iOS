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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginTapped(_ sender: Any) {
        
//       Get URL from loginURLTextField
        var NCUrl: String = loginURLTextField.text!
//        Get Username from loginUsernameTextField
        var NCUsername: String = loginUsernameTextField.text!
//      Get Password from loginUsernamePasswordField
        var NCPassword: String = loginPasswordTextField.text!
        
        print(NCUrl, NCUsername, NCPassword)
        
    }
    
    
    
}
