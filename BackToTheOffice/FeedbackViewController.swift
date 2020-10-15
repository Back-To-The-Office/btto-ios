//
//  FeedbackViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 08.10.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var greenCircle: UIView!
    
    @IBOutlet weak var firstNameAndLastNameLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var contactFirstNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        
        greenCircle.layer.cornerRadius = greenCircle.frame.size.height / 2
        
        whiteView.layer.cornerRadius = 20
        
        firstNameAndLastNameLabel.setCharacterSpacing(1.2)
        
        contactFirstNameLabel.setCharacterSpacing(1.2)
    }
    
    @IBAction func telegramButonTapped(_ sender: UIButton) {
        
        openApplicationOrPresentAC(appURL: "tg://resolve?domain=", userID: "@Sergey_Efimov12", titleAC: "Приложение \"Telegram\" не установлено на вашем устройстве")
    }
    
    @IBAction func whatsAppButonTapped(_ sender: UIButton) {
        openApplicationOrPresentAC(appURL: "whatsapp://send/?phone=", userID: "79859704545", titleAC: "Приложение \"WhatsApp\" не установлено на вашем устройстве")
    }
    
    @IBAction func viberButonTapped(_ sender: UIButton) {
        
        openApplicationOrPresentAC(appURL: "viber://contact?number=", userID: "+79859704544", titleAC: "Приложение \"Viber\" не установлено на вашем устройстве")
    }
    
    @IBAction func skypeButonTapped(_ sender: UIButton) {
        openApplicationOrPresentAC(appURL: "skype:", userID: "live:3bd7c6f2431c06a1", titleAC: "Приложение \"Skype\" не установлено на вашем устройстве")
        //live:3bd7c6f2431c06a1 - это userID
    }
    
    @IBAction func emailButonTapped(_ sender: UIButton) {
        
        openApplicationOrPresentAC(appURL: "mailto:", userID: "procorporate@inbox.ru", titleAC: "Приложение \"Почта\" не установлено на вашем устройстве")
    }
    
    @IBAction func smsButonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "sms://+79273606585")!)
    }
    
    @IBAction func slackButonTapped(_ sender: UIButton) {
        openApplicationOrPresentAC(appURL: "slack://user?team=teambbworkspace&id=", userID: "Roman1983", titleAC: "Приложение \"Slack\" не установлено на вашем устройстве")
    }
    
    private func openApplicationOrPresentAC (appURL: String, userID: String, titleAC: String) {
        
        var urlString = appURL + userID
        var messageAC = ""
        
        switch appURL {
        case "tg://resolve?domain=":
            messageAC = "Идентификатор этого пользователя в Telegram \(userID)"
        case "whatsapp://send/?phone=":
            messageAC = "Номер телефона этого пользователя \(userID)"
        case "viber://contact?number=":
            messageAC = "Номер телефона этого пользователя \(userID)"
        case "skype:":
            urlString = appURL + userID + "?chat"
            messageAC = "Идентификатор этого пользователя в Skype \(userID)"
        case "mailto:":
            messageAC = "Email этого пользователя \(userID)"
        case "slack://user?team=teambbworkspace&id=":
            messageAC = "Идентификатор этого пользователя в Slack \(userID)"
        
        default:
            break
        }
        
        if UIApplication.shared.canOpenURL((URL(string: urlString)!)) {
            
            UIApplication.shared.open(URL(string: urlString)!)
            
        } else {
            
            let alertController = UIAlertController(title: titleAC, message: messageAC, preferredStyle: .alert)
            
            alertController.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            alertController.view.layer.cornerRadius = 12
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            let copyUserIdAction = UIAlertAction(title: "Копировать", style: .default) { action in
                
                UIPasteboard.general.string = userID
                
            }
            
            alertController.addAction(okAction)
            alertController.addAction(copyUserIdAction)
            
            present(alertController, animated: true)
        }
    }
    
    
//    private func openApplicationOrSafari (appUrl:String, safariUrl:String) {
//        guard let appURL = URL(string: appUrl) else { return }
//        guard let safariURL = URL(string: safariUrl) else { return }
//
//        if UIApplication.shared.canOpenURL(appURL) {
//
//            UIApplication.shared.open(appURL)
//
//        } else {
//
//            UIApplication.shared.open(safariURL)
//        }
//     }
    
   

}
