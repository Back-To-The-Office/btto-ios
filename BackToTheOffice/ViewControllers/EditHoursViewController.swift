//
//  EditHoursViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 05.01.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class EditHoursViewController: UIViewController {
    
    var startTime: Date?
    var finishTime: Date?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var finishDatePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.layer.cornerRadius = 20
        
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.tintColor = .black
        startDatePicker.backgroundColor = .clear
        
        startDatePicker.layer.cornerRadius = 4
        startDatePicker.layer.borderWidth = 1
        startDatePicker.layer.borderColor = #colorLiteral(red: 0.1607843137, green: 0.4745098039, blue: 1, alpha: 1)
        
        finishDatePicker.preferredDatePickerStyle = .compact
        finishDatePicker.tintColor = .black
        finishDatePicker.backgroundColor = .clear
        
        finishDatePicker.layer.cornerRadius = 4
        finishDatePicker.layer.borderWidth = 1
        finishDatePicker.layer.borderColor = #colorLiteral(red: 0.1607843137, green: 0.4745098039, blue: 1, alpha: 1)
        
        guard let startTime = startTime, let finishTime = finishTime else { return }
        
        startDatePicker.setDate(startTime, animated: true)
        finishDatePicker.setDate(finishTime, animated: true)
        
        titleLabel.text = "Edit"
        bigLabel.text = "Edit hours"
    }
    
    @IBAction func cancelButtonTupped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startDatePickerChange(_ sender: UIDatePicker) {
        startTime = startDatePicker.date
        finishTime = finishDatePicker.date
        print(startDatePicker.date.description)
    }
    
    @IBAction func finishDatePickerChange(_ sender: UIDatePicker) {
        startTime = startDatePicker.date
        finishTime = finishDatePicker.date
    }
//    private func showErrorMessage (title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        let oKAction = UIAlertAction (title: "Ок", style: .default) { action in
//            alertController.dismiss(animated: true, completion: nil)
//        }
//
//        alertController.addAction(oKAction)
//
//        present(alertController, animated: true, completion: nil)
//    }
    
    
}
