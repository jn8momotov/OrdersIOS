//
//  InputOrderPresenter.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation

protocol InputOrderPresenter {
    func save(name: String, dateOfBirthday: String, gender: String, comment: String)
    func delete()
}

final class InputOrderPresenterImpl: InputOrderPresenter {
    private weak var view: InputOrderViewController?
    private let networkService: NetworkService = NetworkServiceImpl()
    
    private var order: Order?
    private let inputType: InputType
    
    private var completion: (Data?, Error?) -> Void {
        return { [weak self] data, error in
            if data != nil, error == nil {
                NotificationCenter.default.post(name: .updateOrders, object: nil)
                self?.view?.navigationController?.popViewController(animated: true)
            } else {
                self?.view?.showAlert(title: "Error sending order!")
            }
        }
    }
    
    init(view: InputOrderViewController, order: Order? = nil) {
        self.view = view
        self.order = order
        self.inputType = (order == nil) ? .new : .edit
        if let order = order {
            view.updateView(order: order)
        }
    }
    
    func save(name: String, dateOfBirthday: String, gender: String, comment: String) {
        let newOrder = order ?? Order()
        newOrder.name = name
        newOrder.birthDay = dateOfBirthday
        newOrder.gender = gender
        newOrder.comment = comment
        let method: HTTPMethod = (inputType == .new) ? .post : .put
        request(newOrder, method: method)
    }
    
    func delete() {
        guard let order = order else {
            return
        }
        request(order, method: .delete)
    }
}

extension InputOrderPresenterImpl {
    private func request(_ order: Order, method: HTTPMethod) {
        switch method {
        case .post:
            post(order, completion: completion)
        case .put:
            put(order, completion: completion)
        case .delete:
            if let id = order.id {
                delete(id: id, completion: completion)
            }
        default:
            return
        }
    }
    
    private func post(_ order: Order, completion: @escaping (Data?, Error?) -> Void) {
        networkService.post(order) { data, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func put(_ order: Order, completion: @escaping (Data?, Error?) -> Void) {
        networkService.put(order) { data, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func delete(id: Int, completion: @escaping (Data?, Error?) -> Void) {
        networkService.delete(id: id) { data, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
