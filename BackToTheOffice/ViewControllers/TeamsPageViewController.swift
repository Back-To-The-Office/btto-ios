//
//  TeamsPageViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 18.01.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class TeamsPageViewController: UIPageViewController {
    
    var pageNumber = 0
    
    var contentViewControllersArray: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillContentViewControllersArray()
        
        view.backgroundColor = .white
        
        delegate = self
        dataSource = self
        
        setViewControllers([contentViewControllersArray[0]], direction: .forward, animated: true, completion: nil)
        
    }
    private func fillContentViewControllersArray () {
        
        guard let firstVC = storyboard?.instantiateViewController(identifier: "MyTeamsVcOrAllTeams") as? TeamsViewController else { return }
           
        firstVC.pageNumber = 0
        firstVC.isAllTeams = false
        
        contentViewControllersArray.append(firstVC)
        
        guard let secondVC = storyboard?.instantiateViewController(identifier: "MyTeamsVcOrAllTeams") as? TeamsViewController else { return }
           
        secondVC.pageNumber = 1
        secondVC.isAllTeams = true
        
        contentViewControllersArray.append(secondVC)
    }
    
}

extension TeamsPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard (viewController as? TeamsViewController)?.pageNumber == 1 else {
            return nil }
        
        return contentViewControllersArray[0]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard (viewController as? TeamsViewController)?.pageNumber == 0 else {
            return nil
        }
        return contentViewControllersArray[1]
    }
    
    
}
