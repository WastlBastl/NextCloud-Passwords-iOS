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
    
    
    var FolderLabels = [String]()
    var FolderIDs = [String]()
    var PasswordLabels = [String]()
    var PasswordIDs = [String]()
    var PassTBL = [PasswordClass]()
    
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
        
        do{
            let realm = try Realm()
            let rootFolders = realm.objects(NCFolder.self).filter("parent == '00000000-0000-0000-0000-000000000000'")
            for rootFolder in rootFolders{
                FolderLabels.append(rootFolder.label)
                FolderIDs.append(rootFolder.id)
            }
        } catch let error as NSError{
            print(error)
        } // end of first do block
        
        do{
            let realm = try Realm()
            let rootPasswords = realm.objects(NCPassword.self).filter("folder == '00000000-0000-0000-0000-000000000000'")
            for rootPassword in rootPasswords{
                PasswordLabels.append(rootPassword.label)
                PasswordIDs.append(rootPassword.id)
            }
        } catch let error as NSError{
            print(error)
        } // end of first do block
        
        PassTBL.append(PasswordClass.init(SectionName: "Folder", RowName: FolderLabels, ID: FolderIDs))
        PassTBL.append(PasswordClass.init(SectionName: "Password", RowName: PasswordLabels, ID: PasswordIDs))
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PassTBL.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PassTBL[section].RowName.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let Folder:FolderCell = self.PasswordsTBL.dequeueReusableCell(withIdentifier: "Folder") as! FolderCell
            Folder.FolderLabel!.text = PassTBL[indexPath.section].RowName[indexPath.row]
            return Folder
        }
        else {
            let Password:PasswordCell = self.PasswordsTBL.dequeueReusableCell(withIdentifier: "Password") as! PasswordCell
            Password.passwordLabel!.text = PassTBL[indexPath.section].RowName[indexPath.row]
            return Password
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*if SettingsTBL[indexPath.section].RowName[indexPath.row] == "Log out"{
            KeychainWrapper.standard.set("", forKey: "LoginURL")
            KeychainWrapper.standard.set("", forKey: "LoginUsername")
            KeychainWrapper.standard.set("", forKey: "LoginPassword")
            RealmHelper.deleteRealm()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewcontroller = storyBoard.instantiateViewController(identifier: "LoginViewController")
            viewcontroller.modalPresentationStyle = .fullScreen
            self.present(viewcontroller, animated: false)
        }
        else{
            if let url = URL(string: SettingsTBL[indexPath.section].RowURLs[indexPath.row]!) {
                UIApplication.shared.open(url)
            } // End of if
         }*/
        if indexPath.section == 0 {
            print("Something \(indexPath.section)")
        }
        else{
            UIPasteboard.general.string = "Hello world"
            print("Print \(String(describing: PassTBL[indexPath.section].ID[indexPath.row]))")
            
            do{
                let realm = try Realm()
                let PasswordObject = realm.objects(NCPassword.self).filter("folder == \(String(describing: PassTBL[indexPath.section].ID[indexPath.row]))") // Got an error
                print(PasswordObject)
            } catch let error as NSError{
                print(error)
            } // end of first do block
        }
    }
    
    
    
    
    
} // End of class Main

