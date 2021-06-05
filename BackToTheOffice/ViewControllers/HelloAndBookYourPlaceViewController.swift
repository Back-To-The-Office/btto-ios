//
//  HelloAndBookYourPlaceViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 02.06.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class HelloAndBookYourPlaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BookYourPlaceButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueToBookYourPlaceViewController", sender: nil)
    }
}
