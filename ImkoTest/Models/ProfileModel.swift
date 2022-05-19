//
//  ProfileModel.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation

struct ProfileModel:Codable {
    var name:String?
    var surname:String?
    var patronymic:String?
    var place:String?
    var phone:String?
    var email:String?
    
    var fullName:String {
        var fullName = [String]()
        if let name = name {
            fullName.append(name)
        }
        if let surname = surname {
            fullName.append(surname)
        }
        if let patronymic = patronymic {
            fullName.append(patronymic)
        }
        return fullName.joined(separator: " ")
    }
}
