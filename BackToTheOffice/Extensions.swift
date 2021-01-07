//
//  Extensions.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 09.10.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import UIKit


let secretKey = "Qv9XcwpraF67mCmM"

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

// Функция позволяет устанавливать интервал между символами в UILabel
extension UILabel {
    func setCharacterSpacing (_ spasing: CGFloat) {
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        attributedStr.addAttribute(.kern, value: spasing, range: NSMakeRange(0, attributedStr.length))
        self.attributedText = attributedStr
    }
}
