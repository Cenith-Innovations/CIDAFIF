// ********************** File *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** File *********************************


import SwiftUI
import Combine
import CoreLocation
import CoreData

/// Main API struct to download and handle DAFIF. Declare DafifAPI.shared as an @EnvironmentObject in the SceneDelegate.Swift. This will instantiate a single source of truth for this class that you'll have access throughout the application.
///```
///.environmentObject(DafifAPI.shared)
///```
//public class DafifAPI: NSObject, ObservableObject, BundleHelper, CoreDataUtilities {
public class DafifAPI: NSObject, ObservableObject {
    
    public typealias AirportInfo = (airport: [Arpt]?, runways: [Rwy]?, addRunways: [AddRwy]?, trmSeg: [TrmSeg]?, trmRmk: [TrmRmk]?, trmPar: [TrmPar]?, trmClb: [TrmClb]?, trmMsa: [TrmMsa]?, trmMin: [TrmMin]?, svcRmk: [SvcRmk]?, anav: [Anav]?, acom: [Acom]?, acomRmk: [AcomRmk]?, gen: [Gen]?, fuelOil: [Fueloil]?, ils: [Ils]?, aGear: [Agear]?, arptRmk: [ArptRmk]?, papp: [Papp]?, nav: [Nav]?)
    
    
    /// This is the main squeeze! when you want to use any of the progress indicator or error indicator functionality, this is the instance that is used. Declare this as an environment object in your SceneDelegate.swift file to have access on all the child views throughout your appllication.
    @ObservedObject public static var shared = DafifAPI()
    
    var stack: CoreDataStack
    
    public required override init() {
        stack = CoreDataStack.shared
    }
    
    // MARK: - 🔅 Version Information
    @Published public var version: String?
    @Published public var productionCycle: Date?
    @Published public var effectiveDate: Date?
    @Published public var expirationDate: Date?
    @Published public var specificationEdition: Int?
    @Published public var specificationDate: Date?
    
    // MARK: - Download
    /// Progress of the download from 0.0 to 1.0. For use in a progress bar in your UI.
    @Published public var downloadProgress: CGFloat = 1
    
    /// Provides a simple way to show the user that the application had an error downloading the DAFIF. For use in the UI.
    @Published public var errorDownloading: Bool = false
    
    // MARK: - UnZip
    /// Progress of the unzipping of the DAFIF from 0.0 to 1.0. For use in a progress bar in your UI.
    @Published public var unzipProgress: CGFloat = 0
    
    /// Provides a simple way to show the user that the application had an error unzipping the DAFIF. For use in the UI.
    @Published public var errorUnzipping: Bool = false
    
    // MARK: - Load
    /// Progress of the loading the unzipped DAFIF into the CoreData model, provided from 0.0 to 1.0. For use in a progress bar in your UI.
    @Published public var processingCoreDataProgress: CGFloat = 1
    
    /// Provides a simple way to show the user that the application had an error loading the data into the CoreData model the DAFIF. For use in the UI.
    @Published public var errorprocessingCoreData: Bool = false
    
    
    // MARK: - Static functionality
    
    /// Location where we store our DAFIF.
    public static var bealeCloudStorageLocation = DafifDownloader.shared.getUrl(.dafifCloud)
    
    /// Initiates the full process of Downloading the DAFIF, unzipping and then loading it into CoreData.
    /// - Parameter from: URL Location of the stored DAFIF (from the CD)
    /// - Parameter requiredData: an array of desired data you'd like to extract and use in your application.
    /// - OPTIONS:
    ///```
    ///[AtsCDU.self, HlptCDU.self, SuppCDU.self,
    ///TrmCDU.self, AppcCDU.self, ArptCDU.self,
    ///OrtcaCDU.self, WptCDU.self, PjaCDU.self,
    ///IrCDU.self, MtrCDU.self, PappCDU.self,
    ///NavCDU.self, PrCDU.self, TzCDU.self,
    ///HoldCDU.self, SuasCDU.self, ArfCDU.self,
    ///VfrCDU.self, BdryCDU.self]
    ///```
    public static func downloadAndLoad(from: URL?, requiredData: DafifDesired) {
        DafifDownloader.shared.dataRequired = requiredData
        DafifDownloader.shared.downloadDafif(from: from)
    }
    
    /// Initiates loading already downloaded and unzipped DAFIF
    public static func loadDownloadedData(requiredData: DafifDesired) {
        CoreDataLoader.loadSomeData(data: requiredData)
    }
    
    /// This removes ALL of the data from ALL of the Enities in the DAFIF CoreData model.
    public static func deleteAllData(requiredData: DafifDesired) {
        CoreDataLoader.deleteData(data: requiredData)
    }
    
