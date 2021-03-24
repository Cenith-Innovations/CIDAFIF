// ********************** BundleHelper *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** BundleHelper *********************************


import Foundation


public protocol BundleHelper {}

extension BundleHelper {
    // MARK: - Debugging and TroubleShooting
    public func printContentsOf(_ dir: Directory) {
        do {
            print(try FileManager.default.contentsOfDirectory(at: getUrl(dir), includingPropertiesForKeys: nil, options: []))
        } catch { print(error) }}
    
    public func printEverything() {
        for i in Directory.allCases {
            printContentsOf(i)
        }}
    
    //MARK: - File Handling
    public func getData(from: String, inDir: Directory) -> [[String]] {
        var contents: String = ""
        var result: [[String]] = []
        do {
            contents = try String(contentsOf: getUrl(inDir).appendingPathComponent(from))
        } catch {
            do {
                contents = try String(contentsOf: getUrl(inDir).appendingPathComponent(from), encoding: .iso2022JP)
            } catch {
                print("*************::NGA WINS! YOU LOSE!!!")
            }
            print("DAMMIT NGA! GET YOUR SHIT TOGETHER!!!")
        }
        let records = contents.components(separatedBy: "\n")
        for i in 0..<records.count {
            if i >= 1 {
                let properties = records[i].components(separatedBy: "\t")
                result.append(properties)
            }}
        return result
    }
    
    public func deleteAllFilesExcept(_ name: String) {
        do {
            let listOfFiles = try FileManager.default.contentsOfDirectory(at: getUrl(.dafifCoreDataMain), includingPropertiesForKeys: nil, options: [])
            for url in listOfFiles {
                if url.lastPathComponent != name {
                    try FileManager.default.removeItem(at: url)
                }}} catch { print(error) }}
    
    public func deleteAllFiles(in url: URL) {
        do {
            let listOfFiles = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for url in listOfFiles {
                try FileManager.default.removeItem(at: url)
            }} catch { print(error) }}
    
    public func getFileContents(_ filename: URL) -> String {
        var result = ""
        do {
            let fileUrl: URL = filename
            let data = try Data(contentsOf: fileUrl)
            result = String(decoding: data, as: UTF8.self)
        } catch {
            print(error)
        }
        return result
    }
    
    public func getUrls(of: URL) -> [URL] {
        var result: [URL] = []
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: of, includingPropertiesForKeys: nil, options: [])
            for folderPath in contents {
                let fileName = folderPath.lastPathComponent
                if fileName.first != "." {
                    result.append(folderPath)
                }}} catch { print(error) }
        return result
    }
    
    // MARK: - 🔅 DAFIF Version Date
    // TODO:⚠️ Get the VERSION file and send it through this
    public typealias DafifDates = (version: String, productionCycle: Date?,  effectiveDate: Date?, expirationDate: Date?, specificationEdition: Int?, specificationDate: Date?)
    /**
     ```
     typealias DafifDates = (version: String, productionCycle: Date?,  effectiveDate: Date?, expirationDate: Date?, specificationEdition: Int?, specificationDate: Date?)
     
     ```
     Returns version information of the DAFIF
     - Parameter versionFileStr: VERSION File after its been unZipped and turned into a string
     - Returns: DafifDates
     */
    public func getVersionInfo(_ versionFileStr: String) ->  DafifDates {
        var version = ""
        var productionCycle: Date?
        var effectiveDate: Date?
        var expirationDate: Date?
        var specificationEdition: Int?
        var specificationDate: Date?
        
        let lines = versionFileStr.components(separatedBy: "\n")
        if !lines.isEmpty {
            version = lines[0].removeAllCharOf("\r")
            productionCycle = lines[0].subString(from: 0, to: 3).getDateFrom(ofType: .dafifCycle)
            effectiveDate = lines[0].subString(from: 4, to: 11).getDateFrom(ofType: .dafifCurrency)
            expirationDate = lines[0].subString(from: 12, to: 19).getDateFrom(ofType: .dafifCurrency)
            specificationEdition = Int(lines[0].subString(from: 20, to: 21))
            specificationDate = lines[0].subString(from: 22, to: 27).getDateFrom(ofType: .dafifSpecification)
        }
        
        return (version: version, productionCycle: productionCycle,  effectiveDate: effectiveDate, expirationDate: expirationDate, specificationEdition: specificationEdition, specificationDate: specificationDate)
    }
    
    public var listOfDafiftFolders: [String] {
        ["HOLD", "ATS", "PR", "NAV", "SUPP", "BDRY", "WPT", "PAPP", "SUPPH", "TRM", "TZ", "TRMH", "ARPT", "MTR", "ARF", "ORTCA", "HLPT", "APPC", "SUAS", "PJA", "IR", "VFR"]
    }
    
    public func getUrl(_ forLoc: Directory) -> URL {
        let fm = FileManager.default
        #if os(tvOS)
        let documents = fm.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        #else
        let documents = fm.urls(for:.documentDirectory, in: .userDomainMask)[0]
        #endif
        let dafifCoreDataMainFolder = documents.appendingPathComponent("DafifCoreDataMain")
        switch forLoc {
        case .dafifCloud: return URL(string: "https://9ogv-filestorage.s3-us-west-2.amazonaws.com/DAFIF/DAFIF8.zip") ?? dafifCoreDataMainFolder
        case .dafifCoreDataMain: return dafifCoreDataMainFolder
        case .dafifVersionZipped: return dafifCoreDataMainFolder.appendingPathComponent("VERSION.zip")
        case .dafifVersionUnZipped: return dafifCoreDataMainFolder.appendingPathComponent("Version")
        case .dafifZipped: return dafifCoreDataMainFolder.appendingPathComponent("DAFIF8.zip")
        case .dafif_T_Zipped: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT.zip")
        case .documents: return documents
        case .dafifT: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT")
        case .arpt: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/ARPT")
        case .nav: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/NAV")
        case .ats: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/ATS")
        case .pr: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/PR")
        case .supp: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/SUPP")
        case .bdry: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/BDRY")
        case .wpt: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/WPT")
        case .papp: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/PAPP")
        case .supph: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/SUPPH")
        case .trm: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/TRM")
        case .tz: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/TZ")
        case .trmh: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/TRMH")
        case .mtr: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/MTR")
        case .arf: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/ARF")
        case .ortca: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/ORTCA")
        case .hlpt: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/HLPT")
        case .appc: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/APPC")
        case .suas: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/SUAS")
        case .pja: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/PJA")
        case .ir: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/IS")
        case .vfr: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/VFR")
        case .hold: return dafifCoreDataMainFolder.appendingPathComponent("DAFIFT/HOLD")
        }}
}
