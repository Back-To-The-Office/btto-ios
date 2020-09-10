//
//  ViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 04.09.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var blueSquareIsMarked = false
    
    
    @IBOutlet weak var createAccountTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var createAccountButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var blueSquareImage: UIImageView!
    
    @IBOutlet weak var iAgreeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Меняем значения некоторых констрейнтов, если приложение запущено на Айфоне SE, 5, 5S
        if UIScreen.main.bounds.height == 568.0 {
           print("Айфон SE детектед")
            
            createAccountTopConstraint.constant = 10
            createAccountButtonBottomConstraint.constant = 10
            iAgreeLabel.text = "By signing up, I agree to the application"
        }
        
        
        
    }

    @IBAction func privacyPolicyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func termsOfServiceButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func blueSquareButtonTapped(_ sender: UIButton) {
        
        blueSquareIsMarked = !blueSquareIsMarked
        
        if blueSquareIsMarked {
            blueSquareImage.image = UIImage(named: "blueSquareMarked")
        } else {
            blueSquareImage.image = UIImage(named: "blueSquareClear")
        }
        
        
        
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
    }
    
    

}

