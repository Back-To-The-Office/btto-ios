//
//  CompanyViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 16.01.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {
    
    var testDataSourceArray = [("Kirill Gundyaev", "Patriarch"),
                           ("Iosif Stalin", "Dictator"),
                           ("Donald Tramp", "Politician"),
                           ("Fidel Castro", "Revolutionary"),
                           ("Ivan Grozniy", "Grand Duke"),
                           ("Leonid Yakubovich", "Showman")
    ]
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var companyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteView.layer.cornerRadius = 20
        
        searchTF.delegate = self
        
        companyTableView.delegate = self
        companyTableView.dataSource = self
        
        companyTableView.tableFooterView = UIView()
        
        setupSearchTF()
    }
    
    private func setupSearchTF () {
        searchTF.layer.cornerRadius = 10
        
        //Вставляем в поле поиска картинку лупы
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        
        searchImageView.frame = CGRect(x: 12,
                                       y: searchTF.frame.size.height / 2 - 8,
                                       width: 16,
                                       height: 16)
        
        searchTF.addSubview(searchImageView)
        //Делам так, что бы вводимый в текстовое поле текст не заезжал на лупу
        let leftView = UIView.init(frame: CGRect(x: 12,
                                                 y: 0,
                                                 width: 34,
                                                 height: 34))
        searchTF.leftView = leftView
        searchTF.leftViewMode = .always
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
extension CompanyViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyTableViewCell
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height / 2
        cell.profileImage.image = UIImage(named: "testProfileImage\(indexPath.row)")
        cell.firstNameAndLastNameLabel.text = testDataSourceArray[indexPath.row].0
        cell.positionLabel.text = testDataSourceArray[indexPath.row].1
        cell.greenCircle.layer.cornerRadius = 4
        
        //Временная затычка
        cell.greenCircle.isHidden = Bool.random()
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
