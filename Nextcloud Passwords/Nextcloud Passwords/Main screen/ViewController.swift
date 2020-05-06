//
//  ViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 02.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit

class Main: UIViewController {

    struct GlobalVariables {
        static let loginDefaults = UserDefaults.standard
    }
    
    
    @IBOutlet weak var URL: UILabel!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Password: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressmeanother(_ sender: Any) {
   
        let Username_Print = Main.GlobalVariables.loginDefaults.string(forKey: "DefaultsUsername")
        let Password_Print = Main.GlobalVariables.loginDefaults.string(forKey: "DefaultsPassword")
        let URL_Print = Main.GlobalVariables.loginDefaults.string(forKey: "DefaultsURL")
        
        Username.text = Username_Print
        Password.text = Password_Print
        URL.text = URL_Print
        
    }
    
    
    
}

