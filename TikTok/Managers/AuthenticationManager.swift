//
//  AuthenticationManager.swift
//  TikTok
//
//  Created by Ling Xie on 7/24/21.
//

import Foundation
import FirebaseAuth

final class AuthManager{
    static let shared = AuthManager()
    
    private init(){}
    
    enum SignInMethod{
        case email
        case facebook
        case google
    }
    
    public var isSignedIn: Bool{
        return Auth.auth().currentUser != nil
    }
    
    public func signIn(with email: String, password: String, completion: @escaping(Bool) -> Void){
        
    }
    
    public func signUp(with usermake: String, emailAddress: String, password: String, completion: @escaping(Bool) -> Void){
        
    }
    
    public func signOut(completion: (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch{
            print(error)
            completion(false)
        }
    }
    
}
