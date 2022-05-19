//
//  NSMutableAttributedString+Extensions.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func append(_ value: String, font: UIFont = .systemFont(ofSize: 17), color:UIColor? = .label) {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : font,
            .foregroundColor : color as Any
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
    }
}
