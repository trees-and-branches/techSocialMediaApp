//
//  ProfileViewController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/5/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let apiController = APIController()
    let autController = AuthenticationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let user = try await apiController.fetchProfile(for:"EE9E0B40-791B-4730-B783-0B2B8C09AB20")
                print(user)
                
            } catch {
                print(error)
            }
        }

        // Do any additional setup after loading the view.
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
