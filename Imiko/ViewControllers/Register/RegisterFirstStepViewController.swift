//
//  RegisterFirstStepViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 18.05.2022.
//

import UIKit
import SnapKit
import RxSwift

class RegisterFirstStepViewController: BaseViewController {
    
    // MARK: - Properties
    private var buttonBottomConstraint:Constraint?
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Registro", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
    
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let descriptionLabel = UILabel(text: "Ingrese su apellido, nombre y patronímico\n(si está disponible)", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), numberOfLines: 0, textAlignment: .center)
    
    private let nameLabel = UILabel(text: "Ingrese su apellido", font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private let nameTextField = BaseTextField(placeholder: "Apellido")
    private lazy var nameStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let surnameLabel = UILabel(text: "Ingrese su nombre", font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private let surnameTextField = BaseTextField(placeholder: "Nombre")
    private lazy var surnameStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [surnameLabel, surnameTextField])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let patronymicLabel = UILabel(text: "Ingrese su patronímico (si está disponible)", font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private let patronymicTextField = BaseTextField(placeholder: "Patronímico")
    private lazy var patronymicStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [patronymicLabel, patronymicTextField])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var textFieldsStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameStack, surnameStack, patronymicStack])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var nextStepButton:BaseButton = {
        let btn = BaseButton(title: "Siguiente Paso")
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardNotificationSubscribe()
        bindRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.nameTextField.becomeFirstResponder()
        }
    }
    
    // MARK: - Selectors
    @objc private func handleNext(){
        let profile = Profile(context: CoreDataHelper.context)
        profile.name = nameTextField.text
        profile.surname = surnameTextField.text
        profile.patronymic = patronymicTextField.text
        
        navigationController?.pushViewController(RegisterSecondStepViewController(profile: profile), animated: true)
    }
    
    // MARK: - Helpers
    private func setupUI(){
        bgView.addSubview(titleLabel)
        bgView.addSubview(scrollView)
        bgView.addSubview(nextStepButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        nextStepButton.snp.makeConstraints { make in
            buttonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20).constraint
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        [
            descriptionLabel,
            textFieldsStack
        ].forEach{scrollView.addSubview($0)}
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(nextStepButton.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(52)
            make.trailing.equalToSuperview().offset(-52)
        }
        
        textFieldsStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.width.equalToSuperview().offset(-36)
            make.bottom.greaterThanOrEqualToSuperview().offset(-20)
        }
    }
    
    private func bindRx() {
        Observable
            .combineLatest(nameTextField.rx.text.orEmpty,
                           surnameTextField.rx.text.orEmpty,
                           patronymicTextField.rx.text.orEmpty)
            .bind { [unowned self] name, surname, patronymic in
                self.nextStepButton.isEnabled = (!name.isEmpty &&
                                                 !surname.isEmpty &&
                                                 !patronymic.isEmpty)
            }.disposed(by: disposeBag)
    }
    
    private func keyboardNotificationSubscribe() {
        keyboardHeight()
            .drive(onNext: { [unowned self] (value, animationDuration) in
                let constant = min(-20, -(value - safeAreaInsetsBottom + 20))
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
