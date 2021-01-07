//
//  TokenModel.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 27.12.2020.
//  Copyright © 2020 Roman Egorov. All rights reserved.
//

import Foundation

struct TokenModel: Codable {
    
    let scope: String
    let jti: String
    let expiresIn: Int
    let tokenType: String
    let accessToken: String
    
}
