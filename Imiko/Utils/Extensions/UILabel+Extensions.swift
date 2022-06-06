//
//  UILabel+Extensions.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 18.05.2022.
//

import UIKit

extension UILabel {
    convenience public init(text: String? = nil, font: UIFont, textColor: UIColor?, numberOfLines: Int = 1, textAlignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
}
