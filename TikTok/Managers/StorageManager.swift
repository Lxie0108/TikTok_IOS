//
//  StorageManager.swift
//  TikTok
//
//  Created by Ling Xie on 7/24/21.
//

import Foundation
import FirebaseStorage

final class StorageManager{
    static let shared = StorageManager()
    
    private let database = Storage.storage().reference()
    
    private init(){}
    
    public func getVideoURl(with identifier: String, completion: ([URL]) -> Void){
        
    }
    
    public func uploadVideoURL(from url:URL){
        
    }
    
}
