//
//  SeeUserPhotoViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 21.10.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class SeeUserPhotoViewController: UIViewController {
    
    var currentProfileImage: UIImage!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.image = currentProfileImage
    }
    

    

}
