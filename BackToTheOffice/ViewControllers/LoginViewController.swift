//
//  LoginViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 14.09.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var tokenStatusLabel: UILabel!
    
    @IBOutlet weak var yesOrNoLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Проверка, есть ли сохраненный токен в системе
        if let _ = UserDefaults().string(forKey: "tokenIdentifer") {
            yesOrNoLabel.text = "ЕСТЬ"
            tokenStatusLabel.text = "сохраненный токен"
            backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0.868272841, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func getTestToken(_ sender: UIButton) {
        //Запись токена в userDefaults
        
        let tokenIdentifier = "1234BTTOMobiletoken1234Identifier1234"
        
        let userDefaults = UserDefaults()
        userDefaults.set(tokenIdentifier, forKey: "tokenIdentifer")
        
        yesOrNoLabel.text = "ЕСТЬ"
        tokenStatusLabel.text = "сохраненный токен"
        backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0.868272841, blue: 0, alpha: 1)
    }
    
    @IBAction func getTokenFromServer(_ sender: UIButton) {
        
        guard let email = loginTF.text, let password = passwordTF.text, email != "", password != "" else {
            print("Поля не заполнены")
            return
        }
        
        // Делаем POST запрос на регистрацию пользователя c "Content-Type" "x-www-form-urlencoded"
        
        
        let urlString = "https://coreclient:Qv9XcwpraF67mCmM@btto-back.herokuapp.com/oauth/token"
        guard let url = URL(string: urlString) else {
            print ("Неверный URL")
            return
        }
        let parameters = "grant_type=password&username=\(email)&password=\(password)".data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        request.httpBody = parameters
        
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
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    

}
