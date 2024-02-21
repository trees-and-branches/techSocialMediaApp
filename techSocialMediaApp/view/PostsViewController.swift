//
//  PostsViewController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/6/24.
//

import UIKit

class PostsViewController: UIViewController {
    
    
    var isFetchingPosts = false
       var hasMorePosts = true // Assume there's more data initially

    @IBOutlet weak var postsTableView: UITableView!
    var posts: [Post] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postNib = UINib.init(nibName: "PostTableViewCell", bundle: nil)
        self.postsTableView.register(postNib, forCellReuseIdentifier: "PostCell")
        
        postsTableView.delegate = self
        postsTableView.dataSource = self

        
        Task {
            do {
                let initialPosts = try await PostController.shared.fetchPosts(for: nil)
                posts += initialPosts
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                }
            } catch {
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        postsTableView.reloadData()
    }
    

}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return posts.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
           
           
           // Check if we need to load more posts
           
           print("\(indexPath.row) indexpath")
           if indexPath.row == posts.count - 1, hasMorePosts { // Last cell
               let page = (posts.count / 20)
               loadMorePosts(for: page)
           }

//               else {
//               hasMorePosts = true
//           }
           let post = posts[indexPath.row]
           cell.update(with: post)
           
           return cell
       }
// TODO: this function, or it's callers must be fixed so the bottom of the posts page doesn't keep populating with the same posts
        private func loadMorePosts(for page: Int) {
            guard !isFetchingPosts, hasMorePosts else { return }
            
            isFetchingPosts = true

            Task {
                do {
                    let newPosts = try await PostController.shared.fetchPosts(for: page)
                    DispatchQueue.main.async {
                        if newPosts.isEmpty {
                            self.hasMorePosts = false
                        } else {
                            let startIndex = self.posts.count
                            print("new posts: \(newPosts)")
                            self.posts.append(contentsOf: newPosts)
                            let endIndex = self.posts.count - 1
                            let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
                            
                            self.postsTableView.insertRows(at: indexPaths, with: .automatic)
                            self.postsTableView.reloadData()
                        }
                        self.isFetchingPosts = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isFetchingPosts = false
                        // Handle error (e.g., show an alert or a toast message)
                    }
                }
            }
        }


   }


    

