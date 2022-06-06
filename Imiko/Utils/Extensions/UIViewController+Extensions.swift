//
//  UIViewController+Extensions.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 01.06.2022.
//

import UIKit

enum DummyCollectionCell {
    case cell(UICollectionViewCell)
    case cellHeader(UICollectionReusableView)
}

extension UIViewController {
    
    func size(dummyCell:DummyCollectionCell, width:CGFloat) -> CGSize{
        let estimatedSize:CGSize
        switch dummyCell {
        case .cell(let cell):
            cell.layoutIfNeeded()
            estimatedSize = cell.systemLayoutSizeFitting(.init(width: width, height: 1000))
        case .cellHeader(let header):
            header.layoutIfNeeded()
            estimatedSize = header.systemLayoutSizeFitting(.init(width: width, height: 1000))
        }
        
        let height = estimatedSize.height
        return .init(width: width, height: height)
    }
    
    func sizeHorizontal(cell: UICollectionViewCell, height:CGFloat) -> CGSize {
        cell.layoutIfNeeded()
        let estimatedSize = cell.systemLayoutSizeFitting(.init(width: 1000, height: height))
        let width = estimatedSize.width
        return .init(width: width, height: height)
    }
    
    var safeAreaInsetsBottom:CGFloat {
        return UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController?.view.safeAreaInsets.bottom ?? 0.0
    }
    
}
