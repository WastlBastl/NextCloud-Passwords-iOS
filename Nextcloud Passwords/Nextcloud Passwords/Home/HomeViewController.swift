//
//  HomeViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 04.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var Usernmae: UILabel!
    @IBOutlet weak var URL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressmebutton(_ sender: Any) {
        
        let Username_Print = LoginViewController.GlobalVariables.loginUsernameDefaults.string(forKey: "DefaultsUsername")
        let Password_Print = LoginViewController.GlobalVariables.loginPasswordDefaults.string(forKey: "DefaultsPassword")
        let URL_Print = LoginViewController.GlobalVariables.loginURLDefaults.string(forKey: "DefaultsURL")
        
        Usernmae.text = Username_Print
        Password.text = Password_Print
        URL.text = URL_Print
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
