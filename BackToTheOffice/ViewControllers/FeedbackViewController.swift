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
    
    @IBOutlet weak var skypeIDLabel: UILabel!
    
    @IBOutlet weak var whatsAppIDLabel: UILabel!
    
    @IBOutlet weak var viberIDLabel: UILabel!
    
    @IBOutlet weak var telegramIDLabel: UILabel!
    
    @IBOutlet weak var slackIDLabel: UILabel!
    
    @IBOutlet weak var iMessageIDLabel: UILabel!
    
    @IBOutlet weak var mailIDLabel: UILabel!
    
    @IBOutlet weak var skypeCopyButton: UIButton!
    
    @IBOutlet weak var whatsAppCopyButton: UIButton!
    
    @IBOutlet weak var viberCopyButton: UIButton!
    
    @IBOutlet weak var telegramCopyButton: UIButton!
    
    @IBOutlet weak var slackCopyButton: UIButton!
    
    @IBOutlet weak var iMessageCopyButton: UIButton!
    
    @IBOutlet weak var mailCopyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        
        greenCircle.layer.cornerRadius = greenCircle.frame.size.height / 2
        
        whiteView.layer.cornerRadius = 20
        
        firstNameAndLastNameLabel.setCharacterSpacing(1.2)
        
        contactFirstNameLabel.setCharacterSpacing(1.2)
        
        createLongPressGestureRecognizersAndAddToIDLabels()
        
        hideAllCopyButtons ()
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
    
    
    @IBAction func skypeCopyButtonTapped(_ sender: UIButton) {
        skypeCopyButton.isHidden = true
        allIDLabelsUserInteraction(isEnabled: true)
        skypeIDLabel.backgroundColor = nil
        UIPasteboard.general.string = skypeIDLabel.text
    }
    
    @IBAction func whatsAppCopyButtonTapped(_ sender: UIButton) {
        whatsAppCopyButton.isHidden = true
        allIDLabelsUserInteraction(isEnabled: true)
        whatsAppIDLabel.backgroundColor = nil
        UIPasteboard.general.string = whatsAppIDLabel.text
    }
    
    @IBAction func viberCopyButtonTapped(_ sender: UIButton) {
        viberCopyButton.isHidden = true
        allIDLabelsUserInteraction(isEnabled: true)
        viberIDLabel.backgroundColor = nil
        UIPasteboard.general.string = viberIDLabel.text
    }
    
    @IBAction func telegramCopyButtonTapped(_ sender: UIButton) {
        telegramCopyButton.isHidden = true
        allIDLabelsUserInteraction(isEnabled: true)
        telegramIDLabel.backgroundColor = nil
        UIPasteboard.general.string = telegramIDLabel.text
    }
    
    @IBAction func slackCopyButtonTapped(_ sender: UIButton) {
        slackCopyButton.isHidden = true
        allIDLabelsUserInteraction(isEnabled: true)
        slackIDLabel.backgroundColor = nil
        UIPasteboard.general.string = slackIDLabel.text
    }
    
    @IBAction func iMessageCopyButtonTapped(_ sender: UIButton) {
        iMessageCopyButton.isHidden = true
        allIDLabelsUserInteraction(isEnabled: true)
        iMessageIDLabel.backgroundColor = nil
        UIPasteboard.general.string = iMessageIDLabel.text
    }
    
    @IBAction func mailCopyButtonTapped(_ sender: UIButton) {
        mailCopyButton.isHidden = true
        allIDLabelsUserInteraction(isEnabled: true)
        mailIDLabel.backgroundColor = nil
        UIPasteboard.general.string = mailIDLabel.text
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
    
    private func createLongPressGestureRecognizersAndAddToIDLabels () {
        
        let skypeLPGR = UILongPressGestureRecognizer(target: self, action: #selector(skypeLongPress))
        let whatsAppLPGR = UILongPressGestureRecognizer(target: self, action: #selector(whatsAppLongPress))
        let viberLPGR = UILongPressGestureRecognizer(target: self, action: #selector(viberLongPress))
        let telegramLPGR = UILongPressGestureRecognizer(target: self, action: #selector(telegramLongPress))
        let slackLPGR = UILongPressGestureRecognizer(target: self, action: #selector(slackLongPress))
        let iMessageLPGR = UILongPressGestureRecognizer(target: self, action: #selector(iMessageLongPress))
        let mailLPGR = UILongPressGestureRecognizer(target: self, action: #selector(mailLongPress))
        
        skypeIDLabel.addGestureRecognizer(skypeLPGR)
        whatsAppIDLabel.addGestureRecognizer(whatsAppLPGR)
        viberIDLabel.addGestureRecognizer(viberLPGR)
        telegramIDLabel.addGestureRecognizer(telegramLPGR)
        slackIDLabel.addGestureRecognizer(slackLPGR)
        iMessageIDLabel.addGestureRecognizer(iMessageLPGR)
        mailIDLabel.addGestureRecognizer(mailLPGR)
        
        allIDLabelsUserInteraction(isEnabled: true)
        
    }

    @objc private func skypeLongPress () {
        skypeIDLabel.backgroundColor = .systemGray5
        allIDLabelsUserInteraction(isEnabled: false)
        skypeCopyButton.isHidden = false
    }
    @objc private func whatsAppLongPress () {
        whatsAppIDLabel.backgroundColor = .systemGray5
        allIDLabelsUserInteraction(isEnabled: false)
        whatsAppCopyButton.isHidden = false
    }
    @objc private func viberLongPress () {
        viberIDLabel.backgroundColor = .systemGray5
        allIDLabelsUserInteraction(isEnabled: false)
        viberCopyButton.isHidden = false
    }
    @objc private func telegramLongPress () {
        telegramIDLabel.backgroundColor = .systemGray5
        allIDLabelsUserInteraction(isEnabled: false)
        telegramCopyButton.isHidden = false
    }
    @objc private func slackLongPress () {
        slackIDLabel.backgroundColor = .systemGray5
        allIDLabelsUserInteraction(isEnabled: false)
        slackCopyButton.isHidden = false
    }
    @objc private func iMessageLongPress () {
        iMessageIDLabel.backgroundColor = .systemGray5
        allIDLabelsUserInteraction(isEnabled: false)
        iMessageCopyButton.isHidden = false
    }
    @objc private func mailLongPress () {
        mailIDLabel.backgroundColor = .systemGray5
        allIDLabelsUserInteraction(isEnabled: false)
        mailCopyButton.isHidden = false
    }
    
    private func allIDLabelsUserInteraction (isEnabled: Bool) {
        
        skypeIDLabel.isUserInteractionEnabled = isEnabled
        whatsAppIDLabel.isUserInteractionEnabled = isEnabled
        viberIDLabel.isUserInteractionEnabled = isEnabled
        telegramIDLabel.isUserInteractionEnabled = isEnabled
        slackIDLabel.isUserInteractionEnabled = isEnabled
        iMessageIDLabel.isUserInteractionEnabled = isEnabled
        mailIDLabel.isUserInteractionEnabled = isEnabled
         
    }
    private func hideAllCopyButtons () {
        skypeCopyButton.isHidden = true
        whatsAppCopyButton.isHidden = true
        viberCopyButton.isHidden = true
        telegramCopyButton.isHidden = true
        slackCopyButton.isHidden = true
        iMessageCopyButton.isHidden = true
        mailCopyButton.isHidden = true
    }
}
