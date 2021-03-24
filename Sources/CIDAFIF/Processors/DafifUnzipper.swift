// ********************** DafifUnzipper *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** DafifUnzipper *********************************


import SwiftUI
import Zip
import Combine

@available(tvOS 13.0, *)
public class DafifUnzipper: ObservableObject, BundleHelper, CoreDataUtilities {
    
    public static var shared = DafifUnzipper()
    
    public func progressUnzip(_ perc: Double) {
        DafifAPI.shared.unzipProgress = CGFloat(perc)
    }
    
    public func unZipDafif(data: DafifDesired) {
        DafifAPI.shared.unzipProgress = 0.0
        DafifAPI.shared.errorUnzipping = false
        do {
            // MARK: 👉 DAFIF All Data
            #if os(tvOS)
            let dafifDatafilePath = Bundle.module.url(forResource: "DAFIF8", withExtension: "zip")
            try Zip.unzipFile(dafifDatafilePath!, destination: getUrl(.dafifCoreDataMain), overwrite: true, password: nil, progress: progressUnzip(_:), fileOutputHandler: nil)
            #else
            let dafifDatafilePath = getUrl(.dafifZipped)
            try Zip.unzipFile(dafifDatafilePath, destination: getUrl(.dafifCoreDataMain), overwrite: true, password: nil, progress: progressUnzip(_:), fileOutputHandler: nil)
            #endif
            
            // MARK: 👉 DAFIF Version Information
            let dafifVersionfilePath = getUrl(.dafifVersionZipped)
            try Zip.unzipFile(dafifVersionfilePath, destination: getUrl(.dafifCoreDataMain), overwrite: true, password: nil)
            let versionFileStr = self.getFileContents(getUrl(.dafifCoreDataMain).appendingPathComponent("VERSION"))
            let versionInfo = self.getVersionInfo(versionFileStr)
            DafifAPI.shared.effectiveDate = versionInfo.effectiveDate
            DafifAPI.shared.expirationDate = versionInfo.expirationDate
        } catch {
            DafifAPI.shared.errorUnzipping = true
            print(error)
        }

        do {
            DafifAPI.shared.unzipProgress = 0
            let filePath = getUrl(.dafif_T_Zipped)
            try Zip.unzipFile(filePath, destination: getUrl(.dafifCoreDataMain), overwrite: true, password: nil, progress: progressUnzip(_:), fileOutputHandler: nil)
        } catch {
            DafifAPI.shared.errorUnzipping = true
            print(error)
        }
        
        //Cleaning Up
        deleteAllFilesExcept("DAFIFT")
        CoreDataLoader.shared.loadSomeData(data: data)
    }
    

}



