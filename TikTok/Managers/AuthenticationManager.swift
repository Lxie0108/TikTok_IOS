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
    
    public func signIn(with method: SignInMethod){
        
    }
    
    public func signOut(){
        
    }
    
}
