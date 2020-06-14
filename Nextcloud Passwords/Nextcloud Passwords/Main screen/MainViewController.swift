//
//  ViewController.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 02.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift

class FolderCell: UITableViewCell {
    @IBOutlet weak var FolderLabel: UILabel!
    
    
}

class PasswordCell: UITableViewCell {
    @IBOutlet weak var passwordLabel: UILabel!
    
}


class Main: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var PasswordsTBL: UITableView!
    
    
    var FolderLabels = [String]()
    
    //    Example for Global Varibales
    struct GlobalVariables {
        static let APIURL = "/index.php/apps/passwords/api/1.0"
        static var Debug = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NCHelper.GetPasswords()
        NCHelper.GetFolder()
        RealmHelper.getDataFromRealm()
        
        PasswordsTBL.dataSource = self
        PasswordsTBL.delegate = self
        
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
        let viewcontroller = storyBoard.instantiateViewController(identifier: "SettingsTable")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRootFolders = 0
        var numberofRootPasswords = 0
        do{
            let realm = try Realm()
            let rootFolders = realm.objects(NCFolder.self).filter("parent == '00000000-0000-0000-0000-000000000000'")
            numberOfRootFolders = rootFolders.count
            for rootFolder in rootFolders{
                FolderLabels.append(rootFolder.label)
            }
        } catch let error as NSError{
            print(error)
        } // end of first do block
        
        do{
            let realm = try Realm()
            let rootPasswords = realm.objects(NCPassword.self).filter("folder == '00000000-0000-0000-0000-000000000000'")
            numberofRootPasswords = rootPasswords.count
            for rootPassword in rootPasswords{
               print("Password Label: \(rootPassword.label)")
            }
        } catch let error as NSError{
            print(error)
        } // end of first do block
        
        let numberOfRows = numberOfRootFolders + numberofRootPasswords
        print("All Rows: \(numberOfRows)")
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Folder:FolderCell = self.PasswordsTBL.dequeueReusableCell(withIdentifier: "Folder") as! FolderCell
        
        Folder.FolderLabel!.text = FolderLabels[indexPath.row]
        
        return Folder
    }
    
    
    
    
    
} // End of class Main

