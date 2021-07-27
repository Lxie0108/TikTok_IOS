//
//  PostModel.swift
//  TikTok
//
//  Created by Ling Xie on 7/27/21.
//

import Foundation

struct PostModel {
    let identifier: String
    
    static func mockModels() -> [PostModel]{
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(identifier:  UUID().uuidString)
            posts.append(post)
        }
        return posts
    }
}
