//
//  ProfileItemCollectionViewCell.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 01.06.2022.
//

import Foundation
import UIKit

class ProfileItemCollectionViewCell:UICollectionViewCell {
    
    // MARK: - Views
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: R.color.primaryText())
    private let descriptionLabel = UILabel(font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.primaryText())
    private let arrowImageView = UIImageView(image: R.image.arrowForward())
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override var isHighlighted: Bool {
        didSet{
            isHighlighted()
        }
    }
    
    // MARK: - Helpers
    private func setupUI(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.layer.shadowColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 0.25).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 16
        contentView.layer.masksToBounds = false
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 8
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(76)
        }
        
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupData(_ item:ProfileItem) {
        iconImageView.image = item.image
        titleLabel.text = item.title
        descriptionLabel.text = item.subTitle
    }
    
}
