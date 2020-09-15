//
//  LoginViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 14.09.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
       
    }
    

    @IBAction func button(_ sender: UIButton) {
        
       let timeZone = TimeZone.current.abbreviation(for: Date())
        
        label.text = timeZone?.description
        
        
    }
    

}
