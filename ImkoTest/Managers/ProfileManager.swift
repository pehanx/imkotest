//
//  ProfileManagers.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation

class ProfileManager {
    static let shared = ProfileManager()
    private let KEY = "PROFILE"
    
    var getModel:ProfileModel? {
        if let data = UserDefaults.standard.object(forKey: KEY) as? Data {
            if let profileItem = try? JSONDecoder().decode(ProfileModel.self, from: data) {
                return profileItem
            }
        }
        return nil
    }
    
    func save(_ item:ProfileModel) {
        if let encoded = try? JSONEncoder().encode(item) {
            UserDefaults.standard.set(encoded, forKey: KEY)
        }
    }
}
