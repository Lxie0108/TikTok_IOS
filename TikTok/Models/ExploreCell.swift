//
//  ExploreCell.swift
//  TikTok
//
//  Created by Ling Xie on 8/14/21.
//

import Foundation

enum ExploreCell{
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hashtag(viewModel: ExploreHashtagViewModel)
    case user(viewModel: ExploreUserViewModel)
}



