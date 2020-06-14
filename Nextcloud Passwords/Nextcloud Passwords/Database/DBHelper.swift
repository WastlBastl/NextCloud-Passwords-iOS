//
//  DBHelper.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 22.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import Foundation
import RealmSwift

// Here ist the class for passwords and folder for RealmSwift


class NCPassword: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var label: String = ""
    @objc dynamic var created: Int = 0
    @objc dynamic var updated: Int = 0
    @objc dynamic var edited: Int = 0
    @objc dynamic var share: String = ""
    @objc dynamic var shared: Bool = false
    @objc dynamic var revision: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var notes: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var status: Int = 0
    @objc dynamic var statusCode: String = ""
    @objc dynamic var passwordHash: String = ""
    @objc dynamic var folder: String = ""
    @objc dynamic var cseKey: String = ""
    @objc dynamic var cseType: String = ""
    @objc dynamic var sseType: String = ""
    @objc dynamic var hidden: Bool = false
    @objc dynamic var trashed: Bool = false
    @objc dynamic var favorite: Bool = false
    @objc dynamic var editable: Bool = false
    @objc dynamic var client: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

class NCFolder: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var label: String = ""
    @objc dynamic var parent: String = ""
    @objc dynamic var created: Int = 0
    @objc dynamic var updated: Int = 0
    @objc dynamic var edited: Int = 0
    @objc dynamic var revision: String = ""
    @objc dynamic var cseType: String = ""
    @objc dynamic var cseKey: String = ""
    @objc dynamic var sseType: String = ""
    @objc dynamic var client: String = ""
    @objc dynamic var hidden: Bool = false
    @objc dynamic var trashed: Bool = false
    @objc dynamic var favorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class RealmHelper {
    
    
    class func writeToRealm(writeData: Object){
        
        do{
            let realm = try Realm()
            // Get Data from realm database
                do{
                    try realm.write{
                        realm.add(writeData, update: .modified)
                    }
                } catch let error as NSError{
                    print(error)
                } // end of second do block // write data to realm
        } catch let error as NSError{
            print(error)
        } // end of first do block // open realm
    } // End of Function writeToRealm
    
    
    
    class func getDataFromRealm(){
        do{
            let realm = try Realm()
            let test = realm.objects(NCFolder.self).filter("parent == '00000000-0000-0000-0000-000000000000' AND trashed == 0")
            for test1 in test {
                //print(test1)
            }
        } catch let error as NSError{
            print(error)
        } // end of first do block
    } // End of function getdataFromRealm
    
    
    class func deleteRealm(){
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


/*
let GetData = realm.objects(NCPassword.self).filter("id = '\(DataID)'")
let TestData = GetData.first
let ID = TestData?.id
if ID == nil{} // proof if Password Exists on Database
 
 */


