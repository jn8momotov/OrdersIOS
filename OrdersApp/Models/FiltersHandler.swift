//
//  FiltersHandler.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 06.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation

typealias Filters = (begin: Date?, end: Date?, gender: String?)

typealias FiltersHandler = (Filters) -> Void
