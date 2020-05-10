//
//  Json.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 10.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import Foundation

struct NCPasswords: Codable {
    
    var id:String?
    var label:String?
    var username:String?
    var password:String?
    var url:String?
    var notes:String?
//    var customFields:String?
    var status:Int? // -> 0 = OK; 1 = user rules violated; 2 = breached
    var statusCode:String? // -> GOOD, OUTDATED, DUPLICATE, BREACHED
    var hash:String?
    var folder:String?
    var revision:String?
    var share:String?
    var cseType:String?
    var cseKey:String?
    var sseType:String?
    var client:String?
    var hidden:Bool?
    var trashed:Bool?
    var favorite:Bool?
    var editable:Bool?
    var edited:Int? // Last Edittime in Unix timestamp
    var created:Int? // Unix timestamp when the password was created
    var updated:Int? // Unix timestamp when the password was updated
    
    
}

