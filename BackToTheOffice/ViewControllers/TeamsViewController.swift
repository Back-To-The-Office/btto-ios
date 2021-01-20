//
//  TeamsViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 17.01.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController {
    
    var activButtonTextColor: UIColor = #colorLiteral(red: 0.2274509804, green: 0.2274509804, blue: 0.2352941176, alpha: 1)
    var noActivButtonTextColor: UIColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
    
    var pageNumber = 0
    
    
    var isAllTeams = false
    
    var testDataSourceArray = [("Kirill Gundyaev", "Patriarch"),
                               ("Iosif Stalin", "Dictator"),
                               ("Donald Tramp", "Politician"),
                               ("Fidel Castro", "Revolutionary"),
                               ("Ivan Grozniy", "Grand Duke"),
                               ("Leonid Yakubovich", "Showman")
    ]
    var testTeamNames = ["Human resources department", "Board of directors", "Sales managers", "Cleaners", "Bird watchers", "Murder department", "Bookkeeping", "Slave department", "Preobrazhensky regiment", "Transport shop", "Microcircuit department"]
    
    
    @IBOutlet weak var myTeamsButton: UIButton!
    
    @IBOutlet weak var allTeamsButton: UIButton!
    
    @IBOutlet weak var teamsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        
        teamsTableView.tableFooterView = UIView()
        
        if isAllTeams {
            myTeamsButton.setTitleColor(noActivButtonTextColor, for: .normal)
            myTeamsButton.isUserInteractionEnabled = true
            allTeamsButton.setTitleColor(activButtonTextColor, for: .normal)
            allTeamsButton.isUserInteractionEnabled = false
        } else {
            myTeamsButton.setTitleColor(activButtonTextColor, for: .normal)
            myTeamsButton.isUserInteractionEnabled = false
            allTeamsButton.setTitleColor(noActivButtonTextColor, for: .normal)
            allTeamsButton.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func myTeamsButtonTapped(_ sender: UIButton) {
        guard let pageViewController = parent as? TeamsPageViewController else { return }
        pageViewController.setViewControllers([pageViewController.contentViewControllersArray[0]], direction: .forward, animated: false, completion: nil)
    }
    
    @IBAction func allTeamsButtonTapped(_ sender: UIButton) {
        guard let pageViewController = parent as? TeamsPageViewController else { return }
        pageViewController.setViewControllers([pageViewController.contentViewControllersArray[1]], direction: .reverse, animated: false, completion: nil)
    }
    
    private func createTestCellProfilesImageArray () -> [String] {
        let randomCountProfiles = Int.random(in: 3...15)
        var testCellProfilesArray: [String] = []
        
        for _ in 1 ... randomCountProfiles {
            let randomIndex = Int.random(in: 0...testDataSourceArray.count - 1 )
            let profileImage = "testProfileImage\(randomIndex)"
            
            testCellProfilesArray.append(profileImage)
        }
        return testCellProfilesArray
    }
    
    private func createTestCell (_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsCell", for: indexPath) as! TeamsTableViewCell
        
        cell.teamImage.layer.cornerRadius = cell.teamImage.frame.size.height / 2
        cell.teamImage.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9607843137, alpha: 1)
        
        // Временный код для создания тестовых ячеек
        let teamLabelText = isAllTeams ? testTeamNames[indexPath.row] : testTeamNames[Int.random(in: 0...testTeamNames.count - 1)]
        cell.teamLabel.text = teamLabelText
        cell.profileImageLabel.text = teamLabelText.components(separatedBy: CharacterSet.whitespacesAndNewlines).map { String($0.prefix(1).capitalized)}.joined()
        
        if Int.random(in: 0...6) == 6 {
            cell.profileImageLabel.isHidden = true
            let teamImageNamed = Bool.random() ? "verify" : "testImageSign"
            
            cell.teamImage.contentMode = .scaleAspectFill
            cell.teamImage.image = UIImage(named: teamImageNamed)
        }
        let testCellProfilesImageArray = createTestCellProfilesImageArray()
        
        cell.greenCircle0.layer.cornerRadius = 2
        cell.greenCircle0.isHidden = Bool.random()
        cell.profileImage0.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
        cell.profileImage0.image = UIImage(named: testCellProfilesImageArray[0])
        
        cell.greenCircle1.layer.cornerRadius = 2
        cell.greenCircle1.isHidden = Bool.random()
        cell.profileImage1.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
        cell.profileImage1.image = UIImage(named: testCellProfilesImageArray[1])
        
        cell.greenCircle2.layer.cornerRadius = 2
        cell.greenCircle2.isHidden = Bool.random()
        cell.profileImage2.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
        cell.profileImage2.image = UIImage(named: testCellProfilesImageArray[2])
        
        cell.greenCircle3.isHidden = true
        cell.profileImage3.isHidden = true
        
        cell.greenCircle4.isHidden = true
        cell.profileImage4.isHidden = true
        
        cell.greenCircle5.isHidden = true
        cell.profileImage5.isHidden = true
        
        cell.greenCircle6.isHidden = true
        cell.profileImage6.isHidden = true
        
        cell.greenCircle7.isHidden = true
        cell.profileImage7.isHidden = true
        
        cell.hiddenProfilesCount.isHidden = true
        
        switch testCellProfilesImageArray.count {
        case 4:
            cell.greenCircle3.layer.cornerRadius = 2
            cell.greenCircle3.isHidden = Bool.random()
            cell.profileImage3.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage3.isHidden = false
            cell.profileImage3.image = UIImage(named: testCellProfilesImageArray[3])
        case 5:
            cell.greenCircle3.layer.cornerRadius = 2
            cell.greenCircle3.isHidden = Bool.random()
            cell.profileImage3.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage3.isHidden = false
            cell.profileImage3.image = UIImage(named: testCellProfilesImageArray[3])
            
            cell.greenCircle4.layer.cornerRadius = 2
            cell.greenCircle4.isHidden = Bool.random()
            cell.profileImage4.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage4.isHidden = false
            cell.profileImage4.image = UIImage(named: testCellProfilesImageArray[4])
        case 6:
            cell.greenCircle3.layer.cornerRadius = 2
            cell.greenCircle3.isHidden = Bool.random()
            cell.profileImage3.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage3.isHidden = false
            cell.profileImage3.image = UIImage(named: testCellProfilesImageArray[3])
            
            cell.greenCircle4.layer.cornerRadius = 2
            cell.greenCircle4.isHidden = Bool.random()
            cell.profileImage4.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage4.isHidden = false
            cell.profileImage4.image = UIImage(named: testCellProfilesImageArray[4])
            
            cell.greenCircle5.layer.cornerRadius = 2
            cell.greenCircle5.isHidden = Bool.random()
            cell.profileImage5.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage5.isHidden = false
            cell.profileImage5.image = UIImage(named: testCellProfilesImageArray[5])
        case 7:
            cell.greenCircle3.layer.cornerRadius = 2
            cell.greenCircle3.isHidden = Bool.random()
            cell.profileImage3.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage3.isHidden = false
            cell.profileImage3.image = UIImage(named: testCellProfilesImageArray[3])
            
            cell.greenCircle4.layer.cornerRadius = 2
            cell.greenCircle4.isHidden = Bool.random()
            cell.profileImage4.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage4.isHidden = false
            cell.profileImage4.image = UIImage(named: testCellProfilesImageArray[4])
            
            cell.greenCircle5.layer.cornerRadius = 2
            cell.greenCircle5.isHidden = Bool.random()
            cell.profileImage5.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage5.isHidden = false
            cell.profileImage5.image = UIImage(named: testCellProfilesImageArray[5])
            
            cell.greenCircle6.layer.cornerRadius = 2
            cell.greenCircle6.isHidden = Bool.random()
            cell.profileImage6.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage6.isHidden = false
            cell.profileImage6.image = UIImage(named: testCellProfilesImageArray[6])
        case 8:
            cell.greenCircle3.layer.cornerRadius = 2
            cell.greenCircle3.isHidden = Bool.random()
            cell.profileImage3.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage3.isHidden = false
            cell.profileImage3.image = UIImage(named: testCellProfilesImageArray[3])
            
            cell.greenCircle4.layer.cornerRadius = 2
            cell.greenCircle4.isHidden = Bool.random()
            cell.profileImage4.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage4.isHidden = false
            cell.profileImage4.image = UIImage(named: testCellProfilesImageArray[4])
            
            cell.greenCircle5.layer.cornerRadius = 2
            cell.greenCircle5.isHidden = Bool.random()
            cell.profileImage5.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage5.isHidden = false
            cell.profileImage5.image = UIImage(named: testCellProfilesImageArray[5])
            
            cell.greenCircle6.layer.cornerRadius = 2
            cell.greenCircle6.isHidden = Bool.random()
            cell.profileImage6.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage6.isHidden = false
            cell.profileImage6.image = UIImage(named: testCellProfilesImageArray[6])
            
            cell.greenCircle7.layer.cornerRadius = 2
            cell.greenCircle7.isHidden = Bool.random()
            cell.profileImage7.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage7.isHidden = false
            cell.profileImage7.image = UIImage(named: testCellProfilesImageArray[7])
        case 9...15:
            cell.greenCircle3.layer.cornerRadius = 2
            cell.greenCircle3.isHidden = Bool.random()
            cell.profileImage3.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage3.isHidden = false
            cell.profileImage3.image = UIImage(named: testCellProfilesImageArray[3])
            
            cell.greenCircle4.layer.cornerRadius = 2
            cell.greenCircle4.isHidden = Bool.random()
            cell.profileImage4.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage4.isHidden = false
            cell.profileImage4.image = UIImage(named: testCellProfilesImageArray[4])
            
            cell.greenCircle5.layer.cornerRadius = 2
            cell.greenCircle5.isHidden = Bool.random()
            cell.profileImage5.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage5.isHidden = false
            cell.profileImage5.image = UIImage(named: testCellProfilesImageArray[5])
            
            cell.greenCircle6.layer.cornerRadius = 2
            cell.greenCircle6.isHidden = Bool.random()
            cell.profileImage6.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage6.isHidden = false
            cell.profileImage6.image = UIImage(named: testCellProfilesImageArray[6])
            
            cell.greenCircle7.layer.cornerRadius = 2
            cell.greenCircle7.isHidden = Bool.random()
            cell.profileImage7.layer.cornerRadius = cell.profileImage0.frame.size.height / 2
            cell.profileImage7.isHidden = false
            cell.profileImage7.image = UIImage(named: testCellProfilesImageArray[7])
            
            let hiddenProfileCount = 15 - testCellProfilesImageArray.count
            cell.hiddenProfilesCount.isHidden = false
            cell.hiddenProfilesCount.text = "+\(hiddenProfileCount)"
        default:
            break
        }
        
        
        return cell
    }
}

extension TeamsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isAllTeams ? testTeamNames.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return createTestCell(tableView, indexPath: indexPath)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
