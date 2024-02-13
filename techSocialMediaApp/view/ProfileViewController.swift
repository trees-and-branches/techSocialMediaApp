//
//  ProfileViewController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/5/24.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let profileController = ProfileController()
    let autController = AuthenticationController()
    var profile: Profile?
    var posts: [Post]?

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstLastLabel: UILabel!
    
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var techInterests: UILabel!
    
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                profile = try await profileController.fetchProfile(for:"EE9E0B40-791B-4730-B783-0B2B8C09AB20")
                updateUI(with: profile)
                
            } catch {
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        guard let profile else { return }
        let destination = segue.destination as! ProfileEditViewController
        destination.profile = profile
        
    }
    
    func updateUI(with profile: Profile?) {
        guard let profile else { return }
        userNameLabel.text = profile.userName
        firstLastLabel.text = "\(profile.firstName) \(profile.lastName)"
        bio.text = profile.bio
        techInterests.text = profile.techInterests
        
    }
    
    @IBAction func postChangesAndUnwind(sender: UIStoryboardSegue) {
        print("unwind:\(sender)")
        if let profileEditViewController = sender.source as? ProfileEditViewController {
            Task {
                try await profileEditViewController.updateProfile()
                
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
extension ProfileViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .subtitle, reuseIdentifier: "PostCell")
    }
    
}
