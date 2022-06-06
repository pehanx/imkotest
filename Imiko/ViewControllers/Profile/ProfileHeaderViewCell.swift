//
//  ProfileHeaderViewCell.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 01.06.2022.
//

import UIKit

class ProfileHeaderViewCell:UICollectionReusableView {
    
    // MARK: - Views
    private let profileImageView:UIImageView = {
        let imageView = UIImageView(image: R.image.placeholderAvatar())
        imageView.layer.cornerRadius = 58
        return imageView
    }()
    private let imageBgView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 63
        view.layer.shadowColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 16
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        return view
    }()
    private lazy var nameLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: R.color.primaryText(), textAlignment: .center)
    private lazy var placeLabel = UILabel(font: .systemFont(ofSize: 16, weight: .medium), textColor: R.color.primaryText(), textAlignment: .center)
    private let settingsTitle = UILabel(text: "Configuración de Perfil", font: .boldSystemFont(ofSize: 24), textColor: R.color.primaryText(), textAlignment: .center)
    
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
    private func setupUI(){
        [imageBgView, nameLabel, placeLabel, settingsTitle].forEach{addSubview($0)}
        
        imageBgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
            make.size.equalTo(126)
        }
        imageBgView.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    func setupData(_ profile: Profile?) {
        guard let profile = profile else { return }
        self.nameLabel.text = profile.fullName
        self.placeLabel.text = profile.place
    }
}
