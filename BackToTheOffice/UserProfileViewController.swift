//
//  UserProfileViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 19.10.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var blackSqareProfileImage: UIView!
    
    
    
    
    @IBOutlet weak var greenCircle: UIView!
    
    @IBOutlet weak var whitePencilUp: UIImageView!
    
    @IBOutlet weak var whitePencilDown: UIImageView!
    
    @IBOutlet weak var whitePensilButton: UIButton!
    
    @IBOutlet weak var whiteCheckMark: UIImageView!
    
    @IBOutlet weak var whiteCheckMarkButton: UIButton!
    
    @IBOutlet weak var whiteLine: UIImageView!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var firstNameAndLastNameLabel: UILabel!
    
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var skypeIDLabel: UILabel!
    
    @IBOutlet weak var whatsAppIDLebel: UILabel!
    
    
    @IBOutlet weak var viberIDLabel: UILabel!
    
    @IBOutlet weak var telegramIDLabel: UILabel!
    
    
    @IBOutlet weak var slackIDLabel: UILabel!
    
    
    @IBOutlet weak var iMessageIDLabel: UILabel!
    
    @IBOutlet weak var mailIDLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        whiteView.layer.cornerRadius = 20
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        blackSqareProfileImage.layer.cornerRadius = blackSqareProfileImage.frame.height / 2
        greenCircle.layer.cornerRadius = greenCircle.frame.height / 2
        
        nameIsEdited(false)
        
        
        
    }
    
    
    @IBAction func whitePencilDownButtonTapped(_ sender: UIButton) {
        nameIsEdited(true)
    }
    
    @IBAction func whiteCheckMarkButtonTupped(_ sender: UIButton) {
        nameIsEdited(false)
    }
    
    
    
    
    private func nameIsEdited (_ isEdited: Bool) {
        if isEdited {
            whitePencilUp.isHidden = false
            whitePencilDown.isHidden = true
            whiteCheckMark.isHidden = false
            whiteLine.isHidden = false
            blackSqareProfileImage.alpha = 0.4
            whitePensilButton.isEnabled = false
            whiteCheckMarkButton.isEnabled = true
            
        } else {
            whitePencilUp.isHidden = true
            whitePencilDown.isHidden = false
            whiteCheckMark.isHidden = true
            whiteLine.isHidden = true
            blackSqareProfileImage.alpha = 0
            whitePensilButton.isEnabled = true
            whiteCheckMarkButton.isEnabled = false
        }
    }
   
   

}
