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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitTapped(_ sender: Any) {
        
        if let title = titleLabel.text, let body = bodyLabel.text {
            Task {
               try await PostController.shared.submitPost(title: title, body: body)
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
