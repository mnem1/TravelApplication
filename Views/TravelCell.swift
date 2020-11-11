//
//  TravelCell.swift
//  TravelApplication
//
//  Created by User on 8/27/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit

class TravelCell: UITableViewCell {
    //MARK: - Oulets
    @IBOutlet var starsLabel: [UIImageView]!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    //MARK: - SystemMethods
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
