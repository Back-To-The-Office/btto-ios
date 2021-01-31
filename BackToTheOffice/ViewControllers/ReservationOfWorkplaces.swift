//
//  ReservationOfWorkplaces.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 22.01.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit
import SpriteKit
import  GameplayKit

class ReservationOfWorkplaces: UIViewController {
    
    let sceneManager = SceneManager.shared
    
    var testDataSourceArray = [("Kirill Gundyaev", "Patriarch"),
                           ("Iosif Stalin", "Dictator"),
                           ("Donald Tramp", "Politician"),
                           ("Fidel Castro", "Revolutionary"),
                           ("Ivan Grozniy", "Grand Duke"),
                           ("Leonid Yakubovich", "Showman")]
    
    var scene: ReservationOfWorkplacesScene!
    
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
            let skView = SKView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: view.frame.size.height))
        view.addSubview(skView)
        
        if sceneManager.workplacesScene == nil {
            scene = ReservationOfWorkplacesScene(size: skView.frame.size)
        } else {
            scene = sceneManager.workplacesScene
            scene.isLoaded = true
            print("Load scene")
        }
        
        
            skView.presentScene(scene)
            
            skView.ignoresSiblingOrder = true
            
            skView.showsFPS = true
            skView.showsNodeCount = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        sceneManager.workplacesScene = scene
        print("Save scene")
    }
    
    @IBAction func rightBarButtonItemTapped(_ sender: UIBarButtonItem) {
        if rightBarButtonItem.title == "Edit" {
            rightBarButtonItem.title = "Save"
            scene.isEditModeOn = true
        } else {
            rightBarButtonItem.title = "Edit"
            scene.isEditModeOn = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}


