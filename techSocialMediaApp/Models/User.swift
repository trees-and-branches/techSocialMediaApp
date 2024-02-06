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
    var userUUID: UUID
    var secret: UUID
    var userName: String
    
    static var current: User?
    
    init(firstName: String, lastName: String, email: String, user: String, secret: String, userName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userUUID = UUID(uuidString: user)!
        self.secret = UUID(uuidString: secret)!
        self.userName = userName
    }
}


let meUser = User(firstName: "Evan", lastName: "Ochoa", email: "EVAN.OCHOA4872@STU.MTEC.EDU", user: "EE9E0B40-791B-4730-B783-0B2B8C09AB20", secret:"911A6300-DC3E-4737-9C19-6943CC7D4A88", userName: "EvanOchoa")
