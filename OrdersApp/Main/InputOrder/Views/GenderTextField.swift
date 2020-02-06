//
//  GenderTextField.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 06.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class GenderTextField: OrderValueTextField {
    private let pickerView = UIPickerView()
    
    override init() {
        super.init()
        addPickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getGender(at row: Int) -> String {
        return (row == 1) ? "FEMALE" : "MALE"
    }
}

extension GenderTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getGender(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = getGender(at: row)
    }
}

extension GenderTextField {
    private func addPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        inputView = pickerView
    }
}
