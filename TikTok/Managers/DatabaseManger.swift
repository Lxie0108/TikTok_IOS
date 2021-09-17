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
    
    public func getUsername(for email: String, completion: @escaping (String?) -> Void){
        database.child("users").observeSingleEvent(of: .value){ snapshot in
            guard let users = snapshot.value as? [String: [String: Any]] else {
                completion(nil)
                return
            }
            var username: String?
            for(key, value) in users{
                if value["email"] as? String == email{
                    completion(username)
                    break
                }
            }
        }
    }
    
    public func insertPost(fileName: String, caption: String, completion: @escaping (Bool) -> Void) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }

        database.child("users").child(username).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard var value = snapshot.value as? [String: Any] else {
                completion(false)
                return
            }

            let newEntry = [
                "name": fileName,
                "caption": caption
            ]

            if var posts = value["posts"] as? [[String: Any]] {
                posts.append(newEntry)
                value["posts"] = posts
                self?.database.child("users").child(username).setValue(value) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            } else {
                value["posts"] = [newEntry]
                self?.database.child("users").child(username).setValue(value) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
        }
    }
    
    public func getNotifications(completion: @escaping ([Notification]) -> Void){
        completion(Notification.mockData())
    }
    
    public func getAllUsers(completion: ([String]) -> Void){
        
    }
    
}
