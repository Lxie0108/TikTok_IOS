//
//  ExploreSectionType.swift
//  TikTok
//
//  Created by Ling Xie on 8/14/21.
//

import Foundation

enum ExploreSectionType{
    case banners
    case users
    case trendingPosts
    case trendingHashtags
    case recommended
    case popular
    case new
    
    var title: String{
        switch self{
        case .banners:
            return "Featured"
        case .trendingPosts:
            return "Trending Videos"
        case .trendingHashtags:
            return "Hashtags"
        case .recommended:
            return"Recommended"
        case .popular:
            return "Popular"
        case .new:
            return "New"
        case .users:
            return "Creators"
            
        }
    }
}
