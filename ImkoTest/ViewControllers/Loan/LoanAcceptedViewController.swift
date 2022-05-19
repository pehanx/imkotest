//
//  LoanAcceptedViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit
import DZLabel

class LoanAcceptedViewController:BaseViewController {
    
    // MARK: - Views
    private let titleLabel:UILabel = {
        let label = UILabel()
        let string = NSMutableAttributedString()
        string.append("Solicitud ", font: .boldSystemFont(ofSize: 28), color: R.color.primaryText())
        string.append("aceptada", font: .boldSystemFont(ofSize: 28), color: R.color.blue())
        label.attributedText = string
        return label
    }()
    
    private let personImageView = UIImageView(image: R.image.loanAccepted())
    private lazy var descriptionLabel:DZLabel = {
        let label = DZLabel()
        label.dzFont = .systemFont(ofSize: 14)
        label.dzNumberOfLines = 0
        label.dzTextAlignment = .center
        label.dzTextColor = R.color.primaryText()
        label.dzLinkColor = R.color.blue()!
        label.dzText = "Y enviado para su revisión.\nPronto nos pondremos en contacto con usted"
        label.dzEnabledTypes = [.regex(pattern: "\\s(en contacto con usted)\\b")]
        label.dzHandleRegexKeywordTap { _ in
            if let url = URL(string: "https://www.google.com/") {
                UIApplication.shared.open(url)
            }
        }
        return label
    }()
    
    private lazy var applyLoan:BaseButton = {
        let btn = BaseButton(title: "A la principal")
        btn.addTarget(self, action: #selector(handleToMain), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Selectors
    @objc private func handleToMain(){
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func setupUI(){
        [titleLabel, personImageView, descriptionLabel, applyLoan].forEach{bgView.addSubview($0)}
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        personImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(129)
            make.leading.equalToSuperview().offset(37)
            make.trailing.equalToSuperview().offset(-37)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(personImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        applyLoan.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
