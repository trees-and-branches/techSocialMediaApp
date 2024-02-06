//
//  PostsViewController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/6/24.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate = self
        postsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    <#code#>
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
}

}
