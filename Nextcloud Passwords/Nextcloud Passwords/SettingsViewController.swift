//
//  SettingsViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 22.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SettingsViewController: UIViewController {


    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var LogOutButton: UIButton!
    @IBOutlet weak var DonateButton: UIButton!
    @IBOutlet weak var RateButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var ReportABugButton: UIButton!
    
    let animals: [String] = ["Horse", "cow", "Camel", "Sheep", "Goat"]
    let celReuseIdentifier = "cell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        LogOutButton.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    } // End of function viewDidLoad

    @IBAction func PressHomeButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "MainView")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    } // End of function PressHomebutton
    
    @IBAction func PressLogOutButton(_ sender: Any) {
        KeychainWrapper.standard.set("", forKey: "LoginURL")
        KeychainWrapper.standard.set("", forKey: "LoginUsername")
        KeychainWrapper.standard.set("", forKey: "LoginPassword")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "LoginViewController")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    } // End of function PressLogOutButton
    @IBAction func PressReportABugButton(_ sender: Any) {
        if let url = URL(string: "https://github.com/WastlBastl/NextCloud-Passwords-iOS/issues") {
            UIApplication.shared.open(url)
        } // End of if
    } // End of Function PressReportABugButton
    
@IBAction func PressDonateButton(_ sender: Any) {
        if let url = URL(string: "https://paypal.me/wastlbastl?locale.x=de_DE") {
            UIApplication.shared.open(url)
        } // End of if
    } // End of function PressDonateButton
    
    @IBAction func PressFavoriteButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "SettingsTable")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
} // End of class
