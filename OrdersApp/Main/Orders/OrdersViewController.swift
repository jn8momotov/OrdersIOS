//
//  OrdersViewController.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class OrdersViewController: UIViewController {
    private var presenter: OrdersPresenter!
    
    private var reloadBarButtonItem: UIBarButtonItem!
    private var addingBarButtonItem: UIBarButtonItem!
    private let tableView = UITableView(frame: .zero)
    private let filterButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OrdersPresenterImpl(view: self)
        configureView()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    @objc
    private func didTapReloadBarButtonItem() {
        presenter.loadOrders()
    }
    
    @objc
    private func didTapAddingBarButtonItem() {
        let view = InputOrderViewController()
        view.presenter = InputOrderPresenterImpl(view: view)
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc
    private func didTapFilterButton() {
        let view = FiltersViewController()
        view.filters = presenter.filters
        view.completion = { [weak self] filters in
            print("Begin: \(String(describing: filters.begin))")
            print("End: \(String(describing: filters.end))")
            print("Gender: \(String(describing: filters.gender))")
            self?.presenter.doneFilters(filters: filters)
        }
        let navigation = UINavigationController(rootViewController: view)
        present(navigation, animated: true, completion: nil)
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.orders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as? OrderCell else {
            return UITableViewCell()
        }
        cell.set(presenter.orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = InputOrderViewController()
        view.presenter = InputOrderPresenterImpl(view: view, order: presenter.orders[indexPath.row])
        navigationController?.pushViewController(view, animated: true)
    }
}

extension OrdersViewController {
    private func configureView() {
        title = "Orders"
        view.backgroundColor = .white
        addFilterButton()
        addTableView()
        addReloadBarButtonItem()
        addAddingBarButtonItem()
    }
    
    private func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: filterButton.topAnchor).isActive = true
        
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.identifier)
    }
    
    private func addReloadBarButtonItem() {
        reloadBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                              target: self,
                                              action: #selector(didTapReloadBarButtonItem))
        navigationItem.leftBarButtonItem = reloadBarButtonItem
    }
    
    private func addAddingBarButtonItem() {
        addingBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                              target: self,
                                              action: #selector(didTapAddingBarButtonItem))
        navigationItem.rightBarButtonItem = addingBarButtonItem
    }
    
    private func addFilterButton() {
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(.systemBlue, for: .normal)
        filterButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterButton)
        
        filterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        filterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        filterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
    }
}
