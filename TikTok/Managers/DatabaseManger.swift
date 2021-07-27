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
    
    public func getAllUsers(completion: ([String]) -> Void){
        
    }
    
}
