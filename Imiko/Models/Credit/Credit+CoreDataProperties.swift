//
//  Credit+CoreDataProperties.swift
//  Imiko
//
//  Created by Nikita Spekhin on 02.06.2022.
//
//

import Foundation
import CoreData


extension Credit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Credit> {
        return NSFetchRequest<Credit>(entityName: "Credit")
    }

    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var days: Int16
    @NSManaged public var approvedDate: Date?
    @NSManaged public var type: CreditHistoryType

}

extension Credit : Identifiable {

}
