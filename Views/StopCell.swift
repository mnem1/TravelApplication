//
//  StopCell.swift
//  TravelApplication
//
//  Created by User on 9/6/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit

class StopCell: UITableViewCell {
    
    @IBOutlet weak var stopCell: UIView!
    @IBOutlet weak var nameLebel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var spentCurrencyLabel: UILabel!
    @IBOutlet weak var transportImageView: UIImageView!
    
    @IBOutlet var stars: [UIImageView]!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        stopCell.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
