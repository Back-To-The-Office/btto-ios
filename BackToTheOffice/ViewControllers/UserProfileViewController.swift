//
//  UserProfileViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 19.10.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var startTime: Date?

    var finishTime: Date?
    
    var defaultsContentsOffset: CGPoint?
    
    var defaultViewHeightConstraintConstant: CGFloat?
    
    @IBOutlet weak var addHoursButton: UIButton!
    
    @IBOutlet weak var workHoursUpGrayLine: UIImageView!
    
    @IBOutlet weak var workHoursDownGrayLine: UIImageView!
    
    @IBOutlet weak var clockIcon: UIButton!
    
    @IBOutlet weak var workingHoursLabel: UILabel!
    
    @IBOutlet weak var workingHours: UILabel!
    
    @IBOutlet weak var grayPencilButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var blackSqareProfileImage: UIView!
    
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var firstAndLastNameTF: UITextField!
    
    @IBOutlet weak var positionTF: UITextField!
    
    @IBOutlet weak var greenCircle: UIView!
    
    @IBOutlet weak var whitePencilUp: UIImageView!
    
    @IBOutlet weak var whitePencilDown: UIImageView!
    
    @IBOutlet weak var whitePensilButton: UIButton!
    
    @IBOutlet weak var whiteCheckMark: UIImageView!
    
    @IBOutlet weak var whiteCheckMarkButton: UIButton!
    
    @IBOutlet weak var whiteLine: UIImageView!
    
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var whiteView: UIView!
    
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
    
    @IBOutlet weak var skypeGrayRectangle: UIView!
    
    @IBOutlet weak var whatsAppGrayRectangle: UIView!
    
    @IBOutlet weak var viberGrayRectangle: UIView!
    
    @IBOutlet weak var telegramGrayRectangle: UIView!
    
    @IBOutlet weak var slackGrayRectangle: UIView!
    
    @IBOutlet weak var iMessageGrayRectangle: UIView!
    
    @IBOutlet weak var mailGrayRectangle: UIView!
    
    @IBOutlet weak var whiteViewHeightConstraint: NSLayoutConstraint!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workHoursUpGrayLine.isHidden = true
        workHoursDownGrayLine.isHidden = true
        grayPencilButton.isHidden = true
        workingHours.isHidden = true
        workingHoursLabel.isHidden = true
        clockIcon.isHidden = true
    
        whiteView.layer.cornerRadius = 20
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        blackSqareProfileImage.layer.cornerRadius = blackSqareProfileImage.frame.height / 2
        greenCircle.layer.cornerRadius = greenCircle.frame.height / 2
        profileImageButton.layer.cornerRadius = profileImageButton.frame.height / 2
        
        nameIsEdited(false)
        
        createLongPressGestureRecognizersAndAddToIDLabels()
        hideAllCopyButtons()
        hideAllGrayRectangles()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    @IBAction func addHoursButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "addOrEditHours", sender: nil)
    }
    
    @IBAction func grayPencilButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "addOrEditHours", sender: nil)
    }
    
    @IBAction func whitePencilDownButtonTapped(_ sender: UIButton) {
        nameIsEdited(true)
    }
    
    @IBAction func whiteCheckMarkButtonTupped(_ sender: UIButton) {
        nameIsEdited(false)
    }
    
    @IBAction func profileImageButtonTapped(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Сделать снимок", style: .default) { [weak self] _ in
            print("Сработала камера")
            
            self?.chooseImagePicker(source: .camera)
        }
        let photoGalleryAction = UIAlertAction(title: "Загрузить фото", style: .default) { [weak self] _ in
            print("Выбираем из галлереи")
            
            self?.chooseImagePicker(source: .photoLibrary)
            
        }
        let seePhotoAction = UIAlertAction(title: "Посмотреть фото", style: .default) { [weak self] _ in
            print("Посмотреть фото")
            
            self?.performSegue(withIdentifier: "showProfileImage", sender: nil)
        }
        let deletePhotoAction = UIAlertAction(title: "Удалить фото", style: .default) { [weak self] _ in
            self?.profileImage.image = UIImage(named: "noPhoto")
            
            
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoGalleryAction)
        actionSheet.addAction(seePhotoAction)
        actionSheet.addAction(deletePhotoAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
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
    
    @IBAction func skypeButtonTapped(_ sender: UIButton) {
        
        skypeGrayRectangle.isHidden = false
        
        let alertController = UIAlertController(title: "Ваш идентификатор в Skype", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] tf in
            tf.placeholder = self?.skypeIDLabel.text
        }
        
        let readyAction = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            self?.skypeIDLabel.text = alertController.textFields?.first?.text
            self?.skypeGrayRectangle.isHidden = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.skypeGrayRectangle.isHidden = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(readyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func whatsAppButtonTapped(_ sender: UIButton) {
        
        whatsAppGrayRectangle.isHidden = false
        
        let alertController = UIAlertController(title: "Ваш идентификатор в WhatsApp", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] tf in
            tf.placeholder = self?.whatsAppIDLabel.text
        }
        
        let readyAction = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            self?.whatsAppIDLabel.text = alertController.textFields?.first?.text
            self?.whatsAppGrayRectangle.isHidden = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.whatsAppGrayRectangle.isHidden = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(readyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func viberButtonTapped(_ sender: UIButton) {
        
        viberGrayRectangle.isHidden = false
        
        let alertController = UIAlertController(title: "Ваш идентификатор в Viber", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] tf in
            tf.placeholder = self?.viberIDLabel.text
        }
        
        let readyAction = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            self?.viberIDLabel.text = alertController.textFields?.first?.text
            self?.viberGrayRectangle.isHidden = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.viberGrayRectangle.isHidden = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(readyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func telegramButtonTapped(_ sender: UIButton) {
        
        telegramGrayRectangle.isHidden = false
        
        let alertController = UIAlertController(title: "Ваш идентификатор в Telegram", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] tf in
            tf.placeholder = self?.telegramIDLabel.text
        }
        
        let readyAction = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            self?.telegramIDLabel.text = alertController.textFields?.first?.text
            self?.telegramGrayRectangle.isHidden = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.telegramGrayRectangle.isHidden = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(readyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func slackButtonTapped(_ sender: UIButton) {
        
        slackGrayRectangle.isHidden = false
        
        let alertController = UIAlertController(title: "Ваш идентификатор в Slack", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] tf in
            tf.placeholder = self?.slackIDLabel.text
        }
        
        let readyAction = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            self?.slackIDLabel.text = alertController.textFields?.first?.text
            self?.slackGrayRectangle.isHidden = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.slackGrayRectangle.isHidden = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(readyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func iMessageButtonTapped(_ sender: UIButton) {
        
        iMessageGrayRectangle.isHidden = false
        
        let alertController = UIAlertController(title: "Ваш номер телефона", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] tf in
            tf.placeholder = self?.iMessageIDLabel.text
        }
        
        let readyAction = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            self?.iMessageIDLabel.text = alertController.textFields?.first?.text
            self?.iMessageGrayRectangle.isHidden = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.iMessageGrayRectangle.isHidden = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(readyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func mailButtonTapped(_ sender: UIButton) {
        
        mailGrayRectangle.isHidden = false
        
        let alertController = UIAlertController(title: "Ваш Email", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] tf in
            tf.placeholder = self?.mailIDLabel.text
        }
        
        let readyAction = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            self?.mailIDLabel.text = alertController.textFields?.first?.text
            self?.mailGrayRectangle.isHidden = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.mailGrayRectangle.isHidden = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(readyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func unwindFromEditHoursVC (segue: UIStoryboardSegue) {
        
        guard let editHoursVC = segue.source as? EditHoursViewController else { return }
        
        startTime = editHoursVC.startTime
        finishTime = editHoursVC.finishTime
        
        let stringTime = formatDate(date: startTime ?? Date()) + " — " + formatDate(date: finishTime ?? Date())
        workingHours.text = stringTime
        
        workHoursUpGrayLine.isHidden = false
        workHoursDownGrayLine.isHidden = false
        grayPencilButton.isHidden = false
        workingHours.isHidden = false
        workingHoursLabel.isHidden = false
        clockIcon.isHidden = false
        addHoursButton.isHidden = true
        
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
    
    private func nameIsEdited (_ isEdited: Bool) {
        if isEdited {
            whitePencilUp.isHidden = false
            whitePencilDown.isHidden = true
            whiteCheckMark.isHidden = false
            whiteLine.isHidden = false
            blackSqareProfileImage.alpha = 0.4
            whitePensilButton.isEnabled = false
            whiteCheckMarkButton.isEnabled = true
            firstAndLastNameTF.isUserInteractionEnabled = true
            positionTF.isUserInteractionEnabled = true
            profileImageButton.isUserInteractionEnabled = false
            
        } else {
            whitePencilUp.isHidden = true
            whitePencilDown.isHidden = false
            whiteCheckMark.isHidden = true
            whiteLine.isHidden = true
            blackSqareProfileImage.alpha = 0
            whitePensilButton.isEnabled = true
            whiteCheckMarkButton.isEnabled = false
            firstAndLastNameTF.isUserInteractionEnabled = false
            positionTF.isUserInteractionEnabled = false
            profileImageButton.isUserInteractionEnabled = true
        }
    }
   
   

}
 //MARK: ImagePickerController
extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImage.image = image
        
        dismiss(animated: true, completion: nil)
    }
    private func formatDate (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showProfileImage" {
            
            guard let seeUserPhotoVC = segue.destination as? SeeUserPhotoViewController else { return }
            seeUserPhotoVC.currentProfileImage = profileImage.image ?? #imageLiteral(resourceName: "tabBarProfileIcon")
        }
        if segue.identifier == "addOrEditHours" {
            
            guard let startTime = startTime, let finishTime = finishTime, let editHoursVC = segue.destination as? EditHoursViewController else { return }
            
            editHoursVC.startTime = startTime
            editHoursVC.finishTime = finishTime
        }
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
    private func hideAllGrayRectangles () {
        skypeGrayRectangle.isHidden = true
        whatsAppGrayRectangle.isHidden = true
        viberGrayRectangle.isHidden = true
        telegramGrayRectangle.isHidden = true
        slackGrayRectangle.isHidden = true
        iMessageGrayRectangle.isHidden = true
        mailGrayRectangle.isHidden = true
    }
    
    @objc private func kbShow (notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let kbHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        print("Высота клавиатуры: \(kbHeight)")
        
        defaultsContentsOffset = CGPoint(x: (self.view as! UIScrollView).contentOffset.x,
                                         y: (self.view as! UIScrollView).contentOffset.y)
        
        defaultViewHeightConstraintConstant = whiteViewHeightConstraint.constant
        
        whiteViewHeightConstraint.constant = whiteViewHeightConstraint.constant + kbHeight
     
        (self.view as! UIScrollView).setContentOffset(CGPoint(x: (self.view as! UIScrollView).contentOffset.x, y: (self.view as! UIScrollView).contentOffset.y + kbHeight - 80), animated: true)
    }
    
    @objc private func kbHide () {
        
        (self.view as! UIScrollView).setContentOffset(defaultsContentsOffset!, animated: true)
        
        whiteViewHeightConstraint.constant = defaultViewHeightConstraintConstant!
        
    }
}
