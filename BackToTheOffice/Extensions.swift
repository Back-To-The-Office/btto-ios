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
extension Date {
    //Это свойство будем использовать дальше, что бы определять, какие даты, на текущий момент, уже прошли
    var removeTimeStamp : Date? {
            guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
             return nil
            }
            return date
        }
    //Следующие 2 свойства будем использовать для определения диапазонов в массиве дат
    var dayAfter: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: noon)!
        
    }
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
        
    }
}
//Это расширение будем использовать для определения диапазонов в массиве дат
extension Collection where Element == Date {
    var grouped: [[Element]] {
        return reduce(into: []) {
            $0.last?.last?.dayAfter == $1.noon ?
            $0[$0.index(before: $0.endIndex)].append($1) :
            $0.append([$1])
        }
    }
}
//Это расширение будем использовать для добавления тени к UIView
extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float)
    {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
