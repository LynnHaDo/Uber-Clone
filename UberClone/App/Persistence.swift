//
//  Persistence.swift
//  UberClone
//
//  Created by Do Linh on 1/16/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let sample1 = RideType(context: viewContext)
        sample1.id = 1
        sample1.name = "UberX"
        sample1.baseFare = 5
        sample1.ratePerMile = 1.5
        
        let sample2 = RideType(context: viewContext)
        sample2.id = 2
        sample2.name = "UberBlack"
        sample2.baseFare = 20
        sample2.ratePerMile = 2.0
        
        let sample3 = RideType(context: viewContext)
        sample3.id = 3
        sample3.name = "UberXL"
        sample3.baseFare = 10
        sample3.ratePerMile = 1.75
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "UberCloneModels")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
