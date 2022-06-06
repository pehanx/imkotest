//
//  SelectCountryView.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

class SelectCountryView:UIView {
    
    // MARK: - Views
    private let countryFlagImageView = UIImageView(image: R.image.flagMexico())
    private let dropDown = UIImageView(image: R.image.dropDown())
    private lazy var flagStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryFlagImageView])
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    private let divider:UIView = {
        let view = UIView()
        view.backgroundColor = R.color.border()
        return view
    }()
    let countryLabel = UILabel(text: "Mexico", font: .systemFont(ofSize: 16, weight: .medium), textColor: R.color.primaryText())
    
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
        
        addSubview(flagStack)
        flagStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.leading.equalTo(flagStack.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(2)
        }
        
        addSubview(countryLabel)
        countryLabel.snp.makeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func updateCountry(_ item: String) {
        countryFlagImageView.image = UIImage(named: "flag\(item)")
        countryLabel.text = item
    }
}
