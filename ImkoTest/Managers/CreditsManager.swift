//
//  CreditsManagers.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation

class CreditsManager {
    static let shared = CreditsManager()
    private let KEY = "CREDITS"
    
    func getArray() -> [CreditHistoryModel] {
        if let data = UserDefaults.standard.data(forKey: KEY) {
            let array = try! PropertyListDecoder().decode([CreditHistoryModel].self, from: data)
            return array
        }
        return []
    }
    
    func save(_ item:CreditHistoryModel) {
        var array = getArray()
        array.append(item)
        if let data = try? PropertyListEncoder().encode(array) {
            UserDefaults.standard.set(data, forKey: KEY)
        }
    }
}
