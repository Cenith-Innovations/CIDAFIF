// ********************** CoreDataUtilities *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** CoreDataUtilities *********************************

import SwiftUI
import CoreData

public protocol CoreDataUtilities: BundleHelper {}

public extension CoreDataUtilities {
    
    // MARK: - Generic Functions
    @discardableResult
    func get<T: NSManagedObject>(entityType: T.Type) -> [T] {
        guard let named = T.description().components(separatedBy: ".").last else { return [] }
        var result: [T] = []
//        let moc = CoreDataStack.shared.moc
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
    
    func delete<T: NSManagedObject>(entityType: T.Type) {
        let named = T.description().components(separatedBy: ".").last ?? ""
//        let moc = CoreDataStack.shared.moc
        let batchDelete = NSBatchDeleteRequest(fetchRequest: T.fetchRequest())
        do {
            try moc.execute(batchDelete)
            try moc.save()
            print("All \(named) were succesfully deleted from CoreData")
        } catch {
            print("Nope")
            
            
        }}
    
    
       
}
