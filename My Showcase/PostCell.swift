//
//  PostCell.swift
//  My Showcase
//
//  Created by Joseph Pilon on 3/19/16.
//  Copyright © 2016 Gulp Technologies. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var postText: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        
        //postText.clipsToBounds = true
        postImg.clipsToBounds = true
    }

}
