//
//  PostTableViewCell.swift
//  techSocialMediaApp
//
//  Created by shark boy on 2/6/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postUserLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
