//
//  OrdersPresenter.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation

protocol OrdersPresenter {
    var orders: [Order] { get }
    var filters: Filters? { get }
    func loadOrders()
    func doneFilters(filters: Filters)
}

final class OrdersPresenterImpl: OrdersPresenter {
    private weak var view: OrdersViewController?
    private let networkService: NetworkService = NetworkServiceImpl()
    
    private var allOrders: [Order] = [] {
        didSet {
            orders = allOrders
        }
    }
    
    var orders: [Order] = [] {
        didSet {
            view?.reloadTableView()
        }
    }
    
    var filters: Filters?
    
    init(view: OrdersViewController) {
        self.view = view
        loadOrders()
        addObserver()
    }
    
    func doneFilters(filters: Filters) {
        var result = allOrders
        if let beginDate = filters.begin {
            result = result.filter({ $0.birthDay.toDate() ?? Date() >= beginDate })
        }
        if let endDate = filters.end {
            result = result.filter({ $0.birthDay.toDate() ?? Date() <= endDate })
        }
        if let gender = filters.gender {
            result = result.filter({ $0.gender == gender })
        }
        self.filters = filters
        orders = result
    }
    
    func loadOrders() {
        networkService.get(Orders.self) { model, error in
            DispatchQueue.main.async {
                if let orders = model?.content {
                    self.allOrders = orders
                } else {
                    self.view?.showAlert(title: "Error loading orders!")
                }
            }
        }
    }
}

extension OrdersPresenterImpl {
    private func addObserver() {
        NotificationCenter.default.addObserver(forName: .updateOrders,
                                               object: nil,
                                               queue: nil) { [weak self] _ in
            self?.loadOrders()
        }
    }
}
