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

    static let dbPath: String = "myDb.sqlite"
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
            }
    }
    
    class func createTable(createTableString: String) {
      // 1
      var createTableStatement: OpaquePointer?
      // 2
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        // 3
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
          print("\nContact table created.")
        } else {
          print("\nContact table is not created.")
        }
      } else {
        print("\nCREATE TABLE statement is not prepared.")
      }
      // 4
      sqlite3_finalize(createTableStatement)
    }
    
    /*func insertTable(insertStatementString: String) {
      var insertStatement: OpaquePointer?
      // 1
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
//        let id: Int32 = 1
//        let name: NSString = "Ray"
        // 2
        sqlite3_bind_int(insertStatement, 1, id)
        // 3
        sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
        // 4
        if sqlite3_step(insertStatement) == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
        } else {
          print("\nCould not insert row.")
        }
      } else {
        print("\nINSERT statement is not prepared.")
      }
      // 5
      sqlite3_finalize(insertStatement)
    }
 */

    
    
    
}



