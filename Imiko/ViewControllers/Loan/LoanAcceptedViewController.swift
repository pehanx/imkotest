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
    
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let personImageView = UIImageView(image: R.image.loanAccepted())
    private lazy var descriptionLabel = UILabel(text: "Y enviado para su revisión.\nPronto nos pondremos en contacto con usted", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), numberOfLines: 0, textAlignment: .center)
    
    private lazy var dataStackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [personImageView, descriptionLabel])
        stack.spacing = 24
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var applyLoanButton:BaseButton = {
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
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(BaseTabBarController())
    }
    
    // MARK: - Helpers
    private func setupUI(){
        [titleLabel, applyLoanButton, scrollView].forEach{bgView.addSubview($0)}
        scrollView.addSubview(dataStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        applyLoanButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(applyLoanButton.snp.top)
        }
        
        dataStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(37)
            make.trailing.equalToSuperview().offset(-37)
            make.width.equalToSuperview().offset(-74)
            make.bottom.greaterThanOrEqualToSuperview().offset(-24)
        }
        
    }
}
