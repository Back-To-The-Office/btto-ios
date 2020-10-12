//
//  Extensions.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 09.10.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit

extension UIView {
    
    func addVerticalGradientLayer (topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [topColor,bottomColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
