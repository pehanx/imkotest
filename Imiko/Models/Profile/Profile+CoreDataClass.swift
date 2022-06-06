//
//  Profile+CoreDataClass.swift
//  Imiko
//
//  Created by Nikita Spekhin on 02.06.2022.
//
//

import Foundation
import CoreData

@objc(Profile)
public class Profile: NSManagedObject {
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
