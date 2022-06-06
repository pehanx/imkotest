//
//  LoanDaysType.swift
//  Imiko
//
//  Created by Nikita Spekhin on 03.06.2022.
//

import Foundation

enum LoanDaysStep:Int {
    /// 91 день
    case first = 0
    /// 120 дней
    case second
    /// 180 дней
    case third
    
    var days:Int {
        switch self {
        case .first: return 91
        case .second: return 120
        case .third: return 180
        }
    }
}
