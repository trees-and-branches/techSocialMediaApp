//
//  ProfileEditViewController.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/12/24.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    var profile: Profile?

    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var techInterestsTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let profile {
            userNameTextfield.placeholder = profile.userName
            bioTextField.placeholder = profile.bio
            techInterestsTextField.placeholder = profile.techInterests
        }
        // Do any additional setup after loading the view.
    }

    func updateProfile() async throws {
        // Unwrap `profile` at the beginning and use it directly inside the block.
        guard let profile = self.profile,
              let userName = userNameTextfield.text,
              let bio = bioTextField.text,
              let techInterests = techInterestsTextField.text
        else { return }
        var theProfile = profile

        // Now `profile` is unwrapped, and you can safely access and modify its properties.
        theProfile.userName = userName
        theProfile.bio = bio
        theProfile.techInterests = techInterests

        // Since `profile` is already unwrapped, you can directly use it in the function call.
        try await ProfileController.shared.updateProfile(for: theProfile)
    }

}
