//
//  BookYourPlaceViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 03.06.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class BookYourPlaceViewController: UIViewController {

    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteView.layer.cornerRadius = 20
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
    }
    
}
