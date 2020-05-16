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

class Main: UIViewController {

//    Example for Global Varibales
    struct GlobalVariables {
        static let APIURL = "/index.php/apps/passwords/api/1.0"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        GetPasswords()

    }
    
    
    func GetPasswords(){
        let headers: HTTPHeaders = [
                    .authorization(username: KeychainWrapper.standard.string(forKey: "LoginUsername")!, password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),
                    .accept("application/json")
                ]
                
                AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + Main.GlobalVariables.APIURL + "/password/list", headers: headers).responseJSON { response in
        //            debugPrint(response)
                    switch response.result {
                        
                    case.success(let value):
                        let json = JSON(value)
                        
        //                debugPrint(json)
                        
                        let list = json.arrayValue
        //                debugPrint(list)
                        
                        let label = list.map{$0["label"].stringValue}
                        debugPrint(label)
                        
                        let id = list.map{$0["id"].stringValue}
                        debugPrint(id)
                        
                        let created = list.map{$0["created"].intValue}
                        debugPrint(created)
                        
                        let updated = list.map{$0["updated"].intValue}
                        debugPrint(updated)
                        
                        let edited = list.map{$0["edited"].intValue}
                        debugPrint(edited)
                        
                        let share = list.map{$0["share"].stringValue}
                        debugPrint(share)
                        
                        let shared = list.map{$0["shared"].boolValue}
                        debugPrint(shared)
                        
                        let revision = list.map{$0["revision"].stringValue}
                        debugPrint(revision)
                        
                        let username = list.map{$0["username"].stringValue}
                        debugPrint(username)
                        
                        let password = list.map{$0["password"].stringValue}
                        debugPrint(password)
                        
                        let notes = list.map{$0["notes"].stringValue}
                        debugPrint(notes)
                        
        //                Custom fields not provided yet
        //                let customFields =
        //                debugPrint(customFields)
                        
                        let url = list.map{$0["url"].stringValue}
                        debugPrint(url)
                        
                        let status = list.map{$0["status"].intValue}
                        debugPrint(status)
                        
                        let statusCode = list.map{$0["statusCode"].stringValue}
                        debugPrint(statusCode)
                        
                        let hash = list.map{$0["hash"].stringValue}
                        debugPrint(hash)
                        
                        let folder = list.map{$0["folder"].stringValue}
                        debugPrint(folder)
                        
                        let cseKey = list.map{$0["cseKey"].stringValue}
                        debugPrint(cseKey)
                        
                        let cseType = list.map{$0["cseType"].stringValue}
                        debugPrint(cseType)
                        
                        let sseType = list.map{$0["sseType"].stringValue}
                        debugPrint(sseType)
                        
                        let hidden = list.map{$0["hidden"].boolValue}
                        debugPrint(hidden)
                        
                        let trashed = list.map{$0["trashed"].boolValue}
                        debugPrint(trashed)
                        
                        let favorite = list.map{$0["favorite"].boolValue}
                        debugPrint(favorite)
                        
                        let editable = list.map{$0["editable"].boolValue}
                        debugPrint(editable)
                        
                        let client = list.map{$0["client"].stringValue}
                        debugPrint(client)
                        
                    case.failure(let error):
                        print(error)
                        
                    }
                }
    }
    
    
    
    //      check if UserDefaults are empty

    
    

    @IBAction func pressmeanother(_ sender: Any) {
    }
    
    
    
}

