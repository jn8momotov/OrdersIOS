//
//  OrderValueTextField.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

class OrderValueTextField: UITextField {
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderValueTextField {
    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 6
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.frame.height))
        leftViewMode = .always
    }
}
