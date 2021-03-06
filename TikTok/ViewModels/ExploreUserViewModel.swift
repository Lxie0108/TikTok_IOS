//
//  ExploreUserViewModel.swift
//  TikTok
//
//  Created by Ling Xie on 8/14/21.
//

import Foundation
import UIKit


struct ExploreUserViewModel{
    let profilePicture: UIImage?
    let username: String
    let followerCount: Int
    let handler: (() -> Void)
}
