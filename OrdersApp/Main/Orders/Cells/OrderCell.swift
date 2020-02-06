//
//  OrderCell.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class OrderCell: UITableViewCell {
    static let identifier = String(describing: OrderCell.self)
    
    private let nameLabel = UILabel()
    private let commentLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ order: Order) {
        nameLabel.text = order.name
        commentLabel.text = order.comment
    }
}

extension OrderCell {
    private func configureViewCell() {
        selectionStyle = .none
        backgroundColor = .white
        
        addArrowImageView()
        addNameLabel()
        addCommentLabel()
    }
    
    private func addNameLabel() {
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12).isActive = true
    }
    
    private func addCommentLabel() {
        commentLabel.font = .systemFont(ofSize: 16, weight: .regular)
        commentLabel.textColor = .lightGray
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentLabel)
        
        commentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -8).isActive = true
        commentLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12).isActive = true
    }
    
    private func addArrowImageView() {
        arrowImageView.image = #imageLiteral(resourceName: "arrow")
        arrowImageView.tintColor = .lightGray
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowImageView)
        
        arrowImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 7).isActive = true
    }
}
