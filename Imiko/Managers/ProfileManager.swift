//
//  ProfileManagers.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation

class ProfileManager {
    
    static var data:Profile? {
        do {
            let item = try CoreDataHelper.context.fetch(Profile.fetchRequest())
            return item.first
        } catch {
            print("DEBUG: data error: ", error.localizedDescription)
            return nil
        }
    }
    
}
