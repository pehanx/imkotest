//
//  HelpViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit
import SnapKit

class HelpViewController:BaseViewController {
    
    // MARK: - Properties
    private var buttonBottomConstraint:Constraint?
    
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
    private lazy var sendButton:BaseButton = {
        let btn = BaseButton(title: "Enviar")
        btn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardNotificationSubscribe()
    }
    
    // MARK: - Selectors
    @objc private func handleSend() {
        let alert = UIAlertController(title: "¡Gracias!", message: "Su mensaje ha sido enviado, en breve nos pondremos en contacto con usted. ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Listo", style: .default, handler: { [weak self] action in
            self?.questionField.text?.removeAll()
        }))
        present(alert, animated: true)
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
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20).constraint
        }
    }
    
    private func keyboardNotificationSubscribe() {
        keyboardHeight()
            .drive(onNext: { [unowned self] (value, animationDuration) in
                let constant = min(-20, -(value - safeAreaInsetsBottom - 20))
                buttonBottomConstraint?.update(offset: constant)
                
                UIView.animate(withDuration: animationDuration) {
                    self.view.layoutIfNeeded()
                }
            }).disposed(by: disposeBag)
    }
}
