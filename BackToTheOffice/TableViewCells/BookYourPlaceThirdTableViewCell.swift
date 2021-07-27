//
//  BookYourPlaceThirdTableViewCell.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 18.07.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

protocol BookYourPlaceThirdTableViewCellDelegate: class {
    func saveButtonTapped ()
}

class BookYourPlaceThirdTableViewCell: UITableViewCell {
    
    weak var delegate: BookYourPlaceThirdTableViewCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        delegate?.saveButtonTapped()
    }
    
}
