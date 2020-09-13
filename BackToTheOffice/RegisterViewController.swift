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
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var blueSquareImage: UIImageView!
    
    @IBOutlet weak var iAgreeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        //Меняем значения некоторых констрейнтов, если приложение запущено на Айфоне SE, 5, 5S
        if UIScreen.main.bounds.height == 568.0 {
           print("Айфон SE детектед")
            
            createAccountTopConstraint.constant = 10
            createAccountButtonBottomConstraint.constant = 10
            iAgreeLabel.text = "By signing up, I agree to the application"
        }
        
       NotificationCenter.default.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
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
        
        guard let firstName = firstNameTF.text, let lastName = lastNameTF.text, let email = emailTF.text, let password = passwordTF.text, firstName != "", lastName != "", email != "", password != "" else {
            showErrorMessage(title: "Пожалуйста, заполните все поля!", message: "bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-bla")
            return
        }
        guard blueSquareIsMarked == true else {
            showErrorMessage(title: "Поставь галку в синий квадрат!", message: "bla-bla-bla-bla-bla Если умеешь читать, прочитай наши условия и политику безопасности")
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }

    private func showErrorMessage (title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let oKAction = UIAlertAction (title: "Ок", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(oKAction)
        
        present(alertController, animated: true, completion: nil)
    }
    @objc func kbShow (notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + kbSize.height)
        
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
    }
    @objc func kbHide (notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