    /// Prints the count of all the Dafif CoreData Entities. Used for debugging
    public static func printCoreDataCountToConsole() {
        CoreDataLoader.printCDCounter()
    }
    
    /// Gathers all the loaded data associated with the ICAO entered. It gets the Airport Identifier associated with the ICAO entered then searches through the DAFIF for anything that has that identifier.
    /// - Parameter icao: Airfields 4 letter ICAO designator. e.g: KBAB
    /// - Returns: Optional arrays of all the data gathered.
    public static func getAllInfoFor(icao: String) -> AirportInfo? {
        let nav = Nav.getWithAirport(icao: icao)
        if let airport = Arpt.getArptWithICAO(icao: icao) {
            let id = airport.arptIdent!
            return (airport: [airport],
                    runways: Rwy.getWithAirPortId(id: id),
                    addRunways: AddRwy.getWithAirPortId(id: id),
                    trmSeg: TrmSeg.getWithAirPortId(id: id),
                    trmRmk: TrmRmk.getWithAirPortId(id: id),
                    trmPar: TrmPar.getWithAirPortId(id: id),
                    trmClb: TrmClb.getWithAirPortId(id: id),
                    trmMsa: TrmMsa.getWithAirPortId(id: id),
                    trmMin: TrmMin.getWithAirPortId(id: id),
                    svcRmk: SvcRmk.getWithAirPortId(id: id),
                    anav: Anav.getWithAirPortId(id: id),
                    acom: Acom.getWithAirPortId(id: id),
                    acomRmk: AcomRmk.getWithAirPortId(id: id),
                    gen: Gen.getWithAirPortId(id: id),
                    fuelOil: Fueloil.getWithAirPortId(id: id),
                    ils: Ils.getWithAirPortId(id: id),
                    aGear: Agear.getWithAirPortId(id: id),
                    arptRmk: ArptRmk.getWithAirPortId(id: id),
                    papp: Papp.getWithAirPortId(id: id),
                    nav: nav)
        } else {
            return nil
        }
    }
    
    
    /// A simple boolean to check if you have stuff in CoreData. I made the assumption that you'd always want the airport loaded into core data and that beale isn't going anywhere. You can use this in the Scenedelegate to check if you should download and load data.
    /// - Returns: True if you have data loaded, False if you don't
    public static func checker() -> Bool {
        guard let airport = Arpt.getArptWithICAO(icao: "KBAB") else { return false }
        if airport.arptIdent != nil { return true } else { return false }
    }
    
    /// Gathers all the loaded data associated with the ICAO entered filtered by getting rid of any airfields that don't have runways longer than the runwayLength entered. Then filters out the runways at the field if they are shorter than the runwayLength entered. It gets the Airport Identifier associated with the ICAO entered then searches through the DAFIF for anything that has that identifier.
    /// - Parameters:
    ///   - icao: Airfields 4 letter ICAO designator. e.g: KBAB
    ///   - runwayLength: Minimum runway length
    /// - Returns: Optional arrays of all the data gathered.
    public static func getAllInfoForIcaoFilteredByMinRwyLength(icao: String, runwayLength: Int16) -> AirportInfo? {
        guard let airport = Arpt.getArptWithICAO(icao: icao) else { return nil }
        let nav = Nav.getWithAirport(icao: icao)
        let id = airport.arptIdent!
        let runways = Rwy.getWithAirPortIdAndMinRunwayLength(id: id, rwyL: runwayLength)
        if runways.count > 0 {
            return (airport: [airport],
                    runways: runways,
                    addRunways: AddRwy.getWithAirPortId(id: id),
                    trmSeg: TrmSeg.getWithAirPortId(id: id),
                    trmRmk: TrmRmk.getWithAirPortId(id: id),
                    trmPar: TrmPar.getWithAirPortId(id: id),
                    trmClb: TrmClb.getWithAirPortId(id: id),
                    trmMsa: TrmMsa.getWithAirPortId(id: id),
                    trmMin: TrmMin.getWithAirPortId(id: id),
                    svcRmk: SvcRmk.getWithAirPortId(id: id),
                    anav: Anav.getWithAirPortId(id: id),
                    acom: Acom.getWithAirPortId(id: id),
                    acomRmk: AcomRmk.getWithAirPortId(id: id),
                    gen: Gen.getWithAirPortId(id: id),
                    fuelOil: Fueloil.getWithAirPortId(id: id),
                    ils: Ils.getWithAirPortId(id: id),
                    aGear: Agear.getWithAirPortId(id: id),
                    arptRmk: ArptRmk.getWithAirPortId(id: id),
                    papp: Papp.getWithAirPortId(id: id),
                    nav: nav)
        } else { return nil }
    }
    
