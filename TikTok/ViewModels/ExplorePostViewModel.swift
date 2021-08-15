//
//  ExplorePostViewModel.swift
//  TikTok
//
//  Created by Ling Xie on 8/14/21.
//

import Foundation
import UIKit


struct ExplorePostViewModel{
    let thumbnailImage: UIImage?
    let title: String
    let handler: (() -> Void)
}
