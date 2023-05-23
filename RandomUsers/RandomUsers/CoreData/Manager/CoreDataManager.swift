//
//  CoreDataManager.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

import Foundation
import CoreData

class CoreDataManager {
    private var storeType: String!

    static let shared = CoreDataManager()
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RandomUsers")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    private func loadPersistentStore(completion: @escaping () -> Void) {
        //handle data migration here
        persistentContainer.loadPersistentStores { description, error in
            print(description)
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
            completion()
        }
    }
    func entityHaveDataInDB(_ entityName: String) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try  mainContext.fetch(request)
            if result.count > 0 {
                return true
            }
            return false
        } catch {
            return false
        }
    }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Failed to save context: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

