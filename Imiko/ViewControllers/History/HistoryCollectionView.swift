//
//  HistoryCollectionView.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

class HistoryCollectionView:UICollectionView  {
    
    var didSelectSum: ((Int) -> ())?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.className)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        contentInset.top = 24
        contentInset.bottom = 24
    }
    
}

class HistoryCell:UICollectionViewCell {
    
    // MARK: - Views
    private let iconImageView = UIImageView(image: R.image.launchIcon())
    private let priceLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: R.color.primaryText())
    private let durationLabel = UILabel(font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.primaryText())
    private let approvedLabel = UILabel(font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.gray())
    private lazy var dataStackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, durationLabel, approvedLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    private let statusLabel = UILabel(font: .systemFont(ofSize: 12, weight: .medium), textColor: R.color.red())
    
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
        contentView.layer.cornerRadius = 16
        clipsToBounds = true
        contentView.backgroundColor = .white
        layer.shadowColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowOpacity = 1
        layer.shadowRadius = 16
        layer.masksToBounds = false
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(dataStackView)
        dataStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(iconImageView.snp.trailing).offset(24)
            make.bottom.equalToSuperview().offset(-16)
        }
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupData(_ item:Credit) {
        if let price = item.price {
            priceLabel.text = "$\(price)"
        }
        durationLabel.text = "Por \(item.days) días"
        if let date = item.approvedDate {
            approvedLabel.text = "Aprobado \(date.toDateString)"
        }
        statusLabel.text = item.type.title
        statusLabel.textColor = item.type.color
    }
}
