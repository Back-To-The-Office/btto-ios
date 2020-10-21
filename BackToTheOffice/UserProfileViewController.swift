//
//  UserProfileViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 19.10.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
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
    
    @IBOutlet weak var whatsAppIDLebel: UILabel!
    
    @IBOutlet weak var viberIDLabel: UILabel!
    
    @IBOutlet weak var telegramIDLabel: UILabel!
    
    @IBOutlet weak var slackIDLabel: UILabel!
    
    @IBOutlet weak var iMessageIDLabel: UILabel!
    
    @IBOutlet weak var mailIDLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        whiteView.layer.cornerRadius = 20
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        blackSqareProfileImage.layer.cornerRadius = blackSqareProfileImage.frame.height / 2
        greenCircle.layer.cornerRadius = greenCircle.frame.height / 2
        profileImageButton.layer.cornerRadius = profileImageButton.frame.height / 2
        
        nameIsEdited(false)
        
        
        
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
            
//            let seePhotoController = UIAlertController(title: "Ваше фото", message: nil, preferredStyle: .alert)
//
//            let height = NSLayoutConstraint(item: seePhotoController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 400)
//
//            let width = NSLayoutConstraint(item: seePhotoController.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 400)
//
//            seePhotoController.view.addConstraint(height)
//            seePhotoController.view.addConstraint(width)
//
//            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width.constant , height: height.constant)))
//
//            seePhotoController.view.addSubview(imageView)
//
//
//            imageView.contentMode = .scaleAspectFill
//
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = 14
//            imageView.image = self.profileImage.image
//
//            self.present(seePhotoController, animated: true, completion: nil)
           
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showProfileImage", let seeUserPhotoVC = segue.destination as? SeeUserPhotoViewController else { return }
        seeUserPhotoVC.currentProfileImage = profileImage.image ?? #imageLiteral(resourceName: "tabBarProfileIcon")
    }
}
