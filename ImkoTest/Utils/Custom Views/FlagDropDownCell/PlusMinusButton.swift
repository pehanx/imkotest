//
//  PlusMinusButton.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

class PlusMinusButton:UIButton {
    
    private var tapped:(() -> ())?
    enum PlusMinus {
        case plus, minus
        var image:UIImage? {
            switch self {
            case .plus: return R.image.plus()?.withRenderingMode(.alwaysOriginal)
            case .minus: return R.image.minus()?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    convenience init(type: PlusMinus, tapped: @escaping () -> ()) {
        self.init(type: .system)
        self.tapped = tapped
        setImage(type.image, for: .normal)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        backgroundColor = R.color.lightGray()
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        widthAnchor.constraint(equalToConstant: 48).isActive = true
        layer.cornerRadius = 24
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap(){
        tapped?()
    }
    
}
