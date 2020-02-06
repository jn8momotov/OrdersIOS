//
//  Order.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation

final class Order: Codable {
    let id: Int?
    var birthDay: String
    var comment: String
    var gender: String
    var name: String
    
    init() {
        self.id = nil
        self.birthDay = ""
        self.comment = ""
        self.gender = ""
        self.name = ""
    }
    
    init(id: Int, birthDay: String, comment: String, gender: String, name: String) {
        self.id = id
        self.birthDay = birthDay
        self.comment = comment
        self.gender = gender
        self.name = name
    }
}
