//
//  Profile.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/6/24.
//

import Foundation

struct Profile: Codable {
    var firstName: String
    var lastName: String
    var userName: String
    var userUUID: UUID
    var bio: String?
    var techInterests: String?
//    var posts: Posts? // this may need to be fixed.
}

struct ProfileResponse: Codable {
    let success: Bool
}

