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
    var likes: Int
    var userLiked: Bool
    var numOfComments: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id = "postid"
        case title
        case body
        case authorUserName
        case authorID = "authorUserId"
        case createdDate
        case likes
        case userLiked = "userLiked"
        case numOfComments = "numComments"
    }
}



//struct Posts: Codable {
//    var posts: [Post] // am i doing this right? Make sure this works with profile's posts property
//}
