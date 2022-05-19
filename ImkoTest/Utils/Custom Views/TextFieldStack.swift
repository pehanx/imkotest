//
//  TextFieldStack.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 18.05.2022.
//

import UIKit

class TextFieldStack:UIView {
    
    private let textLabel = UILabel(font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.primaryText())
    private let textField:PaddingTextField = {
        let textField = PaddingTextField(padding: 20)
        textField.textColor = R.color.primaryText()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        textField.autocorrectionType = .no
        textField.textContentType = .name
        return textField
    }()
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textLabel, textField])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    public init(labelText: String, placeholder: String) {
        super.init(frame: .zero)
        textLabel.text = labelText
        textField.placeholder = placeholder
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        textField.snp.makeConstraints {$0.height.equalTo(56)}
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
