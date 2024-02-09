//
//  PostsViewController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/6/24.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!
    var posts: [Post] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
    
    let post = posts[indexPath.row]
    cell.update(with: post)
    
    
    
    return cell
}

}
extension PostsViewController {
    

    }
    

