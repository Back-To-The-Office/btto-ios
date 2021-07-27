//
//  BookYourPlaceViewController.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 03.06.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import UIKit

class BookYourPlaceViewController: UIViewController {
    
    var currentSelectedDeskIndex = 0
    
    var unavailableDates = ["07-04-2021", "07-05-2021", "07-06-2021", "07-14-2021", "07-16-2021", "07-17-2021"]
    
    var dataSourseOfficeArray = [("Penza, Revolucionnaya, 71, 8th floor", true),
                                 ("Penza, Revolucionnaya, 72, 8th floor", false),
                                 ("Penza, Revolucionnaya, 73, 8th floor", false),
                                 ("Penza, Revolucionnaya, 74, 8th floor", false),
                                 ("Penza, Revolucionnaya, 75, 8th floor", false),
                                 ("Penza, Revolucionnaya, 76, 8th floor", false),
                                 ("Penza, Revolucionnaya, 77, 8th floor", false),
                                 ("Penza, Revolucionnaya, 78, 8th floor", false),
                                 ("Penza, Revolucionnaya, 79, 8th floor", false),
                                 ("Penza, Revolucionnaya, 80, 8th floor", false)]
    
    var dataSourseRoomArray = [("Room 1", true),
                               ("Room 2", false),
                               ("Room 3", false),
                               ("Room 4", false),
                               ("Room 5", false),
                               ("Room 6", false),
                               ("Room 7", false),
                               ("Room 8", false),
                               ("Room 9", false)]
    
    //Здесь накапливаются выбранные из календаря даты
    var selectedDates: [Date] = []
    
    //Вычисляемое свойство выявляет диапазоны в массиве дат selectedDates и возвращает массив с массивами
    //В каждом вложенном массиве либо отдельная дата, либо диапазон
    var datesDividedIntoRanges: [[Date]] {
        (selectedDates.sorted()).grouped
    }
    //Каждый раз, перед переходом к экрану выбора офиса или комнаты, в это свойство записывается "мы нажали на кнопку выбора офиса или же на кнопку выбора комнаты" и, затем, это свойство передается с сигвеем в SelectOfficeOrRoomViewController
    var isOfficeOrRoom: IsOfficeOrRoom?
    
    var desksArray: [Desk] = [Desk.init(numberOfPlaces: 15, numberOfReservedPlaces: 5),
                              Desk.init(numberOfPlaces: 10, numberOfReservedPlaces: 3),
                              Desk.init(numberOfPlaces: 7, numberOfReservedPlaces: 4),
                              Desk.init(numberOfPlaces: 11, numberOfReservedPlaces: 3),
                              Desk.init(numberOfPlaces: 14, numberOfReservedPlaces: 10),
                              Desk.init(numberOfPlaces: 4, numberOfReservedPlaces: 3),
                              Desk.init(numberOfPlaces: 15, numberOfReservedPlaces: 9),
                              Desk.init(numberOfPlaces: 10, numberOfReservedPlaces: 3),
                              Desk.init(numberOfPlaces: 5, numberOfReservedPlaces: 2),
                              Desk.init(numberOfPlaces: 6, numberOfReservedPlaces: 3),
                              Desk.init(numberOfPlaces: 16, numberOfReservedPlaces: 0),
                              Desk.init(numberOfPlaces: 15, numberOfReservedPlaces: 10),
                              Desk.init(numberOfPlaces: 2, numberOfReservedPlaces: 0),
                              Desk.init(numberOfPlaces: 16, numberOfReservedPlaces: 15),
                              Desk.init(numberOfPlaces: 15, numberOfReservedPlaces: 10),
                              Desk.init(numberOfPlaces: 14, numberOfReservedPlaces: 4),
                              Desk.init(numberOfPlaces: 7, numberOfReservedPlaces: 5),
                              Desk.init(numberOfPlaces: 11, numberOfReservedPlaces: 8),
                              Desk.init(numberOfPlaces: 8, numberOfReservedPlaces: 4),
                              Desk.init(numberOfPlaces: 5, numberOfReservedPlaces: 3),
                              Desk.init(numberOfPlaces: 4, numberOfReservedPlaces: 3),
                              Desk.init(numberOfPlaces: 10, numberOfReservedPlaces: 8),
                              Desk.init(numberOfPlaces: 14, numberOfReservedPlaces: 7),
                              Desk.init(numberOfPlaces: 16, numberOfReservedPlaces: 4)]
    
    @IBOutlet weak var bookYourPlaceTableView: UITableView!
    
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteView.layer.cornerRadius = 20
        
        bookYourPlaceTableView.layer.cornerRadius = 20
        
