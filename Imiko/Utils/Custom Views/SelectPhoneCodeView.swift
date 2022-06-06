//
//  SelectPhoneCodeView.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

class SelectPhoneCodeView:UIView {
    
    // MARK: - Views
    let phoneCodeLabel = UILabel(text: PhoneCode.mexico.code, font: .systemFont(ofSize: 16, weight: .medium), textColor: R.color.primaryText())
    private let dropDown = UIImageView(image: R.image.dropDown())
    lazy var phoneStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneCodeLabel])
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    private let divider:UIView = {
        let view = UIView()
        view.backgroundColor = R.color.border()
        return view
    }()
    let phoneTextField:UITextField = {
        let textField = UITextField()
        textField.textColor = R.color.primaryText()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        return textField
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Helpers
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        heightAnchor.constraint(equalToConstant: 56).isActive = true
        layer.shadowColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowOpacity = 1
        layer.shadowRadius = 16
        layer.masksToBounds = false
        
        addSubview(phoneStack)
        phoneStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.leading.equalTo(phoneStack.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(2)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func updatePhoneCode(_ item: String) {
        phoneCodeLabel.text = item
    }
}
