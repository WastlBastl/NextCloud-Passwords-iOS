//
//  NCHelper.swift
//  Nextcloud
//
//  Created by Sebastian Pollex on 19.12.20.
//

import Foundation
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON
import RealmSwift


class NCHelper{
    
    class func GetPasswords(){
            let headers: HTTPHeaders = [
                        .authorization(username: KeychainWrapper.standard.string(forKey: "LoginUsername")!, password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),
                        .accept("application/json")
                    ]
                    
                    AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + LoginViewController.GlobalVariables.APIURL + "/password/list", headers: headers).responseJSON { response in
            //            debugPrint(response)
                        switch response.result {
                            
                        case.success(let value):
                            let json = JSON(value)
                            
            //                debugPrint(json)
                            
                            let JSONGetPasswords = json.arrayValue
                        
                            
    //                      Parse every Password
                            for JSONGetPassword in JSONGetPasswords{
                                
                                
                                let label = JSONGetPassword["label"].stringValue
                                
                                
                                let id = JSONGetPassword["id"].stringValue
                                
                                let created = JSONGetPassword["created"].intValue
                                
                                let updated = JSONGetPassword["updated"].intValue
                                
                                let edited = JSONGetPassword["edited"].intValue
                                
                                let share = JSONGetPassword["share"].stringValue
                                
                                let shared = JSONGetPassword["shared"].boolValue
                                
                                let revision = JSONGetPassword["revision"].stringValue
                                
                                let username = JSONGetPassword["username"].stringValue
                                
                                let password = JSONGetPassword["password"].stringValue
                                
                                let notes = JSONGetPassword["notes"].stringValue
                                
    //        //                Custom fields not provided yet
    //        //                let customFields =
    //                        if Main.GlobalVariables.Debug != false{
    //        //                  debugPrint(customFields)
    //                        }
                                
                                let url = JSONGetPassword["url"].stringValue
                                
                                let status = JSONGetPassword["status"].intValue
                                
                                let statusCode = JSONGetPassword["statusCode"].stringValue
                                
                                let hash = JSONGetPassword["hash"].stringValue
                                
                                let folder = JSONGetPassword["folder"].stringValue
                                
                                let cseKey = JSONGetPassword["cseKey"].stringValue
                                
                                let cseType = JSONGetPassword["cseType"].stringValue
                                
                                let sseType = JSONGetPassword["sseType"].stringValue
                                
                                let hidden = JSONGetPassword["hidden"].boolValue
                                
                                let trashed = JSONGetPassword["trashed"].boolValue
                                
                                let favorite = JSONGetPassword["favorite"].boolValue
                                
                                let editable = JSONGetPassword["editable"].boolValue
                                
                                let client = JSONGetPassword["client"].stringValue
                                
                                let myPassword = NCPassword()
                                myPassword.id = id
                                myPassword.label = label
                                myPassword.created = created
                                myPassword.updated = updated
                                myPassword.edited = edited
                                myPassword.share = share
                                myPassword.shared = shared
                                myPassword.revision = revision
                                myPassword.username = username
                                myPassword.password = password
                                myPassword.notes = notes
                                myPassword.url = url
                                myPassword.status = status
                                myPassword.statusCode = statusCode
                                myPassword.passwordHash = hash
                                myPassword.folder = folder
                                myPassword.cseKey = cseKey
                                myPassword.cseType = cseType
                                myPassword.sseType = sseType
                                myPassword.hidden = hidden
                                myPassword.trashed = trashed
                                myPassword.favorite = favorite
                                myPassword.editable = editable
                                myPassword.client = client
                                
                                RealmHelper.writeToRealm(writeData: myPassword)
                                
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
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + LoginViewController.GlobalVariables.APIURL + "/folder/list", headers: headers).responseJSON { response in
            
//            debugPrint(response)
            switch response.result {
                            
            case.success(let value):
                let json = JSON(value)
                //debugPrint(json)
                
                let JSONGetFolders = json.arrayValue
                
                for JSONGetFolder in JSONGetFolders{
                    
                    let folderLabel = JSONGetFolder["label"].stringValue
                    
                    let folderID = JSONGetFolder["id"].stringValue
                    
                    let folderParent = JSONGetFolder["parent"].stringValue
                    
                    let folderCreated = JSONGetFolder["created"].intValue
                    
                    let folderUpdated = JSONGetFolder["updated"].intValue
                    
                    let folderEdited = JSONGetFolder["edited"].intValue
                    
                    let folderRevision = JSONGetFolder["revision"].stringValue
                    
                    let folderCSEType = JSONGetFolder["cseType"].stringValue
                    
                    let folderCSEKey = JSONGetFolder["cseKey"].stringValue
                    
                    let folderSSEType = JSONGetFolder["sseType"].stringValue
                    
                    let folderClient = JSONGetFolder["client"].stringValue
                    
                    let folderHidden = JSONGetFolder["hidden"].boolValue
                    
                    let folderTrashed = JSONGetFolder["trashed"].boolValue
                    
                    let folderFavorite = JSONGetFolder["favorite"].boolValue
                    
                    let myFolder = NCFolder()
                    myFolder.id = folderID
                    myFolder.label = folderLabel
                    myFolder.parent = folderParent
                    myFolder.created = folderCreated
                    myFolder.updated = folderUpdated
                    myFolder.edited = folderEdited
                    myFolder.revision = folderRevision
                    myFolder.cseType = folderCSEKey
                    myFolder.cseKey = folderCSEKey
                    myFolder.sseType = folderSSEType
                    myFolder.client = folderClient
                    myFolder.hidden = folderHidden
                    myFolder.trashed = folderTrashed
                    myFolder.favorite = folderFavorite
                    
                    RealmHelper.writeToRealm(writeData: myFolder)
                    
                } // End of ForEach
                
            case.failure(let error):
                print(error)
            } // End of Switch
        } // End of AFRequest
    } // End of GetFolder
    
    class func GetTags(){
        let headers: HTTPHeaders = [.authorization(username: KeychainWrapper.standard.string(forKey:"LoginUsername")!,password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),.accept("application/json")
        ] // End of HTTPHeaders
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + LoginViewController.GlobalVariables.APIURL + "/tag/list", headers: headers).responseJSON { response in
            
            switch response.result {
                            
            case.success(let value):
                let json = JSON(value)
            
                let JSONGetTags = json.arrayValue
                
                for JSONGetTag in JSONGetTags{
                    
                    let tagID = JSONGetTag["id"].stringValue
                    
                    let tagLabel = JSONGetTag["label"].stringValue
                    
                    let tagColor = JSONGetTag["color"].stringValue
                    
                    let tagCreated = JSONGetTag["created"].intValue
                    
                    let tagUpdated = JSONGetTag["updated"].intValue
                    
                    let tagEdited = JSONGetTag["edited"].intValue
                    
                    let tagRevision = JSONGetTag["revision"].stringValue
                    
                    let tagCSEType = JSONGetTag["cseType"].stringValue
                    
                    let tagCSEKey = JSONGetTag["cseKey"].stringValue
                    
                    let tagSSEType = JSONGetTag["sseType"].stringValue
                    
                    let tagClient = JSONGetTag["client"].stringValue
                    
                    let tagHidden = JSONGetTag["hidden"].boolValue
                    
                    let tagTrashed = JSONGetTag["trashed"].boolValue
                    
                    let tagFavorite = JSONGetTag["favorite"].boolValue
                } // End of Foreach
            case.failure(let error):
                print(error)
            } // End of Switch
            
        } // End of AFRequest
    } // End of GetTags
    
    class func GeneratePassword(){
        let headers: HTTPHeaders = [.authorization(username: KeychainWrapper.standard.string(forKey:"LoginUsername")!,password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),.accept("application/json")
        ] // End of HTTPHeaders
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + LoginViewController.GlobalVariables.APIURL + "/tag/list", headers: headers).responseJSON { response in
                debugPrint(response)
        } // End of AFRequest
    } // End of GeneratePassword

    
    
} // End of Class
