//
//  SettingsTable.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 09.06.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SettingsClass {
    var SectionName: String?
    var RowName: [String?]
    var RowURLs: [String?]
    
    init(SectionName: String, RowName: [String], RowURLs: [String]) {
        self.SectionName = SectionName
        self.RowName = RowName
        self.RowURLs = RowURLs
    }
}

class SettingsTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TblSettings: UITableView!
    @IBOutlet weak var SettingsLabel: UILabel!
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    
    
    var SettingsTBL = [SettingsClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TblSettings.dataSource = self
        TblSettings.delegate = self
        
        SettingsTBL.append(SettingsClass.init(SectionName: "Support", RowName: ["Donate this app","Rate this app","Share this app", "Report a bug"], RowURLs: ["https://paypal.me/wastlbastl?locale.x=de_DE", "https://google.com", "https://youtube.de", "https://github.com/WastlBastl/NextCloud-Passwords-iOS/issues"]))
        SettingsTBL.append(SettingsClass.init(SectionName: "Disconnection", RowName: ["Log out"], RowURLs: ["placeholder"]))
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsTBL.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsTBL[section].RowName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = SettingsTBL[indexPath.section].RowName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SettingsTBL[indexPath.section].RowName[indexPath.row] == "Log out"{
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
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingsTBL[section].SectionName
    }
    
    
    @IBAction func PressHomeButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "MainView")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
    @IBAction func PressFavoriteButton(_ sender: Any) {
    }
    @IBAction func PressSettingsButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "SettingsTable")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: false)
    }
    
    
    

}
