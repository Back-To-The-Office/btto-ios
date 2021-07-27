//
//  BookYourPlaceFirstTableViewCell.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 14.07.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

//Протокол, что бы передавать в родительский контроллер нажатия от кнопок этой кастомной ячейки
protocol BookYourPlaceFirstTableViewCellDelegate: class {
   func bluePencilButtonTapped ()
   func addDaysButtonTapped ()
   func selectOfficeButtonTapped ()
   func selectRoomButtonTapped ()
}

class BookYourPlaceFirstTableViewCell: UITableViewCell {

    weak var delegate: BookYourPlaceFirstTableViewCellDelegate?
    
    @IBOutlet weak var bluePencilButton: UIButton!
    
        @IBOutlet weak var selectedDatesLabel: UILabel!
    
        @IBOutlet weak var officeLabel: UILabel!
    
        @IBOutlet weak var roomLabel: UILabel!
    
        @IBOutlet weak var addDaysButton: UIButton!
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    @IBAction func bluePencilButtonTapped(_ sender: UIButton) {
        delegate?.bluePencilButtonTapped()
        }
        @IBAction func addDaysButtonTapped(_ sender: UIButton) {
            delegate?.addDaysButtonTapped()
        }
        @IBAction func selectOfficeButtonTapped(_ sender: UIButton) {
            delegate?.selectOfficeButtonTapped()
        }
        @IBAction func selectRoomButtonTapped(_ sender: UIButton) {
            delegate?.selectRoomButtonTapped()
            print ("*GGGG*")
        }
}
