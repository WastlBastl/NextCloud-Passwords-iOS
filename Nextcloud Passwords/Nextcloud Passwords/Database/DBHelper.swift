//
//  DBHelper.swift
//  Nextcloud Passwords
//
//  Created by Sebastian Pollex on 22.05.20.
//  Copyright © 2020 Sebastian Pollex. All rights reserved.
//

import Foundation
import SQLite
import SQLite3

class DBHelper {

    static let dbPath: String = "NCPasswords.sqlite"
    static var db:OpaquePointer?
    
    class func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        //        Debug
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
                if Main.GlobalVariables.Debug != false {
                    print("error opening database")
                }
                return nil
            }
            else{
                if Main.GlobalVariables.Debug != false{
                    print("Successfully opened connection to database at \(dbPath)")
                }
                return db
            } // End of Else
    } // End of function openDatabase
    
    class func createTable(createTableString: String) {
      var createTableStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
          print("\nContact table created.")
        } else {
          print("\nContact table is not created.")
        }
      } else {
        print("\nCREATE TABLE statement is not prepared.")
      }
      sqlite3_finalize(createTableStatement)
    } // End of function create Table
    
    func insertPasswords(insertID: String, insertLabel: String, insertCreated: Int32, insertUpdated: Int32, insertEdited: Int32, insertShare: String, insertShared: Int32, insertRevision: String, insertUsername: String, insertPassword: String, insertNotes: String, insertUrl: String, insertStatus: Int32, insertStatusCode: String, insertHash: String, insertFolder: String, insertCSEKey: String, insertCSEType: String, insertSSEType: String, insertHidden: Int32, insertTrashed: Int32, insertFavorite: Int32, insertEditable: Int32, insertClient: String) {
        let insertStatementString = "insert into passwords (id, created, updated, edited, share, shared, revision, label, username, password, notes, url, status, statusCode, hash, folder, cseKey, cseType, sseType, hidden, trashed, favorite, editable, client) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
      var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(DBHelper.db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
            let id: String = insertID
            let label: String = insertLabel
            let created: Int32 = insertCreated
            let updated: Int32 = insertUpdated
            let edited: Int32 = insertEdited
            let share: String = insertShare
            let shared: Int32 = insertShared
            let revision: String = insertRevision
            let username: String = insertUsername
            let password: String = insertPassword
            let notes: String = insertNotes
//            let customFileds
            let url: String = insertUrl
            let status: Int32 = insertStatus
            let statusCode: String = insertStatusCode
            let hash: String = insertHash
            let folder: String = insertFolder
            let cseKey: String = insertCSEKey
            let cseType: String = insertCSEType
            let sseType: String = insertSSEType
            let hidden: Int32 = insertHidden
            let trashed: Int32 = insertTrashed
            let favorite: Int32 = insertFavorite
            let editable: Int32 = insertEditable
            let client: String = insertClient
            
            sqlite3_bind_text(insertStatement, 1, id, -1, nil)
            sqlite3_bind_text(insertStatement, 2, label, -1, nil)
            sqlite3_bind_int(insertStatement, 3, created)
            sqlite3_bind_int(insertStatement, 4, updated)
            sqlite3_bind_int(insertStatement, 5, edited)
            sqlite3_bind_text(insertStatement, 6, share, -1, nil)
            sqlite3_bind_int(insertStatement, 7, shared)
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
            sqlite3_bind_int(insertStatement, 20, hidden)
            sqlite3_bind_int(insertStatement, 21, trashed)
            sqlite3_bind_int(insertStatement, 22, favorite)
            sqlite3_bind_int(insertStatement, 23, editable)
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
    } // End of function insertPasswords


    
    
    
}



