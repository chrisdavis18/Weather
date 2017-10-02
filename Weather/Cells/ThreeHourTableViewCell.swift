//
//  ThreeHourTableViewCell.swift
//  Weather
//
//  Created by Personal on 10/1/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class ThreeHourTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
