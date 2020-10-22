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
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true

        profileImage.image = currentProfileImage
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        scrollView.zoomScale = 1
        scrollView.delegate = self
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

extension SeeUserPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return profileImage
        
        
    }
    
    
}
