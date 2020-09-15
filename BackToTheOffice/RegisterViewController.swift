//
//  ViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 04.09.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var doesTheScreeenHaveAMonobrow = true
    
    var blueSquareIsMarked = false
    
    //Сюда сохраняем первоначальное значение одной из констрейнт (значение этого констрейнта меняется при выдвижении клавиатуры)
    var saveCreateAccountLabelTopConstraintValue: CGFloat!
    
    @IBOutlet weak var createAccountLabelTopConstraint: NSLayoutConstraint!

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
        
        //Меняем значения некоторых констрейнтов, в зависимости от модели айфона
        switch UIScreen.main.bounds.height {
        case 667, 736:
            print("Айфон 6,7,8,SE 2-gen, 6 Plus, 7 Plus, 8 Plus")
            
            createAccountLabelTopConstraint.constant = 60
            createAccountButtonBottomConstraint.constant = 30
            
            saveCreateAccountLabelTopConstraintValue = createAccountLabelTopConstraint.constant
            
            doesTheScreeenHaveAMonobrow = false
        default:
            saveCreateAccountLabelTopConstraintValue = createAccountLabelTopConstraint.constant
        }
       
        //Что бы клавиатура не закрывала текстовые поля - реализуем скролл
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
        // Делаем POST запрос на регистрацию пользователя
        let urlString = "https://btto-back.herokuapp.com/api/v1/users/register"
        guard let url = URL(string: urlString) else {
            print("Неверный url")
            return
        }
        let parameters = ["email": email,
                          "firstName": firstName,
                          "lastName": lastName,
                          "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            print("В теле запроса не создался JSON c параметрами")
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            guard let data = data else {
                print("В ответе нет данных")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print (json)
            } catch {
                print (error.localizedDescription)
            }
        }.resume()
        
        
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
        if doesTheScreeenHaveAMonobrow {
            self.createAccountLabelTopConstraint.constant = 76
        } else {
            self.createAccountLabelTopConstraint.constant = 40
        }
       
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
    }
    @objc func kbHide (notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.createAccountLabelTopConstraint.constant = self.saveCreateAccountLabelTopConstraintValue
        
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
