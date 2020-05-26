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
import SQLite
import SQLite3

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
                                
                                let created = JSONGetPassword["created"].int32Value
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(created)
                                }
                                
                                let updated = JSONGetPassword["updated"].int32Value
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(updated)
                                }
                                
                                let edited = JSONGetPassword["edited"].int32Value
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(edited)
                                }
                                
                                let share = JSONGetPassword["share"].stringValue
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint("Print \(share)")
                                }
                                
                                var sharedINT: Int32
                                let shared = JSONGetPassword["shared"].boolValue
                                // Convert Bool to INT
                                if shared == false {
                                    sharedINT = 0
                                }
                                else{
                                    sharedINT = 1
                                }
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
                                
                                let status = JSONGetPassword["status"].int32Value
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
                                
                                var hiddenINT: Int32
                                let hidden = JSONGetPassword["hidden"].boolValue
                                // Convert Bool to INT
                                if hidden == false {
                                    hiddenINT = 0
                                }
                                else{
                                    hiddenINT = 1
                                }
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(hidden)
                                }
                                
                                var trashedINT: Int32
                                let trashed = JSONGetPassword["trashed"].boolValue
                                if trashed == false {
                                    trashedINT = 0
                                }
                                else{
                                    trashedINT = 1
                                }
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(trashed)
                                    debugPrint(trashedINT)
                                }
                                
                                var favoriteINT: Int32
                                let favorite = JSONGetPassword["favorite"].boolValue
                                // Convert Bool to INT
                                if favorite == false {
                                    favoriteINT = 0
                                }
                                else{
                                    favoriteINT = 1
                                }
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(favorite)
                                }
                                
                                var editableINT: Int32
                                let editable = JSONGetPassword["editable"].boolValue
                                // Convert Bool to INT
                                if editable == false {
                                    editableINT = 0
                                }
                                else{
                                    editableINT = 1
                                }
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(editable)
                                }
                                
                                let client = JSONGetPassword["client"].stringValue
                                if Main.GlobalVariables.Debug != false{
                                    debugPrint(client)
                                }
                                
                                let insertStatementString = "insert into passwords (id, created, updated, edited, share, shared, revision, label, username, password, notes, url, status, statusCode, hash, folder, cseKey, cseType, sseType, hidden, trashed, favorite, editable, client) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
                                var insertStatement: OpaquePointer?
                                if sqlite3_prepare_v2(DBHelper.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                                            
                                    sqlite3_bind_text(insertStatement, 1, id, -1, nil)
                                    sqlite3_bind_text(insertStatement, 2, label, -1, nil)
                                    sqlite3_bind_int(insertStatement, 3, created)
                                    sqlite3_bind_int(insertStatement, 4, updated)
                                    sqlite3_bind_int(insertStatement, 5, edited)
                                    sqlite3_bind_text(insertStatement, 6, share, -1, nil)
                                    sqlite3_bind_int(insertStatement, 7, sharedINT)
                                    sqlite3_bind_text(insertStatement, 8, revision, -1, nil)
                                    sqlite3_bind_text(insertStatement, 9, username, -1, nil)
                                    sqlite3_bind_text(insertStatement, 10, password, -1, nil)
                                    sqlite3_bind_text(insertStatement, 11, notes, -1, nil)
                                    sqlite3_bind_text(insertStatement, 12, url, -1, nil)
                                    sqlite3_bind_int(insertStatement, 13, status)
                                    sqlite3_bind_text(insertStatement, 14, statusCode, -1, nil)
                                    sqlite3_bind_text(insertStatement, 15, hash, -1, nil)
                                    sqlite3_bind_text(insertStatement, 16, folder, -1, nil)
                                    sqlite3_bind_text(insertStatement, 17, cseKey, -1, nil)
                                    sqlite3_bind_text(insertStatement, 18, cseType, -1, nil)
                                    sqlite3_bind_text(insertStatement, 19, sseType, -1, nil)
                                    sqlite3_bind_int(insertStatement, 20, hiddenINT)
                                    sqlite3_bind_int(insertStatement, 21, trashedINT)
                                    sqlite3_bind_int(insertStatement, 22, favoriteINT)
                                    sqlite3_bind_int(insertStatement, 23, editableINT)
                                    sqlite3_bind_text(insertStatement, 24, client, -1, nil)
                                            
                                    if sqlite3_step(insertStatement) == SQLITE_DONE {
                                          print("\nSuccessfully inserted row.")
                                    } else {
                                          print("\nCould not insert row.")
                                    }
                                    } else {
                                        print("\nINSERT statement is not prepared.")
                                    }
                                sqlite3_finalize(insertStatement)
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
//                        sleep(10)
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


