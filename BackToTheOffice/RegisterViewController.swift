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
    
    var allTimeZones:[String] {
        return TimeZone.knownTimeZoneIdentifiers
    }
    
    var pickerViewSelectedElement: String?
    
    //Сюда сохраняем первоначальное значение одной из констрейнт (значение этого констрейнта меняется при выдвижении клавиатуры)
    var saveCreateAccountLabelTopConstraintValue: CGFloat!
    
    @IBOutlet weak var backToTheOfficeLabelTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var backToTheOfficeLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAccountButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var timeZoneTF: UITextField!
    
    @IBOutlet weak var blueSquareImage: UIImageView!
    
    @IBOutlet weak var iAgreeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        timeZoneTF.delegate = self
        
        
        
        let timeZone = TimeZone.current.identifier
        
        timeZoneTF.text = "Your timezone: \(timeZone)"
        
        choisePickerViewElement()
        createPickerViewToolbar()
        
        //Меняем значения некоторых констрейнтов, в зависимости от модели айфона
        switch UIScreen.main.bounds.height {
        case 667:
            print("6,7,8,SE 2-gen")
            
            backToTheOfficeLabelTopConstraint.constant = 20
            backToTheOfficeLabelBottomConstraint.constant = 10
            createAccountButtonBottomConstraint.constant = 10
            
            saveCreateAccountLabelTopConstraintValue = backToTheOfficeLabelTopConstraint.constant
            
            doesTheScreeenHaveAMonobrow = false
        case 736:
            print("6 Plus, 7 Plus, 8 Plus")
            
            backToTheOfficeLabelTopConstraint.constant = 40
            createAccountButtonBottomConstraint.constant = 20
            
            saveCreateAccountLabelTopConstraintValue = backToTheOfficeLabelTopConstraint.constant
            
            doesTheScreeenHaveAMonobrow = false
        default:
            saveCreateAccountLabelTopConstraintValue = backToTheOfficeLabelTopConstraint.constant
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
            self.backToTheOfficeLabelTopConstraint.constant = 15
        } else {
            self.backToTheOfficeLabelTopConstraint.constant = 0
        }
       
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
    }
    @objc func kbHide (notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.backToTheOfficeLabelTopConstraint.constant = self.saveCreateAccountLabelTopConstraintValue
        
    }
    private func choisePickerViewElement () {
        let pickerView = UIPickerView()
        pickerView.delegate = self
      
        timeZoneTF.inputView = pickerView
    }
    private func createPickerViewToolbar () {
        let pickerViewToolbar = UIToolbar()
        pickerViewToolbar.sizeToFit()
        
        let okButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        
        
        pickerViewToolbar.setItems([okButton], animated: true)
        
        pickerViewToolbar.isUserInteractionEnabled = true
        
       pickerViewToolbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      pickerViewToolbar.tintColor = #colorLiteral(red: 0, green: 0.4877254367, blue: 1, alpha: 1)
        
        timeZoneTF.inputAccessoryView = pickerViewToolbar
        
    }
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == timeZoneTF {
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allTimeZones.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allTimeZones[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewSelectedElement = allTimeZones[row]
        timeZoneTF.text = "Your timezone: \(pickerViewSelectedElement!)"
    }
}
