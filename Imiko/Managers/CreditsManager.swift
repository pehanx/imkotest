//
//  CreditsManagers.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation

class CreditsManager {
    
    static var data:[Credit] {
        do {
            let items = try CoreDataHelper.context.fetch(Credit.fetchRequest())
            return items
        } catch {
            print("DEBUG: data error: ", error.localizedDescription)
            return []
        }
    }
}
