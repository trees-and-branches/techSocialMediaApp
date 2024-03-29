//
//  CreateEditPostViewController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/15/24.
//

import UIKit

class CreateEditPostViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextField!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let postToEdit = post {
            titleLabel.text = postToEdit.title
            bodyLabel.text = postToEdit.body
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitTapped(_ sender: Any) {
        

        if let title = titleLabel.text, let body = bodyLabel.text {
            if let postToEdit = post {
                Task {
                    try await PostsController.shared.editPost(postToEdit, title: title, body: body)
                }
//                performSegue(withIdentifier: "ToProfile", sender: nil)
                
            } else {
                Task {
                    try await PostsController.shared.submitPost(title: title, body: body)
                    
                }
//                performSegue(withIdentifier: "ToPosts", sender: nil)
                tabBarController?.selectedIndex = 0
            }
            
        }
        
    }

}
