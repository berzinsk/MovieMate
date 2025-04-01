//
//  CoreDataStack.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var viewContext: NSManagedObjectContext { get }
    func saveContext()
}

class CoreDataStack: CoreDataStackProtocol {
    let persistentContainer: NSPersistentContainer

    init(name: String = "MovieMate") {
        persistentContainer = NSPersistentContainer(name: name)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
