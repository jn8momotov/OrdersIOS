//
//  FiltersViewController.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 06.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class FiltersViewController: UIViewController {
    private let dateOfBirthdayLabel = UILabel()
    private let dashLabel = UILabel()
    private let beginDateOfBirthdayTextField = DateOfBirthdayTextField()
    private let endDateOfBirthdayTextField = DateOfBirthdayTextField()
    
    private let genderLabel = UILabel()
    private let genderTextField = GenderTextField()
    
    private let doneButton = UIButton()
    
    var filters: Filters?
    var completion: FiltersHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    private func didTapCancelBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapDoneButton() {
        guard let beginText = beginDateOfBirthdayTextField.text,
            let endText = endDateOfBirthdayTextField.text,
            let genderText = genderTextField.text else {
            return
        }
        let beginDate = beginText.toDate()
        let endDate = endText.toDate()
        let gender = genderText.isEmpty ? nil : genderText
        let filters = Filters(begin: beginDate, end: endDate, gender: gender)
        completion?(filters)
        dismiss(animated: true, completion: nil)
    }
}

extension FiltersViewController {
    private func configureView() {
        title = "Filters"
        view.backgroundColor = .white
        addDateOfBirthdayLabel()
        addDashLabel()
        addBeginDateOfBirthdayTextField()
        addEndDateOfBirthdayTextField()
        addGenderLabel()
        addGenderTextField()
        addDoneButton()
        addCancelBarButtonItem()
    }
    
    private func addDateOfBirthdayLabel() {
        dateOfBirthdayLabel.text = "Date of birthday"
        dateOfBirthdayLabel.textColor = .black
        dateOfBirthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateOfBirthdayLabel)
        
        dateOfBirthdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        dateOfBirthdayLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        dateOfBirthdayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func addDashLabel() {
        dashLabel.text = "-"
        dashLabel.textColor = .black
        dashLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dashLabel)
        
        dashLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dashLabel.topAnchor.constraint(equalTo: dateOfBirthdayLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func addBeginDateOfBirthdayTextField() {
        beginDateOfBirthdayTextField.text = filters?.begin?.toString() ?? ""
        beginDateOfBirthdayTextField.placeholder = "Begin"
        beginDateOfBirthdayTextField.clearButtonMode = .always
        beginDateOfBirthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(beginDateOfBirthdayTextField)
        
        beginDateOfBirthdayTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        beginDateOfBirthdayTextField.rightAnchor.constraint(equalTo: dashLabel.leftAnchor, constant: -8).isActive = true
        beginDateOfBirthdayTextField.centerYAnchor.constraint(equalTo: dashLabel.centerYAnchor).isActive = true
        beginDateOfBirthdayTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addEndDateOfBirthdayTextField() {
        endDateOfBirthdayTextField.text = filters?.end?.toString() ?? ""
        endDateOfBirthdayTextField.placeholder = "End"
        endDateOfBirthdayTextField.clearButtonMode = .always
        endDateOfBirthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(endDateOfBirthdayTextField)
        
        endDateOfBirthdayTextField.leftAnchor.constraint(equalTo: dashLabel.rightAnchor, constant: 8).isActive = true
        endDateOfBirthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        endDateOfBirthdayTextField.centerYAnchor.constraint(equalTo: dashLabel.centerYAnchor).isActive = true
        endDateOfBirthdayTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addGenderLabel() {
        genderLabel.text = "Gender"
        genderLabel.textColor = .black
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderLabel)
        
        genderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        genderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        genderLabel.topAnchor.constraint(equalTo: dashLabel.bottomAnchor, constant: 32).isActive = true
    }
    
    private func addGenderTextField() {
        genderTextField.text = filters?.gender ?? ""
        genderTextField.placeholder = "Gender"
        genderTextField.clearButtonMode = .always
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderTextField)
        
        genderTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        genderTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        genderTextField.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8).isActive = true
        genderTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addDoneButton() {
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.systemBlue, for: .normal)
        doneButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)
        
        doneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    }
    
    private func addCancelBarButtonItem() {
        let buttonItem = UIBarButtonItem(title: "Cancel",
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapCancelBarButtonItem))
        navigationItem.leftBarButtonItem = buttonItem
    }
}
