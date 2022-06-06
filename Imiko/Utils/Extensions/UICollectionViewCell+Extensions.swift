//
//  UICollectionViewCell+Extensions.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 01.06.2022.
//

import UIKit

extension UICollectionViewCell {
    func isHighlighted() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            if self.isHighlighted {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.alpha = 0.8
            } else {
                self.transform = .identity
                self.alpha = 1
            }
        })
    }
}
