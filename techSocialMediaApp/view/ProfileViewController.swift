

import UIKit

// TODO: gotta make this same vc for outside users

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //    let profileController = ProfileController()
    let autController = AuthenticationController()
    var profile: Profile?
    var posts: [Post] = []
    var postToEdit: Post?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstLastLabel: UILabel!
    
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var techInterests: UILabel!
    
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postNib = UINib.init(nibName: "PostTableViewCell", bundle: nil)
        self.postsTableView.register(postNib, forCellReuseIdentifier: "PostCell")
        
        postsTableView.dataSource = self
        postsTableView.delegate = self
        
        Task {
            do {
                profile = try await ProfileController.shared.fetchProfile(for:"EE9E0B40-791B-4730-B783-0B2B8C09AB20")
                updateUI(with: profile)
                
                let initialPosts = try await PostController.shared.fetchPosts(for: "EE9E0B40-791B-4730-B783-0B2B8C09AB20", nil) // gotta actually get the value instead of hardcoding this... later
                posts += initialPosts
                postsTableView.reloadData()
                
                
            } catch {
                print(error)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        guard let profile else { return }
        if let destination = segue.destination as? ProfileEditViewController {
            destination.profile = profile
        } else if let destination = segue.destination as? CreateEditPostViewController {
            destination.post = postToEdit
        }
        
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
                
                profile = try await ProfileController.shared.fetchProfile(for:"EE9E0B40-791B-4730-B783-0B2B8C09AB20")
                updateUI(with: profile)
            }
            
        }
        postsTableView.reloadData()
    }
}
            
extension ProfileViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        cell.update(with: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postToEdit = posts[indexPath.row]
        performSegue(withIdentifier: "EditPost", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedID = posts[indexPath.row].id
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            Task {
                
                try await PostController.shared.deletePost(deletedID)
            }
            
            
            
        }
    }
    
}
