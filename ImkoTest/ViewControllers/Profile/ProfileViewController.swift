//
//  ProfileViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation
import UIKit

class ProfileViewController:BaseViewController {

    // MARK: - Properties
    
    // MARK: - Views
    private let profileImageView:UIImageView = {
        let imageView = UIImageView(image: R.image.placeholderAvatar())
        imageView.layer.cornerRadius = 58
        return imageView
    }()
    private lazy var nameLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: R.color.primaryText(), textAlignment: .center)
    private lazy var placeLabel = UILabel(font: .systemFont(ofSize: 16, weight: .medium), textColor: R.color.primaryText(), textAlignment: .center)
    private let settingsTitle = UILabel(text: "Configuración de Perfil", font: .boldSystemFont(ofSize: 24), textColor: R.color.primaryText(), textAlignment: .center)
    private lazy var fioView = createRowView(type: .fio)
    private lazy var phoneView = createRowView(type: .phone)
    private lazy var mailView = createRowView(type: .mail)
    private lazy var languageView = createRowView(type: .language)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Helpers
    private func setupUI(){
        [profileImageView, nameLabel, placeLabel, settingsTitle, fioView, phoneView, mailView, languageView].forEach{bgView.addSubview($0)}
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(41)
            make.centerX.equalToSuperview()
            make.size.equalTo(116)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
        }
        placeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        settingsTitle.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
        fioView.snp.makeConstraints { make in
            make.top.equalTo(settingsTitle.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(75)
        }
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(fioView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(75)
        }
        mailView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(75)
        }
        languageView.snp.makeConstraints { make in
            make.top.equalTo(mailView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(75)
        }
    }
    
    private func createRowView(type: ProfileItem) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 16
        view.layer.masksToBounds = false
        
        let iconImageView = UIImageView(image: type.image)
        let titleLabel = UILabel(text: type.title, font: .boldSystemFont(ofSize: 16), textColor: R.color.primaryText())
        let descriptionLabel = UILabel(text: type.subTitle, font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.primaryText())
        let arrowImageView = UIImageView(image: R.image.arrowForward())
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 8
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(76)
        }
        
        view.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        return view
    }
    
    private func setupData(){
        guard let profile = ProfileManager.shared.getModel else { return }
        self.nameLabel.text = profile.fullName
        self.placeLabel.text = profile.place
    }
}
