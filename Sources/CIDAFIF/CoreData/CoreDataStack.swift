// ********************** CoreDataStack *********************************
// * Copyright © Cenith Innovations - All Rights Reserved
// * Created on 11/10/20, for DAFIF_CoreData
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** CoreDataStack *********************************


import CoreData

open class PersistentContainer: NSPersistentContainer {}
public let pc = CoreDataStack.shared.pc
public let moc = CoreDataStack.shared.moc


public class CoreDataStack {
    
    public static var shared = CoreDataStack()
    
    public var pc: PersistentContainer = {
        let modelURL = Bundle.module.url(forResource: "DAFIF_CoreData", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        
        let container = PersistentContainer(name: "DAFIF_CoreData", managedObjectModel: model!)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("************* LOAD PERSISTANT STORES 1 ******************")
            print("************************************************************************")
            
            if let error = error as NSError? {
                print("************* LOAD PERSISTANT STORES 2 ******************")
                print("************************************************************************")
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public var moc: NSManagedObjectContext { pc.viewContext }
    
    public func saveContext() {
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }}}
    
    // MARK: - Generic Functions
    public func get<T: NSManagedObject>(entityType: T, named: String) -> [T] {
        var result: [T] = []
        let fr = NSFetchRequest<T>(entityName: named)
        do {
            result = try moc.fetch(fr)
        } catch {
            print(error)
        }
        print("************** \(named) **********************")
        print(result.count)
        print("**********************************************")
        return result
    }
    
    public func deleteAll<T: NSManagedObject>(entityType: T, named: String) {
        let batchDelete = NSBatchDeleteRequest(fetchRequest: T.fetchRequest())
        do {
            try moc.execute(batchDelete)
            try moc.save()
            print("All \(named) were succesfully deleted from CoreData")
        } catch {
            print("Nope")
        }}
    
}





