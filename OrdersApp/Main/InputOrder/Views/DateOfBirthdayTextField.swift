//
//  DateOfBirthdayTextField.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 06.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class DateOfBirthdayTextField: OrderValueTextField {
    private let datePicker = UIDatePicker()
    
    override init() {
        super.init()
        addPickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func datePickerValueChanged() {
        text = datePicker.date.toString()
    }
}

extension DateOfBirthdayTextField {
    private func addPickerView() {
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        inputView = datePicker
    }
}
