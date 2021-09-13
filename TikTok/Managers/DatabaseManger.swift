//
//  DatabaseManger.swift
//  TikTok
//
//  Created by Ling Xie on 7/24/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    private init(){}
    
    public func insertUsers(with email: String, username: String, completion: @escaping(Bool) -> Void){
        //users : (key: usernamme) -> email, posts
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            guard var usersDic = snapshot.value as? [String: Any] else{
                //create new user
                self.database.child("users").setValue(
                    [
                        username: [
                            "email": email
                        ]
                    ]
                ) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
                return
            }
            usersDic[username] = ["email": email]
            self.database.child("users").setValue(usersDic, withCompletionBlock: { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
        }
    }
    
    public func getAllUsers(completion: ([String]) -> Void){
        
    }
    
}
