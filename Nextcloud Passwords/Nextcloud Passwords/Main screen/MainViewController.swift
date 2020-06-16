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


// Class for the FolderCell
class FolderCell: UITableViewCell {
    @IBOutlet weak var FolderLabel: UILabel!
    
    
}

// Class for the PasswordCell
class PasswordCell: UITableViewCell {
    @IBOutlet weak var passwordLabel: UILabel!
    
}

// Class for the TableView to get Sections and Rows in Sections.
class PasswordClass {
    var SectionName: String?
    var RowName: [String?]
    var ID: [String?]
    
    init(SectionName: String, RowName: [String], ID: [String]) {
        self.SectionName = SectionName
        self.RowName = RowName
        self.ID = ID
    }
}


class Main: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var PasswordsTBL: UITableView!
    
    // Variables
    // To get the labels of the folder to put them then into PassTBL
    var FolderLabels = [String]()
    // To get the ids of the folder to put them then into PassTBL
    var FolderIDs = [String]()
    // To get the labels of the password to put them then into PassTBL
    var PasswordLabels = [String]()
    // To get the ids of the password to put them then into PassTBL
    var PasswordIDs = [String]()
    // To get sections, rows and ids
    var PassTBL = [PasswordClass]()
    
    // Global Varibales
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
        
        // Get "Root" folders from realm database
        do{
            let realm = try Realm()
            // filter for "root" folders
            let rootFolders = realm.objects(NCFolder.self).filter("parent == '00000000-0000-0000-0000-000000000000'")
            // Add folders to defined variables
            for rootFolder in rootFolders{
                FolderLabels.append(rootFolder.label)
                FolderIDs.append(rootFolder.id)
            }
        } catch let error as NSError{
            print(error)
        } // end of first do block
        
        // get passwords in "root" view on nextcloud password
        do{
            let realm = try Realm()
            // filter for passwords
            let rootPasswords = realm.objects(NCPassword.self).filter("folder == '00000000-0000-0000-0000-000000000000'")
            // Add passwords to defined variables
            for rootPassword in rootPasswords{
                PasswordLabels.append(rootPassword.label)
                PasswordIDs.append(rootPassword.id)
            }
        } catch let error as NSError{
            print(error)
        } // end of first do block
        
        // add data to PassTBL
        PassTBL.append(PasswordClass.init(SectionName: "Folder", RowName: FolderLabels, ID: FolderIDs))
        PassTBL.append(PasswordClass.init(SectionName: "Password", RowName: PasswordLabels, ID: PasswordIDs))
    
    } // End of viewDidLoad
    
    
    
    
    //      check if UserDefaults are empty

    
    // Press HomeButton to get to the MainView
    @IBAction func PressHomeButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "MainView")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
    
    // Press SettingsButton to get to the SettingsView/SettingsTable
    @IBAction func PressSettingsButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "SettingsTable")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
    
    // Get number of sections from PassTBL
    func numberOfSections(in tableView: UITableView) -> Int {
        return PassTBL.count
    }
    
    // Get number of Rows in Section from PassTBL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PassTBL[section].RowName.count
    }
    
    // Define which cell is shown for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // custom cell for Folders
            let Folder:FolderCell = self.PasswordsTBL.dequeueReusableCell(withIdentifier: "Folder") as! FolderCell
            Folder.FolderLabel!.text = PassTBL[indexPath.section].RowName[indexPath.row]
            return Folder
        }
        else {
            // custom cell for Passwords
            let Password:PasswordCell = self.PasswordsTBL.dequeueReusableCell(withIdentifier: "Password") as! PasswordCell
            Password.passwordLabel!.text = PassTBL[indexPath.section].RowName[indexPath.row]
            return Password
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Something \(indexPath.section)")
        }
        else{
            // Create String for PasswordID to search in Database
            // Get ID of row when tapped and replace some Strings.
            let str = "\(String(describing: PassTBL[indexPath.section].ID[indexPath.row]))"
            let replace = str.replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "'")

            // Open DB Connection, filter for Password ID and copy them to clipboard
            do{
                let realm = try Realm()
                let PasswordObject = realm.objects(NCPassword.self).filter("id == \(replace)")
                //Copy to clipboard
                UIPasteboard.general.string = PasswordObject.first?.password.replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "") ?? ""
            } catch let error as NSError{
                print(error)
            } // end of first do block
        }
    }
    
    
    
    
    
} // End of class Main

