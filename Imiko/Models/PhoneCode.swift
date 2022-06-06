//
//  PhoneCode.swift
//  Imiko
//
//  Created by Nikita Spekhin on 02.06.2022.
//

import Foundation

enum PhoneCode:String, CaseIterable {
    case mexico
    case usa
    
    var code:String {
        switch self {
        case .mexico: return "+52"
        case .usa: return "+1"
        }
    }
}
