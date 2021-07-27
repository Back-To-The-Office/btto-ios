//
//  SelectOfficeViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 06.06.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

enum IsOfficeOrRoom {
    case Office
    case Room
}
import UIKit

class SelectOfficeOrRoomViewController: UIViewController {
    
    var dataSourseOfficeArray: [(String,Bool)] = []
    
    var dataSourseRoomArray: [(String,Bool)] = []
    
    var isOfficeOrRoom: IsOfficeOrRoom!
    
    var isSave = false
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var officeOrRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        whiteView.layer.cornerRadius = 20
        
        officeOrRoomTableView.delegate = self
        officeOrRoomTableView.dataSource = self
        
        officeOrRoomTableView.tableFooterView = UIView()
        
    }
    
    @IBAction func ChooseButtonTapped(_ sender: UIButton) {
        isSave = true
        performSegue(withIdentifier: "UnwindFromSelectOfficeOrRoomVC", sender: nil)
    }
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "UnwindFromSelectOfficeOrRoomVC", sender: nil)
    }
}
extension SelectOfficeOrRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isOfficeOrRoom == .Office {
            return dataSourseOfficeArray.count
        }
        else {
            return dataSourseRoomArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectOfficeOrRoomTableViewCell", for: indexPath) as! SelectOfficeOrRoomTableViewCell
        
        cell.selectionStyle = .none
        
        if isOfficeOrRoom == .Office {
            cell.officeOrRoomLabel.text = dataSourseOfficeArray[indexPath.row].0
            cell.blueCircle.isHidden = !dataSourseOfficeArray[indexPath.row].1
        }
        else {
            cell.officeOrRoomLabel.text = dataSourseRoomArray [indexPath.row].0
            cell.blueCircle.isHidden = !dataSourseRoomArray[indexPath.row].1
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(dataSourseOfficeArray[indexPath.row])
        
        if isOfficeOrRoom == .Office {
            
            for i in 0 ... dataSourseOfficeArray.count - 1 {
                dataSourseOfficeArray[i].1 = false
            }
            dataSourseOfficeArray[indexPath.row].1 = true
        }
        if isOfficeOrRoom == .Room {
            
            for i in 0 ... dataSourseRoomArray.count - 1 {
                dataSourseRoomArray[i].1 = false
            }
            dataSourseRoomArray[indexPath.row].1 = true
        }
        officeOrRoomTableView.reloadData()
    }
}
