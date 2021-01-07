//
//  NewLoginViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 25.12.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class NewLoginViewController: UIViewController {
    
    var tokenModel = TokenModel(scope: "", jti: "", expiresIn: 0, tokenType: "", accessToken: "") {
        didSet {
            let currentUserModel = getCurrentUserData(tokenModel: tokenModel)
            
            print(currentUserModel)
            
        }
    }
    
    @IBOutlet weak var emailSmallLabel: UILabel!
    
    @IBOutlet weak var passwordSmallLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var emailGrayLine: UIImageView!
    
    @IBOutlet weak var passwordGrayLine: UIImageView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailSmallLabel.isHidden = true
        passwordSmallLabel.isHidden = true
       
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTF.text , let password = passwordTF.text, email != "", password != "" else {
            
            showErrorMessage(title: "Не все поля заполнены", message: "Пожалуйста, заполните все поля")
            return
        }
        
        let urlString = "https://coreclient:\(secretKey)@btto-back.herokuapp.com/oauth/token"
        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return }
        let parameters = "grant_type=password&username=\(email)&password=\(password)".data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        request.httpBody = parameters
        
        let session = URLSession.shared
        session.dataTask(with: request) { [weak self] data, response,error in
            guard error == nil else {
                print (error!.localizedDescription)
                return
            }
//            if let response = response {
//
//            }
            if let data = data {
                
                //Сохраняем в UserDefault не распарсивая
                UserDefaults().setValue(data, forKey: "TokenModel")
                //Если, потом, будем доставать из UserDefault:
                //Это проверено - работает
//                do {
//                    let data = UserDefaults().object(forKey: "TokenModel") as! Data
//                    let t = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(t)
//                } catch {
//                    print(error)
//                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    
                    let token = TokenModel(scope: json["scope"] as! String,
                                           jti: json["jti"] as! String,
                                           expiresIn: json["expires_in"] as! Int,
                                           tokenType: json["token_type"] as! String,
                                           accessToken: json["access_token"] as! String)
                    self?.tokenModel = token
                    
                } catch {
                    print("Не получилось парсить JSON")
                }
            }
        }.resume()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func showErrorMessage (title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let oKAction = UIAlertAction (title: "Ок", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(oKAction)
        
        present(alertController, animated: true, completion: nil)
    }
    private func getCurrentUserData (tokenModel: TokenModel) -> UserModel? {

        let urlString = "https://btto-back.herokuapp.com/api/v1/users/current"
        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return nil }
        let authorizationKey = "bearer ".appending(tokenModel.accessToken)
        print(authorizationKey)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization" )
        
        print(request.description)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print (error!.localizedDescription)
                print(error!)
                return
            }
            if let response = response {
print(response)
            }
            if let data = data {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    print(json)
//                    let currentUser = UserModel(contacts: <#T##String#>,
//                                                email: <#T##String#>,
//                                                firstName: <#T##String#>,
//                                                id: <#T##Int#>,
//                                                lastName: <#T##String#>,
//                                                position: <#T##String#>,
//                                                timesone: <#T##UserModel.Timezone#>)
//
//
                } catch {
                    print("Не получилось парсить JSON")
                }
            }
        }.resume()
            
            
            
        
        //performSegue(withIdentifier: "signInToTabBar", sender: nil)
return nil // UserModel
    }
    
//    private func get (url: String) {
//
//
//
//
//        guard let url = URL(string: url) else { return }
//
//        let session = URLSession.shared
//        session.dataTask(with: url) { (data, response, error) in
//            guard let response = response, let data = data else {
//                print (error?.localizedDescription ?? "Неизвестная ошибка")
//                return }
//
//            print(response.description)
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print (error.localizedDescription)
//            }
//        }.resume()
//    }
}

extension NewLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTF {
            emailSmallLabel.isHidden = false
            emailSmallLabel.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            emailGrayLine.image = UIImage(named: "blueLine")
        } else {
            passwordSmallLabel.isHidden = false
            passwordSmallLabel.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            passwordGrayLine.image = UIImage(named: "blueLine")
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == emailTF && textField.text == "" {
            emailSmallLabel.isHidden = true
            emailGrayLine.image = UIImage(named: "greyLine")
        }
        if textField == passwordTF && textField.text == "" {
            passwordSmallLabel.isHidden = true
            passwordGrayLine.image = UIImage(named: "greyLine")
        }
        if textField == emailTF && textField.text != "" {
            emailSmallLabel.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
            emailGrayLine.image = UIImage(named: "greyLine")
        }
        if textField == passwordTF && textField.text != "" {
            passwordSmallLabel.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
            passwordGrayLine.image = UIImage(named: "greyLine")
        }
    }
}
