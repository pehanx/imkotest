//
//  RegisterSecondStepViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit
import SnapKit
import RxSwift
import DropDown
import DZLabel

class RegisterSecondStepViewController: BaseViewController {
    
    // MARK: - Properties
    private var buttonBottomConstraint:Constraint?
    var profile:Profile
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Registro", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
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
    
    private let descriptionLabel = UILabel(text: "Ingrese su ubicación, número de teléfono móvil\ny correo electrónico", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), numberOfLines: 0, textAlignment: .center)
    
    // MARK: -- Country
    private let countryLabel = UILabel(text: "Ingrese su ubicación", font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private lazy var selectCountryView:SelectCountryView = {
        let view = SelectCountryView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCountryViewTap)))
        return view
    }()
    private lazy var selectCountryDropDown:DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = selectCountryView
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 16
        dropDown.dataSource = [
            "Mexico",
            "USA"
        ]
        dropDown.cellHeight = 56
        dropDown.cellNib = UINib(nibName: "FlagDropDownTableViewCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? FlagDropDownTableViewCell else { return }
            cell.flagImageView.image = UIImage(named: "flag\(item)")
            cell.optionLabel.text = item
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectCountryView.updateCountry(item)
        }
        return dropDown
    }()
    private lazy var countryStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryLabel, selectCountryView])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    // MARK: -- Phone
    private let phoneLabel = UILabel(text: "Ingrese su ubicación", font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private lazy var selectPhoneCodeView:SelectPhoneCodeView = {
        let view = SelectPhoneCodeView()
        view.phoneStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoneCodeViewTap)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoneCodeViewTextFieldTap)))
        return view
    }()
    private lazy var selectPhoneCodeDropDown:DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = selectPhoneCodeView
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 16
        dropDown.dataSource = PhoneCode.allCases.map { $0.code }
        dropDown.cellHeight = 56
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.text = item
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectPhoneCodeView.updatePhoneCode(item)
        }
        return dropDown
    }()
    private lazy var phoneStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneLabel, selectPhoneCodeView])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
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
    
    private lazy var textFieldsStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryStack, phoneStack, emailStack])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var startButton:BaseButton = {
        let btn = BaseButton(title: "Empezar a utilizar")
        btn.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
        return btn
    }()
    
    private lazy var privacyLabel:DZLabel = {
        let label = DZLabel()
        label.dzFont = .systemFont(ofSize: 12, weight: .medium)
        label.dzNumberOfLines = 0
        label.dzTextAlignment = .center
        label.dzTextColor = R.color.primaryText()
        label.dzLinkColor = R.color.blue()!
        label.dzText = "Al hacer clic en inicio, acepta nuestra\nPolítica de privacidad y términos"
        label.dzEnabledTypes = [.regex(pattern: "\\s(Política de privacidad y términos)\\b")]
        label.dzHandleRegexKeywordTap { [weak self] _ in
            let vc = PrivacyViewController()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
        return label
    }()
    
    // MARK: - Lifecycle
    init(profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
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
    @objc private func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func selectCountryViewTap(){
//        selectCountryDropDown.show()
    }
    
    @objc private func selectPhoneCodeViewTap(){
//        selectPhoneCodeDropDown.show()
    }
    
    @objc private func selectPhoneCodeViewTextFieldTap(){
        selectPhoneCodeView.phoneTextField.becomeFirstResponder()
    }
    
    @objc private func handleStart(){
        emailErrorLabel.isHidden = true
        guard let email = emailTextField.text, isValidEmail(email) else {
            emailErrorLabel.isHidden = false
            return
        }
        profile.place = selectCountryView.countryLabel.text
        if let code = selectPhoneCodeView.phoneCodeLabel.text, let phone = selectPhoneCodeView.phoneTextField.text {
            profile.phone = "\(code)\(phone)"
        }
        profile.email = emailTextField.text
        CoreDataHelper.save()
        
        let vc = NewLoanViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helpers
    
    private func setupUI(){
        bgView.addSubview(titleLabel)
        bgView.addSubview(backButton)
        bgView.addSubview(scrollView)
        bgView.addSubview(privacyLabel)
        bgView.addSubview(startButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        privacyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            buttonBottomConstraint = make.bottom.equalTo(privacyLabel.snp.top).offset(-16).constraint
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
            make.bottom.equalTo(startButton.snp.top)
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
            make.bottom.greaterThanOrEqualToSuperview().offset(-28)
        }

    }
    
    private func bindRx() {
        Observable
            .combineLatest(selectPhoneCodeView.phoneTextField.rx.text.orEmpty,
                           emailTextField.rx.text.orEmpty)
            .bind { [unowned self] phone, email in
                self.startButton.isEnabled = (!phone.isEmpty &&
                                              !email.isEmpty)
            }.disposed(by: disposeBag)
    }
    
    private func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func keyboardNotificationSubscribe() {
        keyboardHeight()
            .drive(onNext: { [unowned self] (value, animationDuration) in
                let constant = min(-16, -(value - safeAreaInsetsBottom - 30))
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
