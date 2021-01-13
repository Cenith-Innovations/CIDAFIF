// ********************** DafifLoaderUtilities *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** DafifLoaderUtilities *********************************


import SwiftUI
import  CoreData

public protocol DafifLoaderUtilities: BundleHelper {
    
    init()
    
    var fileNames: [String] { get set }
    
    func deleteAllFromCoreData(moc: NSManagedObjectContext)
    
    func loadAllFolderItems(moc: NSManagedObjectContext)
    
    func getData(from: String, inDir: Directory) -> [[String]]
}

