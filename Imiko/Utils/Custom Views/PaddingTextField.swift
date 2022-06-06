//
//  PaddingTextField.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 18.05.2022.
//

import UIKit

class PaddingTextField:UITextField {
    let padding: CGFloat
    
    public init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
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
