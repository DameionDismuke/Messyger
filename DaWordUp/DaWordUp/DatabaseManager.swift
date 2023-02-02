//
//  DatabaseManager.swift
//  DaWordUp
//
//  Created by Consultant on 1/30/23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
        
    }
    
    ///Inserts new user to Database ( Realtime )
    public func insertUser(with user: MessyUser) {
        database.child(user.safeEmail).setValue([
            "first_Name": user.firstName,
            "last_Name": user.lastName
        ])
    }
}

struct MessyUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePicUrl: String
    
    var safeEmail: String{
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}