        bookYourPlaceTableView.dataSource = self
        bookYourPlaceTableView.delegate = self
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SegueToCalendarViewController" {
            if let calendarVC = segue.destination as? CalendarViewController {
                calendarVC.selectedDates = selectedDates
                calendarVC.unavailableDates = unavailableDates
            }
        }
        if segue.identifier == "SegueToSelectOfficeOrRoomViewController" {
            if let selectOfficeOrRoomVC = segue.destination as? SelectOfficeOrRoomViewController {
                selectOfficeOrRoomVC.isOfficeOrRoom = isOfficeOrRoom
                selectOfficeOrRoomVC.dataSourseOfficeArray = dataSourseOfficeArray
                selectOfficeOrRoomVC.dataSourseRoomArray = dataSourseRoomArray
            }
        }
    }
    @IBAction func unwindFromSelectOfficeOrRoomVC (segue: UIStoryboardSegue) {
        
        guard let selectOfficeOrRoom = segue.source as? SelectOfficeOrRoomViewController, selectOfficeOrRoom.isSave, let bookYourPlaceFirstTableViewCell = bookYourPlaceTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BookYourPlaceFirstTableViewCell
        else { return }
        
        dataSourseOfficeArray = selectOfficeOrRoom.dataSourseOfficeArray
        dataSourseRoomArray = selectOfficeOrRoom.dataSourseRoomArray
        
        if selectOfficeOrRoom.isOfficeOrRoom == .Office {
            
            for i in selectOfficeOrRoom.dataSourseOfficeArray {
                if i.1 {
                    bookYourPlaceFirstTableViewCell.officeLabel.text = i.0
                }
            }
        }
        else {
            for i in selectOfficeOrRoom.dataSourseRoomArray {
                if i.1 {
                    bookYourPlaceFirstTableViewCell.roomLabel.text = i.0
                }
            }
        }
    }
    
    @IBAction func unwindFromCalendarVC (segue: UIStoryboardSegue) {
        
        guard let calendarVC = segue.source as? CalendarViewController else { return }
        
        //print("unwindFromCalendarVC")
        
        if calendarVC.isSave {
            selectedDates = calendarVC.selectedDates
        }
        guard let bookYourPlaceFirstTableViewCell = bookYourPlaceTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BookYourPlaceFirstTableViewCell else { return }
        checkSelectedDates (bookYourPlaceFirstTableViewCell: bookYourPlaceFirstTableViewCell)
    }
    func createSelectetDatesLabel (datesDividedIntoRanges: [[Date]]) -> String {
        
        var selectetDatesLabel = ""
        //Массив с массивами Date преобразуем в массив с массивами  String
        var datesDividedIntoRangesString: [[String]] = []
        
        for datesArray in datesDividedIntoRanges {
            var datesArrayString: [String] = []
            
            for date in datesArray {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yy"
                let dateString = dateFormatter.string(from: date)
                
                datesArrayString.append(dateString)
            }
            datesDividedIntoRangesString.append(datesArrayString)
        }
        
        print(datesDividedIntoRangesString)
        
        for datesArray in datesDividedIntoRangesString {
            
            //Eсли во внутреннем массиве 1 дата (String)
            if datesArray.count == 1 {
                
                if let firstDate = datesArray.first {
                    
                    let tempString = ", \(firstDate[..<firstDate.index(firstDate.startIndex, offsetBy: 5)])"
                    selectetDatesLabel += tempString
                }
                //Eсли во внутреннем массиве больше одной даты (String)
            } else {
                if let firstDate = datesArray.first, let lastDate = datesArray.last {
                    
                    let tempString = ", \(firstDate[..<firstDate.index(firstDate.startIndex, offsetBy: 5)])-\(lastDate[..<lastDate.index(lastDate.startIndex, offsetBy: 5)])"
                    selectetDatesLabel += tempString
                }
            }
        }
        selectetDatesLabel = String(selectetDatesLabel.dropFirst(2))
        
        return selectetDatesLabel
    }
    func checkSelectedDates(bookYourPlaceFirstTableViewCell: BookYourPlaceFirstTableViewCell) {
    
        if !selectedDates.isEmpty {
            bookYourPlaceFirstTableViewCell.addDaysButton.isEnabled = false
            bookYourPlaceFirstTableViewCell.addDaysButton.isHidden = true
            
            bookYourPlaceFirstTableViewCell.selectedDatesLabel.isHidden = false
            bookYourPlaceFirstTableViewCell.selectedDatesLabel.text = createSelectetDatesLabel(datesDividedIntoRanges: datesDividedIntoRanges)
            
            bookYourPlaceFirstTableViewCell.bluePencilButton.isEnabled = true
            bookYourPlaceFirstTableViewCell.bluePencilButton.isHidden = false
        }
        else {
            bookYourPlaceFirstTableViewCell.addDaysButton.isEnabled = true
            bookYourPlaceFirstTableViewCell.addDaysButton.isHidden = false
            
            bookYourPlaceFirstTableViewCell.selectedDatesLabel.isHidden = true
            
            bookYourPlaceFirstTableViewCell.bluePencilButton.isEnabled = false
            bookYourPlaceFirstTableViewCell.bluePencilButton.isHidden = true
        }
    }
}

