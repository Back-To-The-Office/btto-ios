//
//  BookYourPlaceSecondTableViewCell.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 18.07.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

//Протокол, что бы передавать в родительский контроллер нажатия от радиокнопки и стульев
//В параметрах всех методов передаем конкретный экземпляр класса (конкретная ячейка, в которой произошло нажатие), что бы в родительском ViewController вернуть IndexPath этой ячейки
protocol BookYourPlaceSecondTableViewCellDelegate: class {
    func radioButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair1ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair2ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair3ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair4ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair5ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair6ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair7ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair8ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair9ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair10ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair11ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair12ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair13ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair14ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair15ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
    func chair16ButtonTapped (currentCell: BookYourPlaceSecondTableViewCell)
}

class BookYourPlaceSecondTableViewCell: UITableViewCell {
    
    weak var delegate: BookYourPlaceSecondTableViewCellDelegate?

    @IBOutlet weak var blueCircle: UIImageView!
    
    @IBOutlet weak var tableLabel: UILabel!
    
    @IBOutlet weak var chair1: UIButton!
    
    @IBOutlet weak var chair2: UIButton!
    
    @IBOutlet weak var chair3: UIButton!
    
    @IBOutlet weak var chair4: UIButton!
    
    @IBOutlet weak var chair5: UIButton!
    
    @IBOutlet weak var chair6: UIButton!
    
    @IBOutlet weak var chair7: UIButton!
    
    @IBOutlet weak var chair8: UIButton!
    
    @IBOutlet weak var chair9: UIButton!
    
    @IBOutlet weak var chair10: UIButton!
    
    @IBOutlet weak var chair11: UIButton!
    
    @IBOutlet weak var chair12: UIButton!
    
    @IBOutlet weak var chair13: UIButton!
    
    @IBOutlet weak var chair14: UIButton!
    
    @IBOutlet weak var chair15: UIButton!
    
    @IBOutlet weak var chair16: UIButton!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func radioButtonTapped(_ sender: UIButton) {
        delegate?.radioButtonTapped(currentCell: self)
    }
    @IBAction func chair1ButtonTapped(_ sender: UIButton) {
        delegate?.chair1ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair2ButtonTapped(_ sender: UIButton) {
        delegate?.chair2ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair3ButtonTapped(_ sender: UIButton) {
        delegate?.chair3ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair4ButtonTapped(_ sender: UIButton) {
        delegate?.chair4ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair5ButtonTapped(_ sender: UIButton) {
        delegate?.chair5ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair6ButtonTapped(_ sender: UIButton) {
        delegate?.chair6ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair7ButtonTapped(_ sender: UIButton) {
        delegate?.chair7ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair8ButtonTapped(_ sender: UIButton) {
        delegate?.chair8ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair9ButtonTapped(_ sender: UIButton) {
        delegate?.chair9ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair10ButtonTapped(_ sender: UIButton) {
        delegate?.chair10ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair11ButtonTapped(_ sender: UIButton) {
        delegate?.chair11ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair12ButtonTapped(_ sender: UIButton) {
        delegate?.chair12ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair13ButtonTapped(_ sender: UIButton) {
        delegate?.chair13ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair14ButtonTapped(_ sender: UIButton) {
        delegate?.chair14ButtonTapped(currentCell: self)
    }
    
    @IBAction func chair15ButtonTapped(_ sender: UIButton) {
        delegate?.chair15ButtonTapped(currentCell: self)
    }
    @IBAction func chair16ButtonTapped(_ sender: UIButton) {
        delegate?.chair16ButtonTapped(currentCell: self)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        chair1.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair2.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair3.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair4.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair5.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair6.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair7.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair8.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair9.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair10.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair11.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair12.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair13.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair14.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair15.setImage(UIImage(named: "GrayChair"), for: .normal)
        chair16.setImage(UIImage(named: "GrayChair"), for: .normal)
    }
    
    func configureDesks (numberOfPlaces: Int, numberOfReservedPlaces: Int) {
        
        //print(String(numberOfPlaces) + "__" + String(numberOfReservedPlaces))
        
        switch numberOfPlaces {
        case 1:
            chair2.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair3.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair4.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair5.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair6.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair7.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair8.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 2:
            chair3.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair4.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair5.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair6.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair7.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair8.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 3:
            chair4.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair5.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair6.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair7.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair8.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 4:
            chair5.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair6.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair7.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair8.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 5:
            chair6.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair7.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair8.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 6:
            chair7.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair8.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 7:
            chair8.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 8:
            chair9.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 9:
            chair10.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 10:
            chair11.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 11:
            chair12.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 12:
            chair13.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 13:
            chair14.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 14:
            chair15.setImage(UIImage(named: "ClearChair"), for: .normal)
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        case 15:
            chair16.setImage(UIImage(named: "ClearChair"), for: .normal)
        default:
            break
        }
        switch numberOfReservedPlaces {
        case 1:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 2:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 3:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 4:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 5:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 6:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 7:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 8:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 9:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 10:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair10.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 11:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair10.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair11.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 12:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair10.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair11.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair12.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 13:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair10.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair11.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair12.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair13.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 14:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair10.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair11.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair12.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair13.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair14.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 15:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair10.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair11.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair12.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair13.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair14.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair15.setImage(UIImage(named: "BlueChair"), for: .normal)
        case 16:
            chair1.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair2.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair3.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair4.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair5.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair6.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair7.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair8.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair9.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair10.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair11.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair12.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair13.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair14.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair15.setImage(UIImage(named: "BlueChair"), for: .normal)
            chair16.setImage(UIImage(named: "BlueChair"), for: .normal)
        default:
            break
        }
    }
}
