//
//  CompanyTableViewCell.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 17.01.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var greenCircle: UIView!
    
    @IBOutlet weak var firstNameAndLastNameLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
