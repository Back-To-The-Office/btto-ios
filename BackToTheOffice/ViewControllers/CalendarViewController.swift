//
//  CalendarViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 21.06.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import FSCalendar
import UIKit

class CalendarViewController: UIViewController {
    
    var isSave = false
    
    var unavailableDates: [String] = []
    var selectedDates: [Date] = [] {
        didSet {
            guard resetButton != nil else { return }
            resetButton.isEnabled = selectedDates.isEmpty ? false : true
        }
    }
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var whiteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteView.layer.cornerRadius = 20
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.allowsMultipleSelection = true
        calendar.appearance.titleFont = UIFont(name: "SF-Pro-Text-Semibold",
                                               size: 15)
        calendar.appearance.headerTitleFont = UIFont(name: "SF-Pro-Text-Semibold",
                                                     size: 17)
        calendar.appearance.weekdayFont = UIFont(name: "SF-Pro-Text-Semibold",
                                                     size: 15)
        
        resetButton.isEnabled = false
        resetButton.setTitleColor(UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.3),
                                  for: .disabled)
        resetButton.setTitleColor(UIColor(red: 0.173, green: 0.173, blue: 0.18, alpha: 1),
                                  for: .normal)
        for date in selectedDates {
            calendar.select(date)
        }
        resetButton.isEnabled = selectedDates.isEmpty ? false : true
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        for date in selectedDates {
            calendar.deselect(date)
        }
        selectedDates.removeAll()
        print("Reset")
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "UnwindFromCalendarVC", sender: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        isSave = true
        performSegue(withIdentifier: "UnwindFromCalendarVC", sender: nil)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //Метод возвращает выбранные пользователем даты
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let string = dateFormatter.string(from: date)
        
        if !unavailableDates.contains(string) && date.removeTimeStamp!.compare(Date().removeTimeStamp!) != .orderedAscending {
            selectedDates.append(date)
            print(date)
        }
    }
    //Метод возвращает отмененные пользователем даты
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {

        var index = -1
        
        for i in selectedDates {
            
            index += 1
            
            if i == date {
                selectedDates.remove(at: index)
            }
        }
    }
    //Окрашиваем кружки у нужных дат (из источника данных)
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let string = dateFormatter.string(from: date)
        
        if unavailableDates.contains(string) {
            return #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        }
        else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
            return nil
        }
        else {
            return nil
        }
    }
    //Делаем кружки у нужных дат (из источника данных, когда, при этом, их выбрал пользователь) такого же цвета, как в предыдущем методе. Что бы занятые даты "визуально не откликались" на тап пользователя
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let string = dateFormatter.string(from: date)
        
        if unavailableDates.contains(string) {
            return #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        }
        else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
            return .clear
        }
        else {
            return nil
        }
    }
    //Цвет текста у нужных дат (из источника данных)
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let string = dateFormatter.string(from: date)
        
        if unavailableDates.contains(string) {
            return .white
        }
        else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
            return #colorLiteral(red: 0.9138423204, green: 0.4763929248, blue: 0.4187745452, alpha: 1)
        }
        else {
            return nil
        }
    }
    //Цвет текста у нужных дат (из источника данных, когда, при этом, их выбрал пользователь) такого же цвета, как в предыдущем методе. Что бы занятые даты "не откликались" на тап пользователя
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let string = dateFormatter.string(from: date)
        
        if unavailableDates.contains(string) {
            return .white
        }
        else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
            return #colorLiteral(red: 0.9138423204, green: 0.4763929248, blue: 0.4187745452, alpha: 1)
        }
        else {
            return nil
        }
    }
}

