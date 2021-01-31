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
            print("-------------------")
            print("Запустилось получение JSON currentUser")
            
            getCurrentUserData(tokenModel: tokenModel)
        }
    }
    var currentUser: UserModel? {
        didSet {
            
            if currentUser != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.performSegue(withIdentifier: "signInToTabBar", sender: nil)
                }
               
            }
        }
    }
    
    @IBOutlet weak var emailSmallLabel: UILabel!
    
    @IBOutlet weak var passwordSmallLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var emailGrayLine: UIImageView!
    
    @IBOutlet weak var passwordGrayLine: UIImageView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var blackView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blackView.isHidden = true
        blackView.alpha = 0
        activityIndicator.isHidden = true
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailSmallLabel.isHidden = true
        passwordSmallLabel.isHidden = true
        
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
        blackView.isHidden = false
        UIView.animate(withDuration: 1, animations: { [unowned self] in
            blackView.alpha = 0.5
        })
        activityIndicator.isHidden = false
//        activityIndicator.startAnimating()
        
        
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
                print("Токен авторизации не получен")
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
                    
                    let token = TokenModel(scope: json["scope"] as? String,
                                           jti: json["jti"] as? String,
                                           expiresIn: json["expires_in"] as? Int,
                                           tokenType: json["token_type"] as? String,
                                           accessToken: json["access_token"] as? String)
                    self?.tokenModel = token
                    
                } catch {
                    print("Не получилось парсить JSON")
                }
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarC = segue.destination as? UITabBarController else { return }
        tabBarC.selectedIndex = 3
        print("TabBar selected Index = 3")
        guard let navigationController = tabBarC.viewControllers?[3] as? UINavigationController else { return }
        print("NavigationController - ok")
        guard let userProfileVC = navigationController.topViewController as? UserProfileViewController else {
            return }
        
        userProfileVC.currentUser = self.currentUser
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
    private func getCurrentUserData (tokenModel: TokenModel) {
        
        let urlString = "https://btto-back.herokuapp.com/api/v1/users/current"
        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return }
        guard let accessToken = tokenModel.accessToken else {
            print("Нет Токена")
            return
        }
        let authorizationKey = "bearer ".appending(accessToken)
        print(authorizationKey)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization" )
        
        print(request.description)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("Данные Current User не получены")
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
                    print("JSON currentUser получен")
                    
                    let currentUser = UserModel(contacts: "",
                                                email: json["email"] as? String,
                                                firstName: json["firstName"] as? String,
                                                id: 0,
                                                lastName: json["lastName"] as? String,
                                                position: json["position"] as? String,
                                                timesone: Timezone(id: ""))
                    
                    self.currentUser = currentUser
                    print(currentUser)
                } catch {
                    print("*Не получилось парсить JSON")
                }
            }
        }.resume()
    }
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
