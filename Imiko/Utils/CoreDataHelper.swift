//
//  CoreDataHelper.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 02.06.2022.
//

import CoreData
import UIKit

class CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func save() {
        do {
            try context.save()
        } catch {
            print("DEBUG: save() error: ", error.localizedDescription)
        }
    }
}
