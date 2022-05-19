//
//  HelpViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

class HelpViewController:BaseViewController {
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Asistencia técnica", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
    private let descriptionLabel = UILabel(text: "Aquí puede hacer cualquier pregunta sobre\nla aplicación o dejar una queja sobre el problema", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), numberOfLines: 0, textAlignment: .center)
    private let questionLabel = UILabel(text: "Escribe tu pregunta o queja", font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private let questionField = BaseTextField(placeholder: "Cuestión o queja")
    private lazy var questionStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [questionLabel, questionField])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    private lazy var sendButton = BaseButton(title: "Enviar")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Helpers
    private func setupUI(){
        [titleLabel, descriptionLabel, questionStack, sendButton].forEach{bgView.addSubview($0)}
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        questionStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
