//
//  ViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 02.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON
import RealmSwift

class Main: UIViewController {

    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var HiteMeButton: UIButton!
    
    //    Example for Global Varibales
    struct GlobalVariables {
        static let APIURL = "/index.php/apps/passwords/api/1.0"
        static var Debug = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NCHelper.GetPasswords()
        RealmHelper.getDataFromRealm()
        
    } // End of viewDidLoad
    
    
    
    
    //      check if UserDefaults are empty

    
    
    @IBAction func PressHomeButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "MainView")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
    
    @IBAction func PressSettingsButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "Settings")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
    
    
    @IBAction func HitMeAction(_ sender: Any) {

        deleteRealm()

    }// End of Button Hit Me Action
    
    func deleteRealm(){
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs{
            do{
                try FileManager.default.removeItem(at: URL)
            }
            catch{
                print("Realm could not deleted \(error)")
            }
        }// End of for
    }// End of function
    
    
    
    
}

