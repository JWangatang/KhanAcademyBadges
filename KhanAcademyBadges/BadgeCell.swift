//
//  BadgeCell.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/9/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit

class BadgeCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
