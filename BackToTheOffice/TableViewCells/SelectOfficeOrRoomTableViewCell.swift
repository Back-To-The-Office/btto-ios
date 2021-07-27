//
//  Select officeOrRoomTableViewCell.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 05.07.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class SelectOfficeOrRoomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var officeOrRoomLabel: UILabel!
    
    
    @IBOutlet weak var blueCircle: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
