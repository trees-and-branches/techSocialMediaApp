//
//  User.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/25/22.
//

import Foundation

struct User: Decodable, Encodable {
    var firstName: String
    var lastName: String
    var email: String
    var userUUID: String
    var secret: String
    var userName: String
    
    static var current: User?
    
    init(firstName: String, lastName: String, email: String, userUUID: String, secret: String, userName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userUUID = userUUID
        self.secret = secret
        self.userName = userName
    }
}


