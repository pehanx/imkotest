//
//  BaseButton.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 18.05.2022.
//

import UIKit

class BaseButton:UIButton {
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
    
    convenience init(title:String? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 16
        backgroundColor = R.color.blue()
        heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        layer.shadowColor = UIColor(red: 0.262, green: 0.262, blue: 0.262, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowOpacity = 1
        layer.shadowRadius = 16
        layer.masksToBounds = false
    }
}
