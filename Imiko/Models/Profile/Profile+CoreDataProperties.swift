//
//  Profile+CoreDataProperties.swift
//  Imiko
//
//  Created by Nikita Spekhin on 02.06.2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var patronymic: String?
    @NSManaged public var phone: String?
    @NSManaged public var place: String?
    @NSManaged public var surname: String?

}

extension Profile : Identifiable {

}