extension BookYourPlaceViewController: UITableViewDataSource, UITableViewDelegate,  BookYourPlaceFirstTableViewCellDelegate, BookYourPlaceSecondTableViewCellDelegate, BookYourPlaceThirdTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return 1
        }
        else {
            return desksArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BookYourPlaceFirstTableViewCell", for: indexPath) as! BookYourPlaceFirstTableViewCell
            
            checkSelectedDates(bookYourPlaceFirstTableViewCell: cell as! BookYourPlaceFirstTableViewCell)
            //Подписываемся на протокол BookYourPlaceFirstTableViewCellDelegate и прописываем кастомной ячейке BookYourPlaceFirstTableViewCell, что ее свойство delegate (с типом BookYourPlaceFirstTableViewCellDelegate) равно этому контроллеру
            (cell as! BookYourPlaceFirstTableViewCell).delegate = self
        }
        else if indexPath.section == 1 {
           cell = tableView.dequeueReusableCell(withIdentifier: "BookYourPlaceSecondTableViewCell", for: indexPath) as! BookYourPlaceSecondTableViewCell
            
            //Подписываемся на протокол BookYourPlaceSecondTableViewCellDelegate и прописываем кастомной ячейке BookYourSecondFirstTableViewCell, что ее свойство delegate (с типом BookYourSecondFirstTableViewCellDelegate) равно этому контроллеру
            (cell as! BookYourPlaceSecondTableViewCell).delegate = self
            
            (cell as! BookYourPlaceSecondTableViewCell).blueCircle.isHidden = true
            
            (cell as! BookYourPlaceSecondTableViewCell).configureDesks(numberOfPlaces: desksArray[indexPath.row].numberOfPlaces, numberOfReservedPlaces: desksArray[indexPath.row].numberOfReservedPlaces)
            
            if indexPath.row == currentSelectedDeskIndex {
                (cell as! BookYourPlaceSecondTableViewCell).blueCircle.isHidden = false
            }
            (cell as! BookYourPlaceSecondTableViewCell).tableLabel.text = "Table \(indexPath.row + 1)"
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "BookYourPlaceThirdTableViewCell", for: indexPath) as! BookYourPlaceThirdTableViewCell
            (cell as! BookYourPlaceThirdTableViewCell).delegate = self
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 615
        }
        else if indexPath.section == 1 {
            
            if desksArray[indexPath.row].numberOfPlaces > 8 {
                return 165
            }
            else {
                return 100
            }
        }
        else {
            return 120
        }
    }
    //Передаем нажатия из кастомной ячейки BookYourPlaceFirstTableViewCell через протокол
    func bluePencilButtonTapped() {
        performSegue(withIdentifier: "SegueToCalendarViewController", sender: nil)
    }
    func addDaysButtonTapped() {
        performSegue(withIdentifier: "SegueToCalendarViewController", sender: nil)
    }
    func selectOfficeButtonTapped() {
        isOfficeOrRoom = .Office
        performSegue(withIdentifier: "SegueToSelectOfficeOrRoomViewController", sender: nil)
    }
    func selectRoomButtonTapped() {
        isOfficeOrRoom = .Room
        performSegue(withIdentifier: "SegueToSelectOfficeOrRoomViewController", sender: nil)
    }
    //Передаем нажатия из кастомных ячеек BookYourPlaceSecondTableViewCell через протокол
    //Передаем IndexPath конкретной ячейки в параметрах каждого метода
    func radioButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        if let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell) {
            currentSelectedDeskIndex = currentIndexPath.row
            bookYourPlaceTableView.reloadData()
            print("Выбрана ячейка с индексом \(currentIndexPath.row)")
        }
    }
    
    func chair1ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 1 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair2ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 2 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair3ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 3 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair4ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 4 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair5ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 5 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair6ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 6 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair7ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 7 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair8ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 8 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair9ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 9 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair10ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 10 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair11ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 11 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair12ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 12 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair13ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 13 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair14ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 14 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair15ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 15 в ячейке с индексом \(currentIndexPath!.row)")
    }
    
    func chair16ButtonTapped(currentCell: BookYourPlaceSecondTableViewCell) {
        let currentIndexPath = bookYourPlaceTableView.indexPath(for: currentCell)
        print("Нажали стул 16 в ячейке с индексом \(currentIndexPath!.row)")
    }
    //Передаем нажатиe кнопки Save из кастомной ячейки BookYourPlaceThirdTableViewCell через протокол
    func saveButtonTapped() {
        print("Нажали \"SAVE\"")
    }
}

