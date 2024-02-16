//
//  postsController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/16/24.
//

import Foundation

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
        
        print("printing for page \(pageString)")
        
        return try decoder.decode([Post].self, from: data)
    
    }
    
    func fetchPosts(for userID: String, _ pageNum: Int?) async throws -> [Post] {
        
        var url = URL(string: "\(API.url)/userPosts")!
        let session = URLSession.shared
        
        let userQI = URLQueryItem(name: "userUUID", value: userID)
        let userSecretValue = User.current?.secret.uuidString ?? "defaultSecret"
        let secretQI = URLQueryItem(name: "userSecret", value: userSecretValue)
        
        if let pageNum {
            let pageNumQI = URLQueryItem(name: "pageNumber", value: String(pageNum))
            url.append(queryItems: [pageNumQI])
        }
        
        url.append(queryItems: [userQI, secretQI])
        
        print(url)
        
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
    
    func submitPost(title: String, body: String) async throws {
        let url = URL(string: "\(API.url)/createPost")!
        let session = URLSession.shared
        
        let userSecretValue = User.current?.secret.uuidString ?? "defaultSecret"
        
        let httpbody: [String: Any] = [ "userSecret" : userSecretValue , "post": [ "title": title, "body": body]]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: httpbody, options: .prettyPrinted)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.couldNotPost
        }
        
        let decoder = JSONDecoder()
        
        print("post subit response \(try decoder.decode(Post.self,from: data))")
    }
    
    func editPost(_ post: Post, title: String, body: String) async throws {
        
        let url = URL(string: "\(API.url)/editPost")!
        let session = URLSession.shared
        
        let userSecretValue = User.current?.secret.uuidString ?? "defaultSecret"
        
        let httpbody: [String: Any] = [ "userSecret" : userSecretValue , "post": ["postid": String(post.id), "title": title, "body": body]]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.httpBody = try JSONSerialization.data(withJSONObject: httpbody, options: .prettyPrinted)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.couldNotPost
        }
        
    }
    func deletePost(_ id: Int) async throws {
        var url = URL(string: "\(API.url)/post")!
        let session = URLSession.shared
        
        let userSecretValue = User.current?.secret.uuidString ?? "defaultSecret"
        let secretQI = URLQueryItem(name: "userSecret", value: userSecretValue)
        let postIDQI = URLQueryItem(name: "postid", value: String(id))
        
        url.append(queryItems: [postIDQI, secretQI])
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.couldNotDelete
        }
        

    }
    
     
}
