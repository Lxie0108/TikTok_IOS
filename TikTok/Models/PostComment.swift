//
//  PostComment.swift
//  TikTok
//
//  Created by Ling Xie on 8/14/21.
//

import Foundation

struct PostComment{
    let text: String
    let user: User
    let date: Date
    
    //mock comment
    static func mockComments() -> [PostComment]{
        let user = User(username:"BerryStr",
                        profilePictureURL: nil,
                        identifier: UUID().uuidString)
        var comments = [PostComment]()
        let text = [
            "This is my comment",
            "Word",
            "DogeCoin to the Moon!"
        ]
        
        for comment in text{
            comments.append(
                PostComment(
                    text: comment,
                    user: user,
                    date: Date()
                )
            )
        }
        return comments
    }
}
