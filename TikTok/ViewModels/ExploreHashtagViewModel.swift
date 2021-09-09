//
//  ExploreHashtagViewModel.swift
//  TikTok
//
//  Created by Ling Xie on 8/14/21.
//

import Foundation
import UIKit


struct ExploreHashtagViewModel{
    let text: String
    let icon: UIImage?
    let count: Int
    let handler: (() -> Void)
}
