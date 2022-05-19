//
//  BaseTextField.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 18.05.2022.
//

import UIKit

class BaseTextField:UITextField {
    let padding: CGFloat = 20
    
    public init(placeholder:String? = nil) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        setupUI()
    }
    
    private func setupUI(){
        textColor = R.color.primaryText()
        backgroundColor = .white
        layer.cornerRadius = 16
        autocorrectionType = .no
        heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        layer.shadowColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowOpacity = 1
        layer.shadowRadius = 16
        layer.masksToBounds = false
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
