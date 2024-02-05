//
//  API.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/25/22.
//

import Foundation

struct API {
    static var url = "https://tech-social-media-app.fly.dev"
}

enum ApiError: Error {
    case couldNotFetch
}

struct APIController {
    
    static let shared = APIController()
    
    func fetchProfile(for user: String) async throws -> User {
        
        let session = URLSession.shared
        
        let userQI = URLQueryItem(name: "userUUID", value: user)
        let secretQI = URLQueryItem(name: "userSecret", value: String(describing: User.current?.secret))
        var url = URL(string: "\(API.url)/userProfile")!
        url.append(queryItems: [userQI, secretQI])
        
        var request = URLRequest(url: url)
        // Add json data to the body of the request. Also clarify that this is a POST request
//        request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        let (data, response) = try await session.data(for: request)
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.couldNotFetch
        }
        
        // Decode our response data to a usable User struct
        let decoder = JSONDecoder()
        
        return try decoder.decode(User.self, from: data)
        
        
    }
}
