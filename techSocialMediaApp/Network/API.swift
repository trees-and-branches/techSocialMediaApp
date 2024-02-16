//
//  API.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/25/22.
//

import Foundation

struct API {
    static var url = "https://tech-social-media-app.fly.dev"
    
    
    
//    let userSecretValue = User.current?.secret.uuidString ?? "defaultSecret"
//    let secretQI = URLQueryItem(name: "userSecret", value: userSecretValue)
//
    // I want to make this a static variable so I don't have to repeat it in all of my methods
    
    //TODO: DO THIS
}

enum ApiError: Error, LocalizedError {
   case couldNotFetch
   case couldNotPost
   case couldNotDelete
}


