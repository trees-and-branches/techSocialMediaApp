//
//  Post.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/6/24.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String?
    let authorUserName: String
    let authorID: UUID
    let createdDate: String
    
    var userLiked: Bool
    var numOfComments: Int
    
}

struct Posts: Codable {
    var posts: [Post] // am i doing this right? Make sure this works with profile's posts property
}
