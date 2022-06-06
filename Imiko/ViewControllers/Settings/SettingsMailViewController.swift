//
//  SettingsMailViewController.swift
//  Imiko
//
//  Created by Nikita Spekhin on 02.06.2022.
//

import UIKit
import SnapKit
import RxSwift

class SettingsMailViewController:BaseViewController {
    
    // MARK: - Properties
    private let profile:Profile
    private var buttonBottomConstraint:Constraint?
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Cambiar electrónico", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
    private lazy var backButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(R.image.backButton(), for: .normal)
        btn.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return btn
    }()
    
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let descriptionLabel = UILabel(text: "Puedes cambiar tu email", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), numberOfLines: 0, textAlignment: .center)
    
    // MARK: -- Email
    private let emailLabel = UILabel(text: "Ingrese su correo electrónico", font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private let emailTextField:BaseTextField = {
        let textField = BaseTextField(placeholder: "Correo electrónico")
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    private let emailErrorLabel = UILabel(text: "Dirección de correo electrónico incorrecta", font: .systemFont(ofSize: 12), textColor: R.color.red())
    private lazy var emailStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailErrorLabel])
        stack.axis = .vertical
        stack.spacing = 8
        emailErrorLabel.isHidden = true
        return stack
    }()
    
    private lazy var saveButton:BaseButton = {
        let btn = BaseButton(title: "Cambiar electrónico")
        btn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    init(_ profile: Profile){
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
        emailTextField.text = profile.email
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardNotificationSubscribe()
        bindRx()
    }
    
    // MARK: - Selectors
    @objc private func handleSave(){
        emailErrorLabel.isHidden = true
        guard let email = emailTextField.text, isValidEmail(email) else {
            emailErrorLabel.isHidden = false
            return
        }
        profile.email = emailTextField.text
        CoreDataHelper.save()
        handleBack()
    }
    
    @objc private func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    private func setupUI(){
        bgView.addSubview(titleLabel)
        bgView.addSubview(backButton)
        bgView.addSubview(scrollView)
        bgView.addSubview(saveButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        saveButton.snp.makeConstraints { make in
            buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20).constraint
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        [descriptionLabel, emailStack].forEach{scrollView.addSubview($0)}
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(52)
            make.trailing.equalToSuperview().offset(-52)
        }
        
        emailStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.width.equalToSuperview().offset(-36)
            make.bottom.greaterThanOrEqualToSuperview().offset(-20)
        }
    }
    
    private func bindRx() {
        emailTextField.rx.text.orEmpty.subscribe(onNext: { [weak self] phone in
            self?.saveButton.isEnabled = (!phone.isEmpty)
        }).disposed(by: disposeBag)
    }
    
    private func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func keyboardNotificationSubscribe() {
        keyboardHeight()
            .drive(onNext: { [unowned self] (value, animationDuration) in
                let constant = min(-20, -(value - safeAreaInsetsBottom - 20))
                buttonBottomConstraint?.update(offset: constant)
                
                let contentOffsetY = value == 0 ? 0 : 100
                var contetnOffset = scrollView.contentOffset
                contetnOffset.y = max(0, CGFloat(contentOffsetY) - safeAreaInsetsBottom)
                scrollView.setContentOffset(contetnOffset, animated: false)
                
                UIView.animate(withDuration: animationDuration) {
                    self.view.layoutIfNeeded()
                }
            }).disposed(by: disposeBag)
    }
    
}
