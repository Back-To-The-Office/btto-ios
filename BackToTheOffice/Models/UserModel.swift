//
//  UserModel.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 26.12.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import Foundation

struct UserModel {
    let contacts: String?
    let email: String?
    let firstName: String?
    let id: Int?
    let lastName: String?
    let position: String?
    let timesone: Timezone?
    
}
struct Timezone {
    let id: String?
}

//enum ContactTypes {
//    case telegramm
//    case scype
//}
//
//
//class sss {
//    var dictionary: [ContactTypes : String] = [:]
//
//    private func setDictionary () {
//    dictionary[ContactTypes.telegramm] = "tgsdghdjdjd"
//    
//    }
//
//}
