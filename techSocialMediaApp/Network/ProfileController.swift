//
//  Controllers.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/7/24.
//

import Foundation


struct ProfileController {  // I would like to Create a generic protocol for this fetching business
    
    static let shared = ProfileController()
    
    func fetchProfile(for userID: String) async throws -> Profile {
        
        let session = URLSession.shared
        
        let userQI = URLQueryItem(name: "userUUID", value: userID)
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
    
    func updateProfile(for profile: Profile) async throws { // TODO: find out why the nil coalescing isnt working here
        guard let user = User.current else { return }
        let url = URL(string: "\(API.url)/updateProfile")!
        let session = URLSession.shared
        
        let userSecretValue = user.secret.uuidString 
        
        var request = URLRequest(url: url)
        
        let httpbody: [String: Any] = [ "userSecret" : userSecretValue , "profile": [ "userName": String(profile.userName), "bio": String(profile.bio ?? "default bio"), "techInterests": String(profile.techInterests ?? "default techInterests")]]
        
        print(httpbody)
        
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: httpbody, options: .prettyPrinted)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.couldNotPost
        }
        
        let decoder = JSONDecoder()
        
        let decodedResponse = try decoder.decode(ProfileResponse.self, from: data)
        
        print("decodedResponse: \(decodedResponse)")
        
    }
    
}
//This call will return an array of 20 posts. If no pageNumber(or 0) is passed to the call the first 20 posts ordered by most recent will be returned. To get posts after the first 20 a pageNumber must be passed. Ex. 1 would give you 21-40 and 2 would give you 41-60 and so on.

