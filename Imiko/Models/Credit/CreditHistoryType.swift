//
//  CreditHistoryType.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation
import UIKit

@objc public enum CreditHistoryType:Int16 {
    /// Не одобрено
    case notApproved = 0
    /// Рассмотрено
    case considered = 1
    /// Одобрено
    case approved = 2
    
    var title:String {
        switch self {
        case .notApproved: return "No aprobado"
        case .considered: return "Considerado"
        case .approved: return "Aprobado"
        }
    }
    
    var color:UIColor? {
        switch self {
        case .notApproved: return R.color.red()
        case .considered: return R.color.orange()
        case .approved: return R.color.green()
        }
    }
}
