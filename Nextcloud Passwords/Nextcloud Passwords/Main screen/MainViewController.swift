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
        static var Debug = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetPasswords()

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
                        
                        let JSONGetPasswords = json.arrayValue
//                        if Main.GlobalVariables.Debug != false{
//                            debugPrint(JSONGetPasswords)
//                        }
                        
//                      Parse every Password
                        for JSONGetPassword in JSONGetPasswords{
                            if Main.GlobalVariables.Debug != false{
                                sleep(10)
                            }
                            
                            let label = JSONGetPassword["label"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(label)
                            }
                            
                            let id = JSONGetPassword["id"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(id)
                            }
                            
                            let created = JSONGetPassword["created"].intValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(created)
                            }
                            
                            let updated = JSONGetPassword["updated"].intValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(updated)
                            }
                            
                            let edited = JSONGetPassword["edited"].intValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(edited)
                            }
                            
                            let share = JSONGetPassword["share"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(share)
                            }
                            
                            let shared = JSONGetPassword["shared"].boolValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(shared)
                            }
                            
                            let revision = JSONGetPassword["revision"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(revision)
                            }
                            
                            let username = JSONGetPassword["username"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(username)
                            }
                            
                            let password = JSONGetPassword["password"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(password)
                            }
                            
                            let notes = JSONGetPassword["notes"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(notes)
                            }
                            
//        //                Custom fields not provided yet
//        //                let customFields =
//                        if Main.GlobalVariables.Debug != false{
//        //                  debugPrint(customFields)
//                        }
                            
                            let url = JSONGetPassword["url"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(url)
                            }
                            
                            let status = JSONGetPassword["status"].intValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(status)
                            }
                            
                            let statusCode = JSONGetPassword["statusCode"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(statusCode)
                            }
                            
                            let hash = JSONGetPassword["hash"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(hash)
                            }
                            
                            let folder = JSONGetPassword["folder"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(folder)
                            }
                            
                            let cseKey = JSONGetPassword["cseKey"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(cseKey)
                            }
                            
                            let cseType = JSONGetPassword["cseType"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(cseType)
                            }
                            
                            let sseType = JSONGetPassword["sseType"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(sseType)
                            }
                            
                            let hidden = JSONGetPassword["hidden"].boolValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(hidden)
                            }
                            
                            let trashed = JSONGetPassword["trashed"].boolValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(trashed)
                            }
                            
                            let favorite = JSONGetPassword["favorite"].boolValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(favorite)
                            }
                            
                            let editable = JSONGetPassword["editable"].boolValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(editable)
                            }
                            
                            let client = JSONGetPassword["client"].stringValue
                            if Main.GlobalVariables.Debug != false{
                                debugPrint(client)
                            }
                        }
   
                    case.failure(let error):
                        print(error)
                        
                    }
                }
    }
    
    
    //      check if UserDefaults are empty

    
    

    @IBAction func pressmeanother(_ sender: Any) {
    }
    
    
    
}

