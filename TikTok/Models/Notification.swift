//
//  Notification.swift
//  TikTok
//
//  Created by Ling Xie on 9/16/21.
//

import Foundation

struct Notification{
    let text: String
    let date: Date
    
    static func mockData() -> [Notification]{
        return Array(0...100).compactMap({
            Notification(text: "Check it out: \($0)", date: Date())
        })
    }
}
