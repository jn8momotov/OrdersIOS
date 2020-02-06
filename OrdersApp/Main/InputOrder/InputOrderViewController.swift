//
//  InputOrderViewController.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class InputOrderViewController: UIViewController {
    var presenter: InputOrderPresenter!
    
    private let nameTextField = OrderValueTextField()
    private let dateOfBirthdayTextField = DateOfBirthdayTextField()
    private let genderTextField = GenderTextField()
    private let commentTextView = UITextView()
    private let commentLabel = UILabel()
    private let deleteButton = UIButton()
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func updateView(order: Order) {
        nameTextField.text = order.name
        dateOfBirthdayTextField.text = order.birthDay
        genderTextField.text = order.gender
        commentTextView.text = order.comment
    }
    
    @objc
    private func didTapSaveButton() {
        save()
    }
    
    @objc
    private func didTapDeleteButton() {
        presenter.delete()
    }
    
    private func save() {
        guard let name = nameTextField.text,
            let dateOfBirthday = dateOfBirthdayTextField.text,
            let gender = genderTextField.text,
            let comment = commentTextView.text else {
            return
        }
        guard !name.isEmpty,
            !dateOfBirthday.isEmpty,
            !gender.isEmpty,
            !comment.isEmpty else {
            showAlert(title: "Input all fields!")
            return
        }
        presenter.save(name: name, dateOfBirthday: dateOfBirthday, gender: gender, comment: comment)
    }
}

extension InputOrderViewController {
    private func configureView() {
        title = "Order"
        view.backgroundColor = .white
        addNameTextField()
        addDateOfBirthdayTextField()
        addGenderTextField()
        addCommentLabel()
        addCommentTextView()
        addSaveButton()
        addDeleteButton()
    }
    
    private func addNameTextField() {
        nameTextField.placeholder = "Name"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addDateOfBirthdayTextField() {
        dateOfBirthdayTextField.placeholder = "Date of birthday"
        dateOfBirthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateOfBirthdayTextField)
        
        dateOfBirthdayTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        dateOfBirthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        dateOfBirthdayTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8).isActive = true
        dateOfBirthdayTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addGenderTextField() {
        genderTextField.placeholder = "Gender"
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderTextField)
        
        genderTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        genderTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        genderTextField.topAnchor.constraint(equalTo: dateOfBirthdayTextField.bottomAnchor, constant: 8).isActive = true
        genderTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addCommentLabel() {
        commentLabel.text = "Comment"
        commentLabel.textColor = .black
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentLabel)
        
        commentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        commentLabel.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant: 8).isActive = true
    }
    
    private func addCommentTextView() {
        commentTextView.backgroundColor = .white
        commentTextView.layer.cornerRadius = 6
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.borderWidth = 1
        commentTextView.clipsToBounds = true
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTextView)
        
        commentTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        commentTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        commentTextView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8).isActive = true
        commentTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func addSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        saveButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    private func addDeleteButton() {
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)
        
        deleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    }
}
