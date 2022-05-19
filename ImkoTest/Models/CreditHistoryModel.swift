//
//  CreditHistoryModel.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation
import UIKit

struct CreditHistoryModel:Codable {
    let price:Int
    let days:Int
    let approvedDate:Date
    let type:CreditHistoryType
    
    init(price:Int, days:Int, approvedDate:Date = Date(), type:CreditHistoryType) {
        self.price = price
        self.days = days
        self.approvedDate = approvedDate
        self.type = type
    }
}

enum CreditHistoryType:Codable {
    case paid, unpaid
    var title:String {
        switch self {
        case .paid: return "Pagado"
        case .unpaid: return "No pagado"
        }
    }
    
    var color:UIColor? {
        switch self {
        case .paid: return R.color.green()
        case .unpaid: return R.color.red()
        }
    }
}
