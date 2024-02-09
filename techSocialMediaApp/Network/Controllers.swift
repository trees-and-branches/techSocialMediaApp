//
//  Controllers.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/7/24.
//

import Foundation

enum ApiError: Error {
    case couldNotFetch
}

struct ProfileController {  // I would like to Create a generic protocol for this fetching business
    
    static let shared = ProfileController()
    
    func fetchProfile(for user: String) async throws -> Profile {
        
        let session = URLSession.shared
        
        let userQI = URLQueryItem(name: "userUUID", value: user)
        let userSecretValue = User.current?.secret.uuidString ?? "defaultSecret"
        let secretQI = URLQueryItem(name: "userSecret", value: userSecretValue)

        var url = URL(string: "\(API.url)/userProfile")!
        url.append(queryItems: [userQI, secretQI])
        
        var request = URLRequest(url: url)
        // Add json data to the body of the request. Also clarify that this is a POST request
        // request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
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
        
        return try decoder.decode(Profile.self, from: data)
        
        
    }
}
//This call will return an array of 20 posts. If no pageNumber(or 0) is passed to the call the first 20 posts ordered by most recent will be returned. To get posts after the first 20 a pageNumber must be passed. Ex. 1 would give you 21-40 and 2 would give you 41-60 and so on.

struct PostController {
    static let shared = PostController()
    
    
    // https://tech-social-media-app.fly.dev/posts?userSecret=911A6300-DC3E-4737-9C19-6943CC7D4A88&pageNumber
    func fetchPosts(for page: Int?) async throws -> [Post] {
        var pageString: String {
            if let page {
                return String(page)
            } else {
                return "0"
            }
        }
        // I am going to want to call this when the cellForRowAt method is called for the 20th(?) post // this is to enable endless scrolling
        var url = URL(string: "\(API.url)/posts")!
        let session = URLSession.shared
        
        let userSecretValue = User.current?.secret.uuidString ?? "defaultSecret"
        let secretQI = URLQueryItem(name: "userSecret", value: userSecretValue)
        let pageNumberQI = URLQueryItem(name: "pageNumber", value: pageString)
        url.append(queryItems: [secretQI, pageNumberQI])
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.couldNotFetch
        }
        
        // Decode our response data to a usable User struct
        let decoder = JSONDecoder()
        
        return try decoder.decode([Post].self, from: data)
            
        
    }
}