    /// Gets all the airfileds in CoreData and returns them in a sorted array from the nearest to the farthest away.
    /// - Parameter from: Location where you want to find the closest airfields.
    /// - Returns: Sorted array of airfields based on distance.
    public static func getClosestAirports(from: CLLocation) -> [Arpt]? {
        guard let airports = Arpt.getAllAirports() else { return nil }
        let mappedList = airports.sorted { (arpt1, arpt2) -> Bool in
            let airportLoc1 = CLLocation(latitude: arpt1.wgsDlat, longitude: arpt1.wgsDlong )
            let airportDis1 = from.distance(from: airportLoc1)
            let airportLoc2 = CLLocation(latitude: arpt2.wgsDlat, longitude: arpt2.wgsDlong )
            let airportDis2 = from.distance(from: airportLoc2)
            return airportDis1 < airportDis2
        }
        return mappedList
    }
    
    
    /// Gathers all the information linked to an airfield by its arptId string. Not all airfields have an associated ICAO but the do have an a
    /// - Parameter id: DAFIF airport id
    /// - Returns: Optional arrays of all the data gathered.
    public static func getAllInfofor(airportId id: String) -> AirportInfo? {
        guard let airport = Arpt.getArptWithId(id: id) else { return nil }
        var nav: [Nav]?
        if let icao = airport.icao {
            nav = Nav.getWithAirport(icao: icao)
        }
        return (airport: [airport],
                runways: Rwy.getWithAirPortId(id: id),
                addRunways: AddRwy.getWithAirPortId(id: id),
                trmSeg: TrmSeg.getWithAirPortId(id: id),
                trmRmk: TrmRmk.getWithAirPortId(id: id),
                trmPar: TrmPar.getWithAirPortId(id: id),
                trmClb: TrmClb.getWithAirPortId(id: id),
                trmMsa: TrmMsa.getWithAirPortId(id: id),
                trmMin: TrmMin.getWithAirPortId(id: id),
                svcRmk: SvcRmk.getWithAirPortId(id: id),
                anav: Anav.getWithAirPortId(id: id),
                acom: Acom.getWithAirPortId(id: id),
                acomRmk: AcomRmk.getWithAirPortId(id: id),
                gen: Gen.getWithAirPortId(id: id),
                fuelOil: Fueloil.getWithAirPortId(id: id),
                ils: Ils.getWithAirPortId(id: id),
                aGear: Agear.getWithAirPortId(id: id),
                arptRmk: ArptRmk.getWithAirPortId(id: id),
                papp: Papp.getWithAirPortId(id: id),
                nav: nav)
    }
    
    
    static public func getAllRunwaysGreaterThanOrEqualTo(_ length: Int16) -> [Rwy] {
        var result: [Rwy] = []
        let fetchRequest = NSFetchRequest<Rwy>(entityName: "Rwy")
        do {
            result = try moc.fetch(fetchRequest).filter({ $0.length >= length })
        } catch {
            print("************************************")
            print("No RUNWAYS???? \(error)")
            print("************************************")
        }
        return result
    }
    
    
    /// Gets the closest 200 airfields filtered by minrunway length
    /// - Parameters:
    ///   - from: Users location (or wherever you feel like putting here)
    ///   - minRwyLength: Just like the variable name says
    /// - Returns: All the airfield data in coredata for all the airfields
    public static func getClosestAirportsFilteredByMinRwyLength(from: CLLocation, minRwyLength: Int16) -> [Arpt] {
        var returnList: [Arpt] = []
        guard let airports = Arpt.getAllAirports() else { return [] }
        let reducedList = airports.filter({ $0.icao?.count == 4})
        let runwayIdents = getAllRunwaysGreaterThanOrEqualTo(minRwyLength).map({ $0.arptIdent })
        let mappedList = reducedList.sorted { (arpt1, arpt2) -> Bool in
            let airportLoc1 = CLLocation(latitude: arpt1.wgsDlat, longitude: arpt1.wgsDlong)
            let airportDis1 = from.distance(from: airportLoc1)
            let airportLoc2 = CLLocation(latitude: arpt2.wgsDlat, longitude: arpt2.wgsDlong)
            let airportDis2 = from.distance(from: airportLoc2)
            return airportDis1 < airportDis2
        }
        for i in 0...200 {
            if mappedList.count > 0 {
                if runwayIdents.contains(mappedList[i].arptIdent) {
                    returnList.append(mappedList[i])
                }
            } else {
                print("************************************")
                print(mappedList.count)
                print("************************************")
            }
            
        }
        return returnList
    }
    
    
}

