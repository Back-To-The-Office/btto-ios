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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        
        greenCircle.layer.cornerRadius = greenCircle.frame.size.height / 2
        
        whiteView.layer.cornerRadius = 20
        
        
    }
    
    @IBAction func telegramButonTapped(_ sender: UIButton) {
        
        openApplicationOrPresentAC(appURL: "tg://resolve?domain=@Sergey_Efimov12", titleAC: "Приложение \"Telegram\" не установлено на вашем устройстве", messageAC: "")
    }
    
    @IBAction func whatsAppButonTapped(_ sender: UIButton) {
        openApplicationOrPresentAC(appURL: "whatsapp://send/?phone=79859704545", titleAC: "Приложение \"WhatsApp\" не установлено на вашем устройстве", messageAC: "")
    }
    
    @IBAction func viberButonTapped(_ sender: UIButton) {
        
        openApplicationOrPresentAC(appURL: "viber://contact?number=+79859704544", titleAC: "Приложение \"Viber\" не установлено на вашем устройстве", messageAC: "")
    }
    
    @IBAction func skypeButonTapped(_ sender: UIButton) {
        openApplicationOrPresentAC(appURL: "skype:live:3bd7c6f2431c06a1?chat", titleAC: "Приложение \"Skype\" не установлено на вашем устройстве", messageAC: "")
        //live:3bd7c6f2431c06a1 - это userID
    }
    
    @IBAction func emailButonTapped(_ sender: UIButton) {
        
        openApplicationOrPresentAC(appURL: "mailto:procorporate@inbox.ru", titleAC: "Приложение \"Почта\" не установлено на вашем устройстве", messageAC: "Для отправки письма, воспользуйтесь сторонним приложением.\n Электронный адрес выбранного контакта: procorporate@inbox.ru")
    }
    
    @IBAction func smsButonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "sms://+79273606585")!)
    }
    
    @IBAction func slackButonTapped(_ sender: UIButton) {
        openApplicationOrPresentAC(appURL: "slack://user?team=teambbworkspace&id=Roman1983", titleAC: "Приложение \"Slack\" не установлено на вашем устройстве", messageAC: "")
    }
    
    private func openApplicationOrPresentAC (appURL: String, titleAC: String, messageAC: String) {
        if UIApplication.shared.canOpenURL((URL(string: appURL)!)) {
            
            UIApplication.shared.open(URL(string: appURL)!)
            
        } else {
            
            let alertController = UIAlertController(title: titleAC, message: messageAC, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            
            alertController.addAction(alertAction)
            
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
