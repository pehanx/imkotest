//
//  SettingsPhoneViewController.swift
//  Imiko
//
//  Created by Nikita Spekhin on 02.06.2022.
//

import UIKit
import SnapKit
import RxSwift
import DropDown

class SettingsPhoneViewController:BaseViewController {
    
    // MARK: - Properties
    private let profile:Profile
    private var buttonBottomConstraint:Constraint?
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Cambiar teléfono", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
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
    
    private let descriptionLabel = UILabel(text: "Puedes cambiar tu número de Teléfono", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), numberOfLines: 0, textAlignment: .center)
    
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
    
    private lazy var saveButton:BaseButton = {
        let btn = BaseButton(title: "Cambiar teléfono")
        btn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    init(_ profile: Profile){
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
        setupData()
    }
    
    // MARK: - Selectors
    @objc private func handleSave(){
        if let code = selectPhoneCodeView.phoneCodeLabel.text, let phone = selectPhoneCodeView.phoneTextField.text {
            profile.phone = "\(code)\(phone)"
            CoreDataHelper.save()
        }
        handleBack()
    }
    
    @objc private func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func selectPhoneCodeViewTap(){
//        selectPhoneCodeDropDown.show()
    }
    
    @objc private func selectPhoneCodeViewTextFieldTap(){
        selectPhoneCodeView.phoneTextField.becomeFirstResponder()
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
        
        [descriptionLabel, phoneStack].forEach{scrollView.addSubview($0)}
        
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
        
        phoneStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.width.equalToSuperview().offset(-36)
            make.bottom.greaterThanOrEqualToSuperview().offset(-20)
        }
    }
    
    private func bindRx() {
        selectPhoneCodeView.phoneTextField.rx.text.orEmpty.subscribe(onNext: { [weak self] phone in
            self?.saveButton.isEnabled = (!phone.isEmpty)
        }).disposed(by: disposeBag)
    }
    
    private func setupData(){
        guard let phone = profile.phone, let code = PhoneCode.allCases.map({ $0.code }).first(where: { phone.contains($0) }) else { return }
        let phoneWithoutCode = phone.replacingOccurrences(of: code, with: "")
        selectPhoneCodeView.phoneCodeLabel.text = code
        selectPhoneCodeView.phoneTextField.text = phoneWithoutCode
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
