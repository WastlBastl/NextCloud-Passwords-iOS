//
//  NCHelper.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 23.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON

class NCHelper{
    
    class func GetPasswords(){
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
                            if Main.GlobalVariables.Debug != false{
                                //debugPrint(JSONGetPasswords)
                            }
                            
    //                      Parse every Password
                            for JSONGetPassword in JSONGetPasswords{
                                if Main.GlobalVariables.Debug != false{
                                    //sleep(10)
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
                                    debugPrint("Print \(share)")
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
                                
                                DBHelper.insertPasswords(insertID: id, insertLabel: label, insertCreated: created, insertUpdated: updated, insertEdited: edited, insertShare: share, insertShared: shared, insertRevision: revision, insertUsername: username, insertPassword: password, insertNotes: notes, insertUrl: url, insertStatus: status, insertStatusCode: statusCode, insertHash: hash, insertFolder: folder, insertCSEKey: cseKey, insertCSEType: cseType, insertSSEType: sseType, insertHidden: hidden, insertTrashed: trashed, insertFavorite: favorite, insertEditable: editable, insertClient: client)
                                
                            } // End of ForEach
       
                        case.failure(let error):
                            print(error)
                            
                        } // End of Switch
                    } // End of AFRequest
        } // End of GetPasswords
    
    class func GetFolder(){
        let headers: HTTPHeaders = [
            .authorization(username: KeychainWrapper.standard.string(forKey:"LoginUsername")!,
                        password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),
            .accept("application/json")
        ] // End of HTTPHeaders
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + Main.GlobalVariables.APIURL + "/folder/list", headers: headers).responseJSON { response in
            
//            debugPrint(response)
            switch response.result {
                            
            case.success(let value):
                let json = JSON(value)
                //debugPrint(json)
                
                let JSONGetFolders = json.arrayValue
                if Main.GlobalVariables.Debug != false{
                    debugPrint(JSONGetFolders)
                }
                for JSONGetFolder in JSONGetFolders{
                    if Main.GlobalVariables.Debug != false{
                        sleep(10)
                    }
                    
                    let folderLabel = JSONGetFolder["label"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderLabel)
                    }
                    
                    let folderID = JSONGetFolder["id"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderID)
                    }
                    
                    let folderParent = JSONGetFolder["parent"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderParent)
                    }
                    
                    let folderCreated = JSONGetFolder["created"].intValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderCreated)
                    }
                    
                    let folderUpdated = JSONGetFolder["updated"].intValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderUpdated)
                    }
                    
                    let folderEdited = JSONGetFolder["edited"].intValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderEdited)
                    }
                    
                    let folderRevision = JSONGetFolder["revision"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderRevision)
                    }
                    
                    let folderCSEType = JSONGetFolder["cseType"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderCSEType)
                    }
                    
                    let folderCSEKey = JSONGetFolder["cseKey"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderCSEKey)
                    }
                    
                    let folderSSEType = JSONGetFolder["sseType"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderSSEType)
                    }
                    
                    let folderClient = JSONGetFolder["client"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderClient)
                    }
                    
                    let folderHidden = JSONGetFolder["hidden"].boolValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderHidden)
                    }
                    
                    let folderTrashed = JSONGetFolder["trashed"].boolValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderTrashed)
                    }
                    
                    let folderFavorite = JSONGetFolder["favorite"].boolValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(folderFavorite)
                    }
                } // End of ForEach
                
            case.failure(let error):
                print(error)
            } // End of Switch
        } // End of AFRequest
    } // End of GetFolder
    
    class func GetTags(){
        let headers: HTTPHeaders = [.authorization(username: KeychainWrapper.standard.string(forKey:"LoginUsername")!,password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),.accept("application/json")
        ] // End of HTTPHeaders
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + Main.GlobalVariables.APIURL + "/tag/list", headers: headers).responseJSON { response in
            
            switch response.result {
                            
            case.success(let value):
                let json = JSON(value)
            
                let JSONGetTags = json.arrayValue
                if Main.GlobalVariables.Debug != false{
                    debugPrint(JSONGetTags)
                }
                for JSONGetTag in JSONGetTags{
                    if Main.GlobalVariables.Debug != false{
                        sleep(10)
                    }
                    
                    let tagID = JSONGetTag["id"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagID)
                    }
                    
                    let tagLabel = JSONGetTag["label"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagLabel)
                    }
                    
                    let tagColor = JSONGetTag["color"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagColor)
                    }
                    
                    let tagCreated = JSONGetTag["created"].intValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagCreated)
                    }
                    
                    let tagUpdated = JSONGetTag["updated"].intValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagUpdated)
                    }
                    
                    let tagEdited = JSONGetTag["edited"].intValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagEdited)
                    }
                    
                    let tagRevision = JSONGetTag["revision"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagRevision)
                    }
                    
                    let tagCSEType = JSONGetTag["cseType"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagCSEType)
                    }
                    
                    let tagCSEKey = JSONGetTag["cseKey"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagCSEKey)
                    }
                    
                    let tagSSEType = JSONGetTag["sseType"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagSSEType)
                    }
                    
                    let tagClient = JSONGetTag["client"].stringValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagClient)
                    }
                    
                    let tagHidden = JSONGetTag["hidden"].boolValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagHidden)
                    }
                    
                    let tagTrashed = JSONGetTag["trashed"].boolValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagTrashed)
                    }
                    
                    let tagFavorite = JSONGetTag["favorite"].boolValue
                    if Main.GlobalVariables.Debug != false{
                        debugPrint(tagFavorite)
                    }
                } // End of Foreach
            case.failure(let error):
                print(error)
            } // End of Switch
            
        } // End of AFRequest
    } // End of GetTags
    
    class func GeneratePassword(){
        let headers: HTTPHeaders = [.authorization(username: KeychainWrapper.standard.string(forKey:"LoginUsername")!,password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),.accept("application/json")
        ] // End of HTTPHeaders
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + Main.GlobalVariables.APIURL + "/tag/list", headers: headers).responseJSON { response in
                debugPrint(response)
        } // End of AFRequest
    } // End of GeneratePassword
    
} // End of Class

