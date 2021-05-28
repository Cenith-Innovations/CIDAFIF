// ********************** CoreDataStack *********************************
// * Copyright © Cenith Innovations - All Rights Reserved
// * Created on 11/10/20, for DAFIF_CoreData
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** CoreDataStack *********************************


import CoreData

@available(tvOS 13.0, *)
open class PersistentContainer: NSPersistentContainer {}
public let pc = CoreDataStack.shared.pc
public let moc = CoreDataStack.shared.moc

@available(tvOS 13.0, *)
public class CoreDataStack {
    
    public static var shared = CoreDataStack()
    
    public var pc: PersistentContainer = {
        let modelURL = Bundle.module.url(forResource: "CIDAFIF", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        let container = PersistentContainer(name: "CIDAFIF", managedObjectModel: model!)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }})
        return container
    }()
    
    public var moc: NSManagedObjectContext { pc.viewContext }
    
}





