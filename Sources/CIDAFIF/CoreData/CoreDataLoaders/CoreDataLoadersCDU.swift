// ********************** File *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** File *********************************


import CoreData
import SwiftUI


public class AtsCDU: DafifLoaderUtilities, CoreDataUtilities {
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["ATS_RMK.TXT", "ATS_CTRY.TXT", "ATS.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: AtsRmk.self)
            case 1:
                delete(entityType: AtsCtry.self)
            case 2:
                delete(entityType: Ats.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .ats)
            switch i {
            case 0:
                func breakUp(lineItem: [[String]]) {
                    for property in lineItem {
                        if property.count >= 8 {
                            let entity = AtsRmk(context: moc)
                            entity.atsIdent = property[0]
                            entity.seqNbr = property[1].toInt16
                            entity.direction = property[2]
                            entity.type = property[3]
                            entity.icao = property[4]
                            entity.rmkSeq = property[5].toInt16
                            entity.remark = property[6]
                            entity.cycleDate = property[7]
                        }}
                    moc.performAndWait {
                        do {
                            try moc.save()
                            
                        } catch {
                            print(error)
                        }}}
                
                let smaller = lineItem.chunked(into: lineItem.count/10)
                for each in smaller {
                    breakUp(lineItem: each)
                }
                print("\(fileNames[i]) DONE")
            case 1:
                func breakUp(lineItem: [[String]]) {
                    for property in lineItem {
                        if property.count >= 8 {
                            let entity = AtsCtry(context: moc)
                            entity.atsIdent = property[0]
                            entity.seqNbr = property[1].toInt16
                            entity.direction = property[2]
                            entity.type = property[3]
                            entity.icao = property[4]
                            entity.ctry = property[5]
                            entity.stateProv = property[6]
                            entity.cycleDate = property[7]
                        }}
                    moc.performAndWait {
                        do {
                            try moc.save()
                            
                        } catch {
                            print(error)
                        }}}
                
                let smaller = lineItem.chunked(into: lineItem.count/10)
                for each in smaller {
                    breakUp(lineItem: each)
                }
                print("\(fileNames[i]) DONE")
            case 2:
                func breakUp(lineItem: [[String]]) {
                    for property in lineItem {
                        if property.count >= 46 {
                            let entity = Ats(context: moc)
                            entity.atsIdent = property[0]
                            entity.seqNbr = property[1].toInt16
                            entity.direction = property[2]
                            entity.type = property[3]
                            entity.icao = property[4]
                            entity.bidirect = property[5]
                            entity.freqClass = property[6]
                            entity.level = property[7]
                            entity.status = property[8]
                            entity.wpt1Icao = property[9]
                            entity.wpt1NavType = property[10]
                            entity.wpt1Ident = property[11]
                            entity.wpt1Ctry = property[12]
                            entity.wpt1Desc1 = property[13]
                            entity.wpt1Desc2 = property[14]
                            entity.wpt1Desc3 = property[15]
                            entity.wpt1Desc4 = property[16]
                            entity.wpt1WgsLat = property[17]
                            entity.wpt1WgsDlat = property[18].toDouble
                            entity.wpt1WgsLong = property[19]
                            entity.wpt1WgsDlong = property[20].toDouble
                            entity.wpt2Icao = property[21]
                            entity.wpt2NavType = property[22].toInt16
                            entity.wpt2Ident = property[23]
                            entity.wpt2Ctry = property[24]
                            entity.wpt2Desc1 = property[25]
                            entity.wpt2Desc2 = property[26]
                            entity.wpt2Desc3 = property[27]
                            entity.wpt2Desc4 = property[28]
                            entity.wpt2WgsLat = property[29]
                            entity.wpt2WgsDlat = property[30].toDouble
                            entity.wpt2WgsLong = property[31]
                            entity.wpt2WgsDlong = property[32].toDouble
                            entity.outbdCrs = property[33].toDouble
                            entity.distance = property[34].toDouble
                            entity.inbdCrs = property[35].toDouble
                            entity.minAlt = property[36]
                            entity.upperLimit = property[37]
                            entity.lowerLimit = property[38]
                            entity.maa = property[39]
                            entity.cruiseLevel = property[40]
                            entity.rnp = property[41]
                            entity.cycleDate = property[42].toInt16
                            entity.rvsm = property[43]
                            entity.fixTurn1 = property[44]
                            entity.fixTurn2 = property[45]
                        }}
                    moc.performAndWait {
                        do {
                            try moc.save()
                            
                        } catch {
                            print(error)
                        }}}
                
                let smaller = lineItem.chunked(into: lineItem.count/10)
                for each in smaller {
                    breakUp(lineItem: each)
                }
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class HlptCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["PAD.TXT", "HNAV.TXT", "HLPT_RMK.TXT", "HLPT.TXT", "HCOM.TXT", "Hcom_RMK.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Pad.self)
            case 1:
                delete(entityType: Hnav.self)
            case 2:
                delete(entityType: HlptRmk.self)
            case 3:
                delete(entityType: Hlpt.self)
            case 4:
                delete(entityType: Hcom.self)
            case 5:
                delete(entityType: HcomRmk.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .hlpt)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 40 {
                        let entity = Pad(context: moc)
                        entity.heliIdent = property[0]
                        entity.seqNbr = property[1].toInt16
                        entity.length = property[2].toInt16
                        entity.width = property[3].toInt16
                        entity.surface = property[4]
                        entity.acType = property[5]
                        entity.wgsLat = property[6]
                        entity.wgsDlat = property[7].toDouble
                        entity.wgsLong = property[8]
                        entity.wgsDlong = property[9].toDouble
                        entity.lgtSys1 = property[10]
                        entity.lgtSys2 = property[11]
                        entity.lgtSys3 = property[12]
                        entity.highIdent = property[13]
                        entity.highHdg = property[14]
                        entity.heWgsLat = property[15]
                        entity.heWgsDlat = property[16]
                        entity.heWgsLong = property[17]
                        entity.heWgsDlong = property[18]
                        entity.heElev = property[19]
                        entity.heSlope = property[20]
                        entity.hlgtSys1 = property[21]
                        entity.hlgtSys2 = property[22]
                        entity.hlgtSys3 = property[23]
                        entity.lowIdent = property[24]
                        entity.lowHdg = property[25]
                        entity.leWgsLat = property[26]
                        entity.leWgsDlat = property[27]
                        entity.leWgsLong = property[28]
                        entity.leWgsDlong = property[29]
                        entity.leElev = property[30]
                        entity.leSlope = property[31]
                        entity.llgtSys1 = property[32]
                        entity.llgtSys2 = property[33]
                        entity.llgtSys3 = property[34]
                        entity.highTrue = property[35]
                        entity.lowTrue = property[36]
                        entity.cldRwy = property[37]
                        entity.padId = property[38].toInt16
                        entity.cycleDate = property[39]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 10 {
                        let entity = Hnav(context: moc)
                        entity.heliIdent = property[0]
                        entity.navIdent = property[1]
                        entity.navType = property[2].toInt16
                        entity.navCtry = property[3]
                        entity.navKeyCd = property[4].toInt16
                        entity.name = property[5]
                        entity.atFld = property[6]
                        entity.bearing = property[7]
                        entity.distance = property[8]
                        entity.cycleDate = property[9]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 4 {
                        let entity = HlptRmk(context: moc)
                        entity.heliIdent = property[0]
                        entity.rmkSeq = property[1]
                        entity.remark = property[2]
                        entity.cycleDate = property[3]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 3:
                for property in lineItem {
                    if property.count >= 19 {
                        let entity = Hlpt(context: moc)
                        entity.heliIdent = property[0]
                        entity.name = property[1]
                        entity.stateProv = property[2]
                        entity.icao = property[3]
                        entity.faaHostId = property[4]
                        entity.locHdatum = property[5]
                        entity.wgsDatum = property[6]
                        entity.wgsLat = property[7]
                        entity.wgsDlat = property[8].toDouble
                        entity.wgsLong = property[9]
                        entity.wgsDlong = property[10].toDouble
                        entity.elev = property[11].toInt16
                        entity.type = property[12]
                        entity.magVar = property[13]
                        entity.wac = property[14].toInt16
                        entity.beacon = property[15]
                        entity.cycleDate = property[16].toInt16
                        entity.terrain = property[17]
                        entity.hydro = property[18]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 4:
                for property in lineItem {
                    if property.count >= 24 {
                        let entity = Hcom(context: moc)
                        entity.heliIdent = property[0]
                        entity.commType = property[1]
                        entity.commName = property[2]
                        entity.sym = property[3]
                        entity.freq1 = property[4]
                        entity.freq2 = property[5]
                        entity.freq3 = property[6]
                        entity.freq4 = property[7]
                        entity.freq5 = property[8]
                        entity.sec = property[9]
                        entity.sOprH = property[10]
                        entity.cycleDate = property[11].toInt16
                        entity.multi = property[12].toInt16
                        entity.freqMulti = property[13].toInt16
                        entity.comFreq1 = property[14].toInt16
                        entity.freqUnit1 = property[15]
                        entity.comFreq2 = property[16]
                        entity.freqUnit2 = property[17]
                        entity.comFreq3 = property[18]
                        entity.freqUnit3 = property[19]
                        entity.comFreq4 = property[20]
                        entity.freqUnit4 = property[21]
                        entity.comFreq5 = property[22]
                        entity.freqUnit5 = property[23]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 5:
                for property in lineItem {
                    if property.count >= 7 {
                        let entity = HcomRmk(context: moc)
                        entity.heliIdent = property[0]
                        entity.commType = property[1]
                        entity.rmkSeq = property[2].toInt16
                        entity.remark = property[3]
                        entity.cycleDate = property[4].toInt16
                        entity.multi = property[5].toInt16
                        entity.freqMulti = property[6]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
        do {
            try moc.save()
        } catch {
            print(error)
        }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class SuppCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["FUELOIL.TXT", "SVC_RMK.TXT", "ADD_RWY.TXT", "GEN.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Fueloil.self)
            case 1:
                delete(entityType: SvcRmk.self)
            case 2:
                delete(entityType: AddRwy.self)
            case 3:
                delete(entityType: Gen.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .supp)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 7 {
                        let entity = Fueloil(context: moc)
                        entity.arptIdent = property[0]
                        entity.icao = property[1]
                        entity.fuel = property[2]
                        entity.oil = property[3]
                        entity.jasu = property[4]
                        entity.supFluids = property[5]
                        entity.cycleDate = property[6]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 6 {
                        let entity = SvcRmk(context: moc)
                        entity.arptIdent = property[0]
                        entity.type = property[1]
                        entity.rmkSeq = property[2].toInt16
                        entity.icao = property[3]
                        entity.remarks = property[4]
                        entity.cycleDate = property[5]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 25 {
                        let entity = AddRwy(context: moc)
                        entity.arptIdent = property[0]
                        entity.highIdent = property[1].toInt16
                        entity.loIdent = property[2].toInt16
                        entity.icao = property[3]
                        entity.heDtLat = property[4]
                        entity.heDtDlat = property[5].toDouble
                        entity.heDtLong = property[6]
                        entity.heDtDlong = property[7].toDouble
                        entity.heOverrunDis = property[8].toInt16
                        entity.heSurface = property[9]
                        entity.heOverrunLat = property[10]
                        entity.heOverrunDlat = property[11].toDouble
                        entity.heOverrunLong = property[12]
                        entity.heOverrunDlong = property[13].toDouble
                        entity.loDtLat = property[14]
                        entity.loDtDlat = property[15].toDouble
                        entity.loDtLong = property[16]
                        entity.loDtDlong = property[17].toDouble
                        entity.loOverrunDis = property[18].toInt16
                        entity.loSurface = property[19]
                        entity.loOverrunLat = property[20]
                        entity.loOverrunDlat = property[21].toDouble
                        entity.loOverrunLong = property[22]
                        entity.loOverrunDlong = property[23].toDouble
                        entity.cycleDate = property[24]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 3:
                for property in lineItem {
                    if property.count >= 13 {
                        let entity = Gen(context: moc)
                        entity.arptIdent = property[0]
                        entity.icao = property[1]
                        entity.altName = property[2]
                        entity.cityCrossRef = property[3]
                        entity.islGroup = property[4]
                        entity.notam = property[5]
                        entity.oprHrs = property[6]
                        entity.clearStatus = property[7]
                        entity.utmGrid = property[8]
                        entity.time = property[9]
                        entity.daylightSave = property[10]
                        entity.flipPub = property[11]
                        entity.cycleDate = property[12]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class TrmCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["TRM_RMK.TXT", "TRM_CLB.TXT", "TRM_SEG.TXT", "TRM_MIN.TXT", "TRM_MSA.TXT", "TRM_PAR.TXT", "TRM_FDR.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: TrmRmk.self)
            case 1:
                delete(entityType: TrmClb.self)
            case 2:
                delete(entityType: TrmSeg.self)
            case 3:
                delete(entityType: TrmMin.self)
            case 4:
                delete(entityType: TrmMsa.self)
            case 5:
                delete(entityType: TrmPar.self)
            case 6:
                delete(entityType: TrmFdr.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .trm)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 9 {
                        let entity = TrmRmk(context: moc)
                        entity.arptIdent = property[0]
                        entity.proc = property[1].toInt16
                        entity.trmIdent = property[2]
                        entity.appType = property[3]
                        entity.rmkSeq = property[4].toInt16
                        entity.icao = property[5]
                        entity.remarks = property[6]
                        entity.cycleDate = property[7].toInt16
                        entity.rmkType = property[8]
                    }}
                moc.performAndWait {
                    do {
                        try moc.save()
                        
                    } catch {
                        print(error)
                    }}
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 12 {
                        let entity = TrmClb(context: moc)
                        entity.arptIdent = property[0]
                        entity.proc = property[1].toInt16
                        entity.trmIdent = property[2]
                        entity.rwyId = property[3].toInt16
                        entity.occNo = property[4].toInt16
                        entity.icao = property[5]
                        entity.desig = property[6].toInt16
                        entity.knots = property[7].toInt16
                        entity.rateDesc = property[8].toInt16
                        entity.alt = property[9].toInt16
                        entity.ftnote = property[10]
                        entity.cycleDate = property[11]
                    }}
                moc.performAndWait {
                do {
                    try moc.save()
                } catch {
                    print(error)
                }}
                print("\(fileNames[i]) DONE")
            case 2:
                func breakUp(lineItem: [[String]]) {
                    for property in lineItem {
                        if property.count >= 65 {
                            let entity = TrmSeg(context: moc)
                            entity.arptIdent = property[0]
                            entity.proc = property[1].toInt16
                            entity.trmIdent = property[2]
                            entity.seqNbr = property[3].toInt16
                            entity.type = property[4].toInt16
                            entity.transition = property[5]
                            entity.icao = property[6]
                            entity.trackCd = property[7]
                            entity.wptId = property[8]
                            entity.wptCtry = property[9]
                            entity.wptDesc1 = property[10]
                            entity.wptDesc2 = property[11]
                            entity.wptDesc3 = property[12]
                            entity.wptDesc4 = property[13]
                            entity.turnDir = property[14]
                            entity.nav1Ident = property[15]
                            entity.nav1Type = property[16]
                            entity.nav1Ctry = property[17]
                            entity.nav1KeyCd = property[18]
                            entity.nav1Bear = property[19]
                            entity.nav1Dist = property[20]
                            entity.nav2Ident = property[21]
                            entity.nav2Type = property[22]
                            entity.nav2Ctry = property[23]
                            entity.nav2KeyCd = property[24]
                            entity.nav2Bear = property[25]
                            entity.nav2Dist = property[26]
                            entity.magCrs = property[27]
                            entity.distance = property[28]
                            entity.altDesc = property[29]
                            entity.altOne = property[30]
                            entity.altTwo = property[31]
                            entity.rnp = property[32]
                            entity.cycleDate = property[33].toInt16
                            entity.wptWgsLat = property[34]
                            entity.wptWgsDlat = property[35].toDouble
                            entity.wptWgsLong = property[36]
                            entity.wptWgsDlong = property[37].toDouble
                            entity.wptMvar = property[38].toDouble
                            entity.nav1WgsLat = property[39]
                            entity.nav1WgsDlat = property[40]
                            entity.nav1WgsLong = property[41]
                            entity.nav1WgsDlong = property[42]
                            entity.nav1Mvar = property[43]
                            entity.nav1DmeWgsLat = property[44]
                            entity.nav1DmeWgsDlat = property[45]
                            entity.nav1DmeWgsLong = property[46]
                            entity.nav1DmeWgsDlong = property[47]
                            entity.nav2WgsLat = property[48]
                            entity.nav2WgsDlat = property[49]
                            entity.nav2WgsLong = property[50]
                            entity.nav2WgsDlong = property[51]
                            entity.nav2Mvar = property[52]
                            entity.nav2DmeWgsLat = property[53]
                            entity.nav2DmeWgsDlat = property[54]
                            entity.nav2DmeWgsLong = property[55]
                            entity.nav2DmeWgsDlong = property[56]
                            entity.speed = property[57]
                            entity.speedAc = property[58]
                            entity.speedAlt = property[59]
                            entity.speed2 = property[60]
                            entity.speedAc2 = property[61]
                            entity.speedAlt2 = property[62]
                            entity.vnav = property[63]
                            entity.tch = property[64]
                        }}
                    moc.performAndWait {
                        do {
                            try moc.save()
                            
                        } catch {
                            print(error)
                        }}}
                
                let smaller = lineItem.chunked(into: lineItem.count/10)
                for each in smaller {
                    breakUp(lineItem: each)
                }
                print("\(fileNames[i]) DONE")
                
            case 3:
                for property in lineItem {
                    if property.count >= 32 {
                        let entity = TrmMin(context: moc)
                        entity.arptIdent = property[0]
                        entity.proc = property[1].toInt16
                        entity.trmIdent = property[2]
                        entity.appType = property[3]
                        entity.icao = property[4]
                        entity.catADh = property[5].toInt16
                        entity.catARv = property[6]
                        entity.catAHa = property[7].toInt16
                        entity.catAWxCl = property[8].toInt16
                        entity.catAWxPv = property[9]
                        entity.catBDh = property[10].toInt16
                        entity.catBRv = property[11]
                        entity.catBHa = property[12].toInt16
                        entity.catBWxCl = property[13].toInt16
                        entity.catBWxPv = property[14]
                        entity.catCDh = property[15].toInt16
                        entity.catCRv = property[16]
                        entity.catCHa = property[17].toInt16
                        entity.catCWxCl = property[18].toInt16
                        entity.catCWxPv = property[19]
                        entity.catDDh = property[20].toInt16
                        entity.catDRv = property[21]
                        entity.catDHa = property[22].toInt16
                        entity.catDWxCl = property[23].toInt16
                        entity.catDWxPv = property[24]
                        entity.catEDh = property[25]
                        entity.catERv = property[26]
                        entity.catEHa = property[27]
                        entity.catEWxCl = property[28]
                        entity.catEWxPv = property[29]
                        entity.minRmk = property[30]
                        entity.cycleDate = property[31]
                    }}
                moc.performAndWait {
                    do {
                        try moc.save()
                        
                    } catch {
                        print(error)
                    }}
                print("\(fileNames[i]) DONE")
            case 4:
                for property in lineItem {
                    if property.count >= 21 {
                        let entity = TrmMsa(context: moc)
                        entity.arptIdent = property[0]
                        entity.proc = property[1].toInt16
                        entity.trmIdent = property[2]
                        entity.secNbr = property[3].toInt16
                        entity.secAlt = property[4].toInt16
                        entity.icao = property[5]
                        entity.navIdent = property[6]
                        entity.navType = property[7]
                        entity.navCtry = property[8]
                        entity.navKeyCd = property[9]
                        entity.secBear1 = property[10].toInt16
                        entity.secBear2 = property[11]
                        entity.wptIdent = property[12]
                        entity.wptCtry = property[13]
                        entity.secMile1 = property[14].toInt16
                        entity.secMile2 = property[15].toInt16
                        entity.wgsLat = property[16]
                        entity.wgsDlat = property[17].toDouble
                        entity.wgsLong = property[18]
                        entity.wgsDlong = property[19].toDouble
                        entity.cycleDate = property[20]
                    }}
                moc.performAndWait {
                    do {
                        try moc.save()
                        
                    } catch {
                        print(error)
                    }}
                print("\(fileNames[i]) DONE")
            case 5:
                for property in lineItem {
                    if property.count >= 14 {
                        let entity = TrmPar(context: moc)
                        entity.arptIdent = property[0]
                        entity.proc = property[1].toInt16
                        entity.trmIdent = property[2]
                        entity.icao = property[3]
                        entity.esAlt = property[4]
                        entity.julianDate = property[5].toInt16
                        entity.amdtNo = property[6].toInt16
                        entity.opr = property[7]
                        entity.hostCtryAuth = property[8]
                        entity.cycleDate = property[9].toInt16
                        entity.altMin = property[10]
                        entity.tranAlt = property[11].toInt16
                        entity.tranLvl = property[12].toInt16
                        entity.rteTypeQual = property[13]
                    }}
                moc.performAndWait {
                    do {
                        try moc.save()
                        
                    } catch {
                        print(error)
                    }}
                print("\(fileNames[i]) DONE")
            case 6:
                for property in lineItem {
                    if property.count >= 22 {
                        let entity = TrmFdr(context: moc)
                        entity.arptIdent = property[0]
                        entity.proc = property[1]
                        entity.trmIdent = property[2]
                        entity.fdrRteIdent = property[3]
                        entity.seqNbr = property[4]
                        entity.icao = property[5]
                        entity.wpt1Ident = property[6]
                        entity.wpt1Ctry = property[7]
                        entity.wpt2Ident = property[8]
                        entity.wpt2Ctry = property[9]
                        entity.alt = property[10]
                        entity.magCrs = property[11]
                        entity.distance = property[12]
                        entity.wpt1WgsLat = property[13]
                        entity.wpt1WgsDlat = property[14]
                        entity.wpt1WgsLong = property[15]
                        entity.wpt1WgsDlong = property[16]
                        entity.wpt2WgsLat = property[17]
                        entity.wpt2WgsDlat = property[18]
                        entity.wpt2WgsLong = property[19]
                        entity.wpt2WgsDlong = property[20]
                        entity.cycleDate = property[21]
                    }}
                moc.performAndWait {
                    do {
                        try moc.save()
                        
                    } catch {
                        print(error)
                    }}
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class AppcCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["APPC_SUAS_WX.TXT", "APPC_COM_SYMBOLS.TXT", "APPC_PR_ACFT_TYPE.TXT", "APPC_NAV_TYPE.TXT", "APPC_ABSORBING_SYS.TXT", "APPC_TRM_TRACK_CD.TXT", "APPC_COM_TYPE.TXT", "APPC_LEVEL.TXT", "APPC_FLUIDS.TXT", "APPC_ATS_WPT_DESC_1.TXT", "APPC_ILS_CAT.TXT", "APPC_US_STATE_CODES.TXT", "APPC_ATS_FREQ_CLASS.TXT", "APPC_TRM_TYPE.TXT", "APPC_FUEL_CODES.TXT", "APPC_ATS_WPT_DESC_2.TXT", "APPC_ENGAGING_DEV.TXT", "APPC_PR_PT_TYPE.TXT", "APPC_TRM_NAV_TYPE.TXT", "APPC_CC_ICAO.TXT", "APPC_ATS_WPT_DESC_3.TXT", "APPC_MTR_CRS_ALT.TXT", "APPC_ATS_STATUS.TXT", "APPC_BDRY_TYPE.TXT", "APPC_ATS_WPT_DESC_4.TXT", "APPC_HELI_TYPE.TXT", "APPC_MTR_USAGE_CD.TXT", "APPC_WPT_TYPE.TXT", "APPC_ILS_COMP_TYPE.TXT", "APPC_WPT_USAGE_CD.TXT", "APPC_OILS.TXT", "APPC_AR_DIR.TXT", "APPC_DERIVATION.TXT", "APPC_AR_USAGE_CD.TXT", "APPC_RWY_SFC_CODES.TXT", "APPC_ATS_TYPE.TXT", "APPC_RWY_LGT_CODES.TXT", "APPC_NAV_STATUS.TXT", "APPC_PJA_TYPE.TXT", "APPC_NAV_RCC.TXT", "APPC_OPR_AGCY.TXT", "APPC_AR_TYPE.TXT", "APPC_TRM_PROC.TXT", "APPC_TRM_WPT_DESC_3.TXT", "APPC_TRM_WPT_DESC_2.TXT", "APPC_SHAPE.TXT", "APPC_COM_FREQ_UNIT.TXT", "APPC_TRM_WPT_DESC_1.TXT", "APPC_DAYLIGHT_SAV.TXT", "APPC_JASU.TXT", "APPC_ARPT_TYPE.TXT", "APPC_ACFT_CAP.TXT", "APPC_PJA_OPR_TIME.TXT", "APPC_TRM_WPT_DESC_4.TXT", "APPC_NAV_USAGE_CD.TXT", "APPC_LCL_HORIZ_DATUMS.TXT", "APPC_ILS_COLCTN.TXT", "APPC_ALTITUDE_DESC.TXT", "APPC_SUAS_TYPE.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: AppcSuasWx.self)
            case 1:
                delete(entityType: AppcComSymbols.self)
            case 2:
                delete(entityType: AppcPrAcftType.self)
            case 3:
                delete(entityType: AppcNavType.self)
            case 4:
                delete(entityType: AppcAbsorbingSys.self)
            case 5:
                delete(entityType: AppcTrmTrackCd.self)
            case 6:
                delete(entityType: AppcComType.self)
            case 7:
                delete(entityType: AppcLevel.self)
            case 8:
                delete(entityType: AppcFluids.self)
            case 9:
                delete(entityType: AppcAtsWptDesc1.self)
            case 10:
                delete(entityType: AppcIlsCat.self)
            case 11:
                delete(entityType: AppcUsStateCodes.self)
            case 12:
                delete(entityType: AppcAtsFreqClass.self)
            case 13:
                delete(entityType: AppcTrmType.self)
            case 14:
                delete(entityType: AppcFuelCodes.self)
            case 15:
                delete(entityType: AppcAtsWptDesc2.self)
            case 16:
                delete(entityType: AppcEngagingDev.self)
            case 17:
                delete(entityType: AppcPrPtType.self)
            case 18:
                delete(entityType: AppcTrmNavType.self)
            case 19:
                delete(entityType: AppcCcIcao.self)
            case 20:
                delete(entityType: AppcAtsWptDesc3.self)
            case 21:
                delete(entityType: AppcMtrCrsAlt.self)
            case 22:
                delete(entityType: AppcAtsStatus.self)
            case 23:
                delete(entityType: AppcBdryType.self)
            case 24:
                delete(entityType: AppcAtsWptDesc4.self)
            case 25:
                delete(entityType: AppcHeliType.self)
            case 26:
                delete(entityType: AppcMtrUsageCd.self)
            case 27:
                delete(entityType: AppcWptType.self)
            case 28:
                delete(entityType: AppcIlsCompType.self)
            case 29:
                delete(entityType: AppcWptUsageCd.self)
            case 30:
                delete(entityType: AppcOils.self)
            case 31:
                delete(entityType: AppcArDir.self)
            case 32:
                delete(entityType: AppcDerivation.self)
            case 33:
                delete(entityType: AppcArUsageCd.self)
            case 34:
                delete(entityType: AppcRwySfcCodes.self)
            case 35:
                delete(entityType: AppcAtsType.self)
            case 36:
                delete(entityType: AppcRwyLgtCodes.self)
            case 37:
                delete(entityType: AppcNavStatus.self)
            case 38:
                delete(entityType: AppcPjaType.self)
            case 39:
                delete(entityType: AppcNavRcc.self)
            case 40:
                delete(entityType: AppcOprAgcy.self)
            case 41:
                delete(entityType: AppcArType.self)
            case 42:
                delete(entityType: AppcTrmProc.self)
            case 43:
                delete(entityType: AppcTrmWptDesc3.self)
            case 44:
                delete(entityType: AppcTrmWptDesc2.self)
            case 45:
                delete(entityType: AppcShape.self)
            case 46:
                delete(entityType: AppcComFreqUnit.self)
            case 47:
                delete(entityType: AppcTrmWptDesc1.self)
            case 48:
                delete(entityType: AppcDaylightSav.self)
            case 49:
                delete(entityType: AppcJasu.self)
            case 50:
                delete(entityType: AppcArptType.self)
            case 51:
                delete(entityType: AppcAcftCap.self)
            case 52:
                delete(entityType: AppcPjaOprTime.self)
            case 53:
                delete(entityType: AppcTrmWptDesc4.self)
            case 54:
                delete(entityType: AppcNavUsageCd.self)
            case 55:
                delete(entityType: AppcLclHorizDatums.self)
            case 56:
                delete(entityType: AppcIlsColctn.self)
            case 57:
                delete(entityType: AppcAltitudeDesc.self)
            case 58:
                delete(entityType: AppcSuasType.self)
            default:
                print("Nothing to delete")
            }}}
    
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .appc)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcSuasWx(context: moc)
                        entity.wx = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcComSymbols(context: moc)
                        entity.sym = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcPrAcftType(context: moc)
                        entity.acftType = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 3:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcNavType(context: moc)
                        entity.type = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 4:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcAbsorbingSys(context: moc)
                        entity.abCode = property[0]
                        entity.type = property[1]
                        entity.description_ = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 5:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmTrackCd(context: moc)
                        entity.trackCd = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 6:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcComType(context: moc)
                        entity.comType = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 7:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcLevel(context: moc)
                        entity.level = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 8:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcFluids(context: moc)
                        entity.fluidCode = property[0]
                        entity.flip = property[1]
                        entity.description_ = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 9:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAtsWptDesc1(context: moc)
                        entity.wpt1Desc1 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 10:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcIlsCat(context: moc)
                        entity.cat = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 11:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcUsStateCodes(context: moc)
                        entity.ccpv = property[0]
                        entity.state = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 12:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAtsFreqClass(context: moc)
                        entity.freqClass = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 13:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmType(context: moc)
                        entity.type = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 14:
                for property in lineItem {
                    if property.count >= 6 {
                        let entity = AppcFuelCodes(context: moc)
                        entity.fuelCode = property[0].toInt16
                        entity.flip = property[1]
                        entity.nato = property[2]
                        entity.aka = property[3]
                        entity.eefc = property[4]
                        entity.description_ = property[5]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 15:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAtsWptDesc2(context: moc)
                        entity.wpt1Desc2 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 16:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcEngagingDev(context: moc)
                        entity.enCode = property[0]
                        entity.type = property[1]
                        entity.description_ = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 17:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcPrPtType(context: moc)
                        entity.ptTy = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 18:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmNavType(context: moc)
                        entity.nav1Type = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 19:
                for property in lineItem {
                    if property.count >= 4 {
                        let entity = AppcCcIcao(context: moc)
                        entity.country = property[0]
                        entity.countryName = property[1]
                        entity.icaoRgn = property[2]
                        entity.usage = property[3]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 20:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAtsWptDesc3(context: moc)
                        entity.wpt1Desc3 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 21:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcMtrCrsAlt(context: moc)
                        entity.crsAlt = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 22:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAtsStatus(context: moc)
                        entity.status = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 23:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcBdryType(context: moc)
                        entity.type = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 24:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAtsWptDesc4(context: moc)
                        entity.wpt1Desc4 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 25:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcHeliType(context: moc)
                        entity.type = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 26:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcMtrUsageCd(context: moc)
                        entity.usageCd = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 27:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcWptType(context: moc)
                        entity.type = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 28:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcIlsCompType(context: moc)
                        entity.compType = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 29:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcWptUsageCd(context: moc)
                        entity.usageCd = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 30:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcOils(context: moc)
                        entity.oilCode = property[0]
                        entity.flipNato = property[1]
                        entity.gradeType = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 31:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcArDir(context: moc)
                        entity.dir = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 32:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcDerivation(context: moc)
                        entity.derivation = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 33:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcArUsageCd(context: moc)
                        entity.useageCd = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 34:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcRwySfcCodes(context: moc)
                        entity.sfc = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 35:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAtsType(context: moc)
                        entity.type = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 36:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcRwyLgtCodes(context: moc)
                        entity.lgtCode = property[0].toInt16
                        entity.sys = property[1]
                        entity.definition = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 37:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcNavStatus(context: moc)
                        entity.status = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 38:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcPjaType(context: moc)
                        entity.type = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 39:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcNavRcc(context: moc)
                        entity.rcc = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 40:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcOprAgcy(context: moc)
                        entity.oprCode = property[0]
                        entity.type = property[1]
                        entity.description_ = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 41:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcArType(context: moc)
                        entity.type = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 42:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmProc(context: moc)
                        entity.proc = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 43:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmWptDesc3(context: moc)
                        entity.wptDesc3 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 44:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmWptDesc2(context: moc)
                        entity.wptDesc2 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 45:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcShape(context: moc)
                        entity.shap = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 46:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcComFreqUnit(context: moc)
                        entity.freqUnit = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 47:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmWptDesc1(context: moc)
                        entity.wptDesc1 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 48:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcDaylightSav(context: moc)
                        entity.timeCode = property[0]
                        entity.times = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 49:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcJasu(context: moc)
                        entity.jasuCode = property[0].toInt16
                        entity.type = property[1]
                        entity.description_ = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 50:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcArptType(context: moc)
                        entity.type = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 51:
                for property in lineItem {
                    if property.count >= 1 {
                        let entity = AppcAcftCap(context: moc)
                        entity.acftCode = property[0]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 52:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcPjaOprTime(context: moc)
                        entity.oprTime = property[0].toInt16
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 53:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcTrmWptDesc4(context: moc)
                        entity.wptDesc4 = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 54:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcNavUsageCd(context: moc)
                        entity.usageCd = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 55:
                for property in lineItem {
                    if property.count >= 3 {
                        let entity = AppcLclHorizDatums(context: moc)
                        entity.datumCode = property[0]
                        entity.datum = property[1]
                        entity.country = property[2]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 56:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcIlsColctn(context: moc)
                        entity.colctn = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 57:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcAltitudeDesc(context: moc)
                        entity.desc = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 58:
                for property in lineItem {
                    if property.count >= 2 {
                        let entity = AppcSuasType(context: moc)
                        entity.type = property[0]
                        entity.description_ = property[1]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class ArptCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["ILS.TXT", "RWY.TXT", "ARPT_RMK.TXT", "ACOM.TXT", "ARPT.TXT", "ACOM_RMK.TXT", "ANAV.TXT", "AGEAR.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Ils.self)
            case 1:
                delete(entityType: Rwy.self)
            case 2:
                delete(entityType: ArptRmk.self)
            case 3:
                delete(entityType: Acom.self)
            case 4:
                delete(entityType: Arpt.self)
            case 5:
                delete(entityType: AcomRmk.self)
            case 6:
                delete(entityType: Anav.self)
            case 7:
                delete(entityType: Agear.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .arpt)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 30 {
                        let entity = Ils(context: moc)
                        entity.arptIdent = property[0]
                        entity.rwyIdent = property[1]
                        entity.compType = property[2]
                        entity.colctn = property[3]
                        entity.name = property[4]
                        entity.freq = property[5]
                        entity.chan = property[6]
                        entity.gsAngle = property[7]
                        entity.lczrGslctn = property[8]
                        entity.locMkrlctn = property[9]
                        entity.elev = property[10]
                        entity.locHdatum = property[11]
                        entity.wgsDatum = property[12]
                        entity.ilsCat = property[13]
                        entity.wgsLat = property[14]
                        entity.wgsDlat = property[15].toDouble
                        entity.wgsLong = property[16]
                        entity.wgsDlong = property[17].toDouble
                        entity.navIdent = property[18]
                        entity.navType = property[19]
                        entity.navCtry = property[20]
                        entity.navKeyCd = property[21]
                        entity.magVar = property[22]
                        entity.slaveVar = property[23]
                        entity.ilsBrg = property[24]
                        entity.locWidth = property[25]
                        entity.thdCrossingHgt = property[26]
                        entity.dmeBias = property[27]
                        entity.cycleDate = property[28]
                        entity.dmeNP = property[29]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 51 {
                        let entity = Rwy(context: moc)
                        entity.arptIdent = property[0]
                        entity.highIdent = property[1]
                        entity.lowIdent = property[2]
                        entity.highHdg = property[3].toDouble
                        entity.lowHdg = property[4].toDouble
                        entity.length = property[5].toInt16
                        entity.rwyWidth = property[6].toInt16
                        entity.surface = property[7]
                        entity.pcn = property[8]
                        entity.heWgsLat = property[9]
                        entity.heWgsDlat = property[10].toDouble
                        entity.heWgsLong = property[11]
                        entity.heWgsDlong = property[12].toDouble
                        entity.heElev = property[13].toDouble
                        entity.heSlope = property[14].toDouble
                        entity.heTdze = property[15]
                        entity.heDt = property[16].toInt16
                        entity.heDtElev = property[17].toDouble
                        entity.hlgtSys1 = property[18].toInt16
                        entity.hlgtSys2 = property[19].toInt16
                        entity.hlgtSys3 = property[20].toInt16
                        entity.hlgtSys4 = property[21]
                        entity.hlgtSys5 = property[22]
                        entity.hlgtSys6 = property[23]
                        entity.hlgtSys7 = property[24]
                        entity.hlgtSys8 = property[25]
                        entity.leWgsLat = property[26]
                        entity.leWgsDlat = property[27].toDouble
                        entity.leWgsLong = property[28]
                        entity.leWgsDlong = property[29].toDouble
                        entity.leElev = property[30].toDouble
                        entity.leSlope = property[31].toDouble
                        entity.leTdze = property[32]
                        entity.leDt = property[33].toInt16
                        entity.leDtElev = property[34].toDouble
                        entity.llgtSys1 = property[35].toInt16
                        entity.llgtSys2 = property[36].toInt16
                        entity.llgtSys3 = property[37].toInt16
                        entity.llgtSys4 = property[38]
                        entity.llgtSys5 = property[39]
                        entity.llgtSys6 = property[40]
                        entity.llgtSys7 = property[41]
                        entity.llgtSys8 = property[42]
                        entity.heTrueHdg = property[43].toDouble
                        entity.leTrueHdg = property[44].toDouble
                        entity.cldRwy = property[45]
                        entity.helandDis = property[46].toInt16
                        entity.heTakeoff = property[47].toInt16
                        entity.lelandDis = property[48].toInt16
                        entity.leTakeoff = property[49].toInt16
                        entity.cycleDate = property[50]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 4 {
                        let entity = ArptRmk(context: moc)
                        entity.arptIdent = property[0]
                        entity.rmkSeq = property[1]
                        entity.remark = property[2]
                        entity.cycleDate = property[3]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 3:
                for property in lineItem {
                    if property.count >= 24 {
                        let entity = Acom(context: moc)
                        entity.arptIdent = property[0]
                        entity.commType = property[1]
                        entity.commName = property[2]
                        entity.sym = property[3]
                        entity.freq1 = property[4]
                        entity.freq2 = property[5]
                        entity.freq3 = property[6]
                        entity.freq4 = property[7]
                        entity.freq5 = property[8]
                        entity.sec = property[9]
                        entity.sOprH = property[10]
                        entity.cycleDate = property[11].toInt16
                        entity.multi = property[12].toInt16
                        entity.freqMulti = property[13].toInt16
                        entity.comFreq1 = property[14].toInt16
                        entity.freqUnit1 = property[15]
                        entity.comFreq2 = property[16]
                        entity.freqUnit2 = property[17]
                        entity.comFreq3 = property[18]
                        entity.freqUnit3 = property[19]
                        entity.comFreq4 = property[20]
                        entity.freqUnit4 = property[21]
                        entity.comFreq5 = property[22]
                        entity.freqUnit5 = property[23]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 4:
                for property in lineItem {
                    if property.count >= 25 {
                        let entity = Arpt(context: moc)
                        entity.arptIdent = property[0]
                        entity.name = property[1]
                        entity.stateProv = property[2]
                        entity.icao = property[3]
                        entity.faaHostId = property[4]
                        entity.locHdatum = property[5]
                        entity.wgsDatum = property[6]
                        entity.wgsLat = property[7]
                        entity.wgsDlat = property[8].toDouble
                        entity.wgsLong = property[9]
                        entity.wgsDlong = property[10].toDouble
                        entity.elev = property[11].toInt16
                        entity.type = property[12]
                        entity.magVar = property[13]
                        entity.wac = property[14].toInt16
                        entity.beacon = property[15]
                        entity.secondArpt = property[16]
                        entity.oprAgy = property[17]
                        entity.secName = property[18]
                        entity.secIcao = property[19]
                        entity.secFaa = property[20]
                        entity.secOprAgy = property[21]
                        entity.cycleDate = property[22].toInt16
                        entity.terrain = property[23]
                        entity.hydro = property[24]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 5:
                for property in lineItem {
                    if property.count >= 6 {
                        let entity = AcomRmk(context: moc)
                        entity.arptIdent = property[0]
                        entity.commType = property[1]
                        entity.rmkSeq = property[2].toInt16
                        entity.remark = property[3]
                        entity.cycleDate = property[4].toInt16
                        entity.multi = property[5]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 6:
                for property in lineItem {
                    if property.count >= 10 {
                        let entity = Anav(context: moc)
                        entity.arptIdent = property[0]
                        entity.navIdent = property[1]
                        entity.navType = property[2].toInt16
                        entity.navCtry = property[3]
                        entity.navKeyCd = property[4].toInt16
                        entity.name = property[5]
                        entity.atFld = property[6]
                        entity.bearing = property[7].toDouble
                        entity.distance = property[8].toDouble
                        entity.cycleDate = property[9]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 7:
                for property in lineItem {
                    if property.count >= 5 {
                        let entity = Agear(context: moc)
                        entity.arptIdent = property[0]
                        entity.rwyIdent = property[1].toInt16
                        entity.location = property[2]
                        entity.type = property[3]
                        entity.cycleDate = property[4]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
        do {
            try moc.save()
            DispatchQueue.main.async {
            }
        } catch {
            print(error)
        }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class OrtcaCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["ORTCA.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Ortca.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .ortca)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 20 {
                        let entity = Ortca(context: moc)
                        entity.ortcaIdent = property[0].toInt16
                        entity.alt = property[1].toInt16
                        entity.nwLat = property[2]
                        entity.nwDlat = property[3].toDouble
                        entity.nwLong = property[4]
                        entity.nwDlong = property[5].toDouble
                        entity.neLat = property[6]
                        entity.neDlat = property[7].toDouble
                        entity.neLong = property[8]
                        entity.neDlong = property[9].toDouble
                        entity.swLat = property[10]
                        entity.swDlat = property[11].toDouble
                        entity.swLong = property[12]
                        entity.swDlong = property[13].toDouble
                        entity.seLat = property[14]
                        entity.seDlat = property[15].toDouble
                        entity.seLong = property[16]
                        entity.seDlong = property[17].toDouble
                        entity.cycleDate = property[18].toInt16
                        entity.ortcaId = property[19]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}

public class WptCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["WPT.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Wpt.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .wpt)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 26 {
                        let entity = Wpt(context: moc)
                        entity.wptIdent = property[0]
                        entity.ctry = property[1]
                        entity.stateProv = property[2].toInt16
                        entity.wptNavFlag = property[3]
                        entity.type = property[4]
                        entity.desc = property[5]
                        entity.icao = property[6]
                        entity.usageCd = property[7]
                        entity.bearing = property[8].toDouble
                        entity.distance = property[9].toDouble
                        entity.wac = property[10].toInt16
                        entity.locHdatum = property[11]
                        entity.wgsDatum = property[12]
                        entity.wgsLat = property[13]
                        entity.wgsDlat = property[14].toDouble
                        entity.wgsLong = property[15]
                        entity.wgsDlong = property[16].toDouble
                        entity.magVar = property[17]
                        entity.navIdent = property[18]
                        entity.navType = property[19].toInt16
                        entity.navCtry = property[20]
                        entity.navKeyCd = property[21].toInt16
                        entity.cycleDate = property[22].toInt16
                        entity.wptRvsm = property[23]
                        entity.rwyId = property[24]
                        entity.rwyIcao = property[25]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class PjaCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["PJA.TXT", "PJA_PAR.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Pja.self)
            case 1:
                delete(entityType: PjaPar.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .pja)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 30 {
                        let entity = Pja(context: moc)
                        entity.pjaIdent = property[0]
                        entity.segNbr = property[1].toInt16
                        entity.name = property[2]
                        entity.icaoRegion = property[3]
                        entity.shap = property[4]
                        entity.derivation = property[5]
                        entity.wgsLat1 = property[6]
                        entity.wgsDlat1 = property[7]
                        entity.wgsLong1 = property[8]
                        entity.wgsDlong1 = property[9]
                        entity.wgsLat2 = property[10]
                        entity.wgsDlat2 = property[11]
                        entity.wgsLong2 = property[12]
                        entity.wgsDlong2 = property[13]
                        entity.wgsLat0 = property[14]
                        entity.wgsDlat0 = property[15].toDouble
                        entity.wgsLong0 = property[16]
                        entity.wgsDlong0 = property[17].toDouble
                        entity.type = property[18].toInt16
                        entity.radius1 = property[19]
                        entity.radius2 = property[20]
                        entity.bearing1 = property[21].toDouble
                        entity.bearing2 = property[22].toDouble
                        entity.distance1 = property[23].toDouble
                        entity.distance2 = property[24].toDouble
                        entity.navIdent = property[25]
                        entity.navType = property[26].toInt16
                        entity.navCtry = property[27]
                        entity.navKeyCd = property[28].toInt16
                        entity.cycleDate = property[29]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 9 {
                        let entity = PjaPar(context: moc)
                        entity.pjaIdent = property[0]
                        entity.name = property[1]
                        entity.icaoRegion = property[2]
                        entity.stateProv = property[3]
                        entity.oprTime = property[4].toInt16
                        entity.hours = property[5]
                        entity.alt = property[6]
                        entity.cycleDate = property[7].toInt16
                        entity.effTimes = property[8]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class IrCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["IR_PAR.TXT", "IR.TXT", "IR_CTRY.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: IrPar.self)
            case 1:
                delete(entityType: Ir.self)
            case 2:
                delete(entityType: IrCtry.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .ir)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 18 {
                        let entity = IrPar(context: moc)
                        entity.bdryIdent = property[0]
                        entity.type = property[1].toInt16
                        entity.name = property[2]
                        entity.icao = property[3]
                        entity.conAuth = property[4]
                        entity.locHdatum = property[5]
                        entity.wgsDatum = property[6]
                        entity.commName = property[7]
                        entity.commFreq1 = property[8]
                        entity.commFreq2 = property[9]
                        entity.class_ = property[10]
                        entity.classExc = property[11]
                        entity.classExRmk = property[12]
                        entity.level = property[13]
                        entity.upperAlt = property[14]
                        entity.lowerAlt = property[15]
                        entity.rnp = property[16].toInt16
                        entity.cycleDate = property[17]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 28 {
                        let entity = Ir(context: moc)
                        entity.bdryIdent = property[0]
                        entity.segNbr = property[1].toInt16
                        entity.name = property[2]
                        entity.type = property[3].toInt16
                        entity.icao = property[4]
                        entity.shap = property[5]
                        entity.derivation = property[6]
                        entity.wgsLat1 = property[7]
                        entity.wgsDlat1 = property[8].toDouble
                        entity.wgsLong1 = property[9]
                        entity.wgsDlong1 = property[10].toDouble
                        entity.wgsLat2 = property[11]
                        entity.wgsDlat2 = property[12].toDouble
                        entity.wgsLong2 = property[13]
                        entity.wgsDlong2 = property[14].toDouble
                        entity.wgsLat0 = property[15]
                        entity.wgsDlat0 = property[16]
                        entity.wgsLong0 = property[17]
                        entity.wgsDlong0 = property[18]
                        entity.radius1 = property[19]
                        entity.radius2 = property[20]
                        entity.bearing1 = property[21]
                        entity.bearing2 = property[22]
                        entity.navIdent = property[23]
                        entity.navType = property[24]
                        entity.navCtry = property[25]
                        entity.navKeyCd = property[26]
                        entity.cycleDate = property[27]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 8 {
                        let entity = IrCtry(context: moc)
                        entity.bdryIdent = property[0]
                        entity.segNbr = property[1].toInt16
                        entity.ctry1 = property[2]
                        entity.ctry2 = property[3]
                        entity.ctry3 = property[4]
                        entity.ctry4 = property[5]
                        entity.ctry5 = property[6]
                        entity.cycleDate = property[7]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class MtrCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["MTR_OSM.TXT", "MTR.TXT", "MTR_OV.TXT", "MTR_RMK.TXT", "MTR_PAR.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: MtrOsm.self)
            case 1:
                delete(entityType: Mtr.self)
            case 2:
                delete(entityType: MtrOv.self)
            case 3:
                delete(entityType: MtrRmk.self)
            case 4:
                delete(entityType: MtrPar.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .mtr)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 8 {
                        let entity = MtrOsm(context: moc)
                        entity.mtrIdent = property[0]
                        entity.segNbr = property[1].toInt16
                        entity.seqNbr = property[2].toInt16
                        entity.suasMoaId = property[3]
                        entity.cycleDate = property[4].toInt16
                        entity.sector = property[5]
                        entity.ptIdent = property[6]
                        entity.nxPoint = property[7]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 28 {
                        let entity = Mtr(context: moc)
                        entity.mtrIdent = property[0]
                        entity.ptIdent = property[1]
                        entity.nxPoint = property[2]
                        entity.icaoRegion = property[3]
                        entity.crsaltDesc = property[4]
                        entity.crsAlt1 = property[5]
                        entity.crsAlt2 = property[6]
                        entity.enraltDesc = property[7]
                        entity.enrAlt1 = property[8]
                        entity.enrAlt2 = property[9]
                        entity.ptNavFlag = property[10]
                        entity.navIdent = property[11]
                        entity.navType = property[12].toInt16
                        entity.navCtry = property[13]
                        entity.navKeyCd = property[14].toInt16
                        entity.bearing = property[15].toDouble
                        entity.distance = property[16].toDouble
                        entity.mtrWidthL = property[17].toDouble
                        entity.mtrWidthR = property[18].toDouble
                        entity.usageCd = property[19]
                        entity.wgsLat = property[20]
                        entity.wgsDlat = property[21].toDouble
                        entity.wgsLong = property[22]
                        entity.wgsDlong = property[23].toDouble
                        entity.turnRad = property[24]
                        entity.turnDir = property[25]
                        entity.addInfo = property[26]
                        entity.cycleDate = property[27]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 25 {
                        let entity = MtrOv(context: moc)
                        entity.mtrIdent = property[0]
                        entity.segNbr = property[1].toInt16
                        entity.ptIdent = property[2]
                        entity.ptUsage = property[3]
                        entity.ptLat = property[4]
                        entity.ptDlat = property[5].toDouble
                        entity.ptLong = property[6]
                        entity.ptDlong = property[7].toDouble
                        entity.ptWdthL = property[8].toDouble
                        entity.ptWdthR = property[9].toDouble
                        entity.ptTrnRad = property[10]
                        entity.ptTrnDir = property[11]
                        entity.ptBiSec = property[12].toDouble
                        entity.nxPoint = property[13]
                        entity.nxUsage = property[14]
                        entity.nxLat = property[15]
                        entity.nxDlat = property[16].toDouble
                        entity.nxLong = property[17]
                        entity.nxDlong = property[18].toDouble
                        entity.nxWdthL = property[19].toDouble
                        entity.nxWdthR = property[20].toDouble
                        entity.nxTrnRad = property[21]
                        entity.nxTrnDir = property[22]
                        entity.nxBiSec = property[23].toDouble
                        entity.cycleDate = property[24]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 3:
                for property in lineItem {
                    if property.count >= 4 {
                        let entity = MtrRmk(context: moc)
                        entity.mtrIdent = property[0]
                        entity.rmkSeq = property[1].toInt16
                        entity.remarks = property[2]
                        entity.cycleDate = property[3]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 4:
                for property in lineItem {
                    if property.count >= 9 {
                        let entity = MtrPar(context: moc)
                        entity.mtrIdent = property[0]
                        entity.origAct = property[1]
                        entity.schAct = property[2]
                        entity.icaoRegion = property[3]
                        entity.ctry = property[4]
                        entity.locHdatum = property[5]
                        entity.wgsDatum = property[6]
                        entity.effTimes = property[7]
                        entity.cycleDate = property[8]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class PappCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["PAPP.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Papp.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .papp)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 29 {
                        let entity = Papp(context: moc)
                        entity.arptIdent = property[0]
                        entity.appIdent = property[1]
                        entity.faaHostId = property[2]
                        entity.rwId = property[3]
                        entity.opsType = property[4]
                        entity.appInd = property[5]
                        entity.spId = property[6]
                        entity.refPds = property[7]
                        entity.refId = property[8]
                        entity.apd = property[9]
                        entity.ltpLat = property[10]
                        entity.ltpDlat = property[11]
                        entity.ltpLong = property[12]
                        entity.ltpDlong = property[13]
                        entity.ltpThrsHgt = property[14]
                        entity.fpcpTch = property[15]
                        entity.gpa = property[16]
                        entity.fpapLat = property[17]
                        entity.fpapDlat = property[18]
                        entity.fpapLong = property[19]
                        entity.fpapDlong = property[20]
                        entity.widthThrs = property[21]
                        entity.ofset = property[22]
                        entity.uh = property[23]
                        entity.crc = property[24]
                        entity.ltpOrthHgt = property[25]
                        entity.fpapOrthHgt = property[26]
                        entity.fpapAlHgt = property[27]
                        entity.cycleDate = property[28]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}

public class NavCDU: DafifLoaderUtilities, CoreDataUtilities {
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["NAV.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Nav.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .nav)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 32 {
                        let entity = Nav(context: moc)
                        entity.navIdent = property[0]
                        entity.type = property[1].toInt16
                        entity.ctry = property[2]
                        entity.navKeyCd = property[3].toInt16
                        entity.stateProv = property[4]
                        entity.name = property[5]
                        entity.icao = property[6]
                        entity.wac = property[7].toInt16
                        entity.freq = property[8]
                        entity.usageCd = property[9]
                        entity.chan = property[10]
                        entity.rcc = property[11]
                        entity.freqProt = property[12]
                        entity.power = property[13]
                        entity.navRange = property[14]
                        entity.locHdatum = property[15]
                        entity.wgsDatum = property[16]
                        entity.wgsLat = property[17]
                        entity.wgsDlat = property[18].toDouble
                        entity.wgsLong = property[19]
                        entity.wgsDlong = property[20].toDouble
                        entity.slavedVar = property[21]
                        entity.magVar = property[22]
                        entity.elev = property[23]
                        entity.dmeWgsLat = property[24]
                        entity.dmeWgsDlat = property[25]
                        entity.dmeWgsLong = property[26]
                        entity.dmeWgsDlong = property[27]
                        entity.dmeElev = property[28]
                        entity.arptIcao = property[29]
                        entity.os = property[30]
                        entity.cycleDate = property[31]
                    }}
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class PrCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["PR.TXT", "PR_PAR.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Pr.self)
            case 1:
                delete(entityType: PrPar.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .pr)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 15 {
                        let entity = Pr(context: moc)
                        entity.prIdent = property[0]
                        entity.segNbr = property[1]
                        entity.ptTy1 = property[2]
                        entity.ptNameId1 = property[3]
                        entity.ptNaTy1 = property[4]
                        entity.ptCtry1 = property[5]
                        entity.ptAtsIcao1 = property[6]
                        entity.ptKeyCd1 = property[7]
                        entity.ptTy2 = property[8]
                        entity.ptNameId2 = property[9]
                        entity.ptNaTy2 = property[10]
                        entity.ptCtry2 = property[11]
                        entity.ptAtsIcao2 = property[12]
                        entity.ptKeyCd2 = property[13]
                        entity.cycleDate = property[14]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 15 {
                        let entity = PrPar(context: moc)
                        entity.prIdent = property[0]
                        entity.icaoRegion = property[1]
                        entity.level = property[2]
                        entity.startName = property[3]
                        entity.destName = property[4]
                        entity.acftType = property[5]
                        entity.acftSpeed = property[6]
                        entity.upperAlt = property[7]
                        entity.lowerAlt = property[8]
                        entity.effeTime1 = property[9]
                        entity.effeTime2 = property[10]
                        entity.effeTime3 = property[11]
                        entity.cycleDate = property[12]
                        entity.strtIcao = property[13]
                        entity.destIcao = property[14]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class TzCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["TZ_PAR.TXT", "TZ.txt"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: TzPar.self)
            case 1:
                delete(entityType: Tz.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .tz)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 18 {
                        let entity = TzPar(context: moc)
                        entity.bdryIdent = property[0]
                        entity.type = property[1].toInt16
                        entity.name = property[2]
                        entity.icao = property[3]
                        entity.conAuth = property[4]
                        entity.locHdatum = property[5]
                        entity.wgsDatum = property[6]
                        entity.commName = property[7]
                        entity.commFreq1 = property[8]
                        entity.commFreq2 = property[9]
                        entity.class_ = property[10]
                        entity.classExc = property[11]
                        entity.classExRmk = property[12]
                        entity.level = property[13]
                        entity.upperAlt = property[14]
                        entity.lowerAlt = property[15]
                        entity.rnp = property[16]
                        entity.cycleDate = property[17].toInt16
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 28 {
                        let entity = Tz(context: moc)
                        entity.bdryIdent = property[0]
                        entity.segNbr = property[1].toInt16
                        entity.name = property[2]
                        entity.type = property[3].toInt16
                        entity.icao = property[4]
                        entity.shap = property[5]
                        entity.derivation = property[6]
                        entity.wgsLat1 = property[7]
                        entity.wgsDlat1 = property[8].toDouble
                        entity.wgsLong1 = property[9]
                        entity.wgsDlong1 = property[10].toDouble
                        entity.wgsLat2 = property[11]
                        entity.wgsDlat2 = property[12].toDouble
                        entity.wgsLong2 = property[13]
                        entity.wgsDlong2 = property[14].toDouble
                        entity.wgsLat0 = property[15]
                        entity.wgsDlat0 = property[16]
                        entity.wgsLong0 = property[17]
                        entity.wgsDlong0 = property[18]
                        entity.radius1 = property[19]
                        entity.radius2 = property[20]
                        entity.bearing1 = property[21]
                        entity.bearing2 = property[22]
                        entity.navIdent = property[23]
                        entity.navType = property[24]
                        entity.navCtry = property[25]
                        entity.navKeyCd = property[26]
                        entity.cycleDate = property[27]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class HoldCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["HOLD.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Hold.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .hold)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 17 {
                        let entity = Hold(context: moc)
                        entity.wptId = property[0]
                        entity.wptCtry = property[1]
                        entity.icao = property[2]
                        entity.dup = property[3].toInt16
                        entity.inbCrs = property[4].toInt16
                        entity.turnDir = property[5]
                        entity.length = property[6]
                        entity.time = property[7].toDouble
                        entity.altOne = property[8].toInt16
                        entity.altTwo = property[9]
                        entity.speed = property[10].toInt16
                        entity.trackCd = property[11]
                        entity.navIdent = property[12]
                        entity.navType = property[13]
                        entity.navCtry = property[14]
                        entity.navKeyCd = property[15]
                        entity.cycleDate = property[16]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class SuasCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["SUAS_PAR.TXT", "SUAS.TXT", "SUAS_NOTE.TXT", "SUAS_CTRY.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: SuasPar.self)
            case 1:
                delete(entityType: Suas.self)
            case 2:
                delete(entityType: SuasNote.self)
            case 3:
                delete(entityType: SuasCtry.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .suas)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 18 {
                        let entity = SuasPar(context: moc)
                        entity.suasIdent = property[0]
                        entity.sector = property[1]
                        entity.type = property[2]
                        entity.name = property[3]
                        entity.icao = property[4]
                        entity.conAgcy = property[5]
                        entity.locHdatum = property[6]
                        entity.wgsDatum = property[7]
                        entity.commName = property[8]
                        entity.freq1 = property[9]
                        entity.freq2 = property[10]
                        entity.level = property[11]
                        entity.upperAlt = property[12]
                        entity.lowerAlt = property[13]
                        entity.effTimes = property[14]
                        entity.wx = property[15]
                        entity.cycleDate = property[16].toInt16
                        entity.effDate = property[17]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 29 {
                        let entity = Suas(context: moc)
                        entity.suasIdent = property[0]
                        entity.sector = property[1]
                        entity.segNbr = property[2].toInt16
                        entity.name = property[3]
                        entity.type = property[4]
                        entity.icao = property[5]
                        entity.shap = property[6]
                        entity.derivation = property[7]
                        entity.wgsLat1 = property[8]
                        entity.wgsDlat1 = property[9].toDouble
                        entity.wgsLong1 = property[10]
                        entity.wgsDlong1 = property[11].toDouble
                        entity.wgsLat2 = property[12]
                        entity.wgsDlat2 = property[13].toDouble
                        entity.wgsLong2 = property[14]
                        entity.wgsDlong2 = property[15].toDouble
                        entity.wgsLat0 = property[16]
                        entity.wgsDlat0 = property[17]
                        entity.wgsLong0 = property[18]
                        entity.wgsDlong0 = property[19]
                        entity.radius1 = property[20]
                        entity.radius2 = property[21]
                        entity.bearing1 = property[22]
                        entity.bearing2 = property[23]
                        entity.navIdent = property[24]
                        entity.navType = property[25]
                        entity.navCtry = property[26]
                        entity.navKeyCd = property[27]
                        entity.cycleDate = property[28]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 6 {
                        let entity = SuasNote(context: moc)
                        entity.suasIdent = property[0]
                        entity.sector = property[1]
                        entity.noteType = property[2]
                        entity.noteNbr = property[3].toInt16
                        entity.remarks = property[4]
                        entity.cycleDate = property[5]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 3:
                for property in lineItem {
                    if property.count >= 8 {
                        let entity = SuasCtry(context: moc)
                        entity.suasIdent = property[0]
                        entity.sector = property[1]
                        entity.icao = property[2]
                        entity.ctry1 = property[3]
                        entity.ctry2 = property[4]
                        entity.ctry3 = property[5]
                        entity.ctry4 = property[6]
                        entity.cycleDate = property[7]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class ArfCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["ARF_FT.TXT", "ARF_SEG.TXT", "ARF_ATC.TXT", "ARF_RMK.TXT", "ARF_PAR.TXT", "ARF_SCH.TXT", "ARF_PT.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: ArfFt.self)
            case 1:
                delete(entityType: ArfSeg.self)
            case 2:
                delete(entityType: ArfAtc.self)
            case 3:
                delete(entityType: ArfRmk.self)
            case 4:
                delete(entityType: ArfPar.self)
            case 5:
                delete(entityType: ArfSch.self)
            case 6:
                delete(entityType: ArfPt.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .arf)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 8 {
                        let entity = ArfFt(context: moc)
                        entity.arfIdent = property[0]
                        entity.direction = property[1]
                        entity.icao = property[2]
                        entity.ftType = property[3]
                        entity.ftNo = property[4].toInt16
                        entity.rmkSeq = property[5].toInt16
                        entity.remarks = property[6]
                        entity.cycleDate = property[7]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 27 {
                        let entity = ArfSeg(context: moc)
                        entity.arfIdent = property[0]
                        entity.direction = property[1]
                        entity.segNbr = property[2].toInt16
                        entity.icao = property[3]
                        entity.shap = property[4]
                        entity.derivation = property[5]
                        entity.wgsLat1 = property[6]
                        entity.wgsDlat1 = property[7].toDouble
                        entity.wgsLong1 = property[8]
                        entity.wgsDlong1 = property[9].toDouble
                        entity.wgsLat2 = property[10]
                        entity.wgsDlat2 = property[11].toDouble
                        entity.wgsLong2 = property[12]
                        entity.wgsDlong2 = property[13].toDouble
                        entity.wgsLat0 = property[14]
                        entity.wgsDlat0 = property[15]
                        entity.wgsLong0 = property[16]
                        entity.wgsDlong0 = property[17]
                        entity.radius1 = property[18]
                        entity.radius2 = property[19]
                        entity.bearing1 = property[20]
                        entity.bearing2 = property[21]
                        entity.navIdent = property[22]
                        entity.navType = property[23]
                        entity.navCtry = property[24]
                        entity.navKeyCd = property[25]
                        entity.cycleDate = property[26]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 18 {
                        let entity = ArfAtc(context: moc)
                        entity.arfIdent = property[0]
                        entity.direction = property[1]
                        entity.icao = property[2]
                        entity.usage = property[3]
                        entity.center = property[4]
                        entity.cntrMult = property[5].toInt16
                        entity.freq1 = property[6]
                        entity.eW1 = property[7]
                        entity.freq2 = property[8]
                        entity.eW2 = property[9]
                        entity.freq3 = property[10]
                        entity.eW3 = property[11]
                        entity.freq4 = property[12]
                        entity.eW4 = property[13]
                        entity.freq5 = property[14]
                        entity.eW5 = property[15]
                        entity.atcRmk = property[16]
                        entity.cycleDate = property[17]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 3:
                for property in lineItem {
                    if property.count >= 6 {
                        let entity = ArfRmk(context: moc)
                        entity.arfIdent = property[0]
                        entity.direction = property[1]
                        entity.rmkSeq = property[2].toInt16
                        entity.icao = property[3]
                        entity.remarks = property[4]
                        entity.cycleDate = property[5]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 4:
                for property in lineItem {
                    if property.count >= 23 {
                        let entity = ArfPar(context: moc)
                        entity.arfIdent = property[0]
                        entity.direction = property[1]
                        entity.icao = property[2]
                        entity.type = property[3]
                        entity.ctry = property[4]
                        entity.locHdatum = property[5]
                        entity.wgsDatum = property[6]
                        entity.priFreq = property[7].toDouble
                        entity.bkpFreq = property[8].toDouble
                        entity.apnCode = property[9]
                        entity.apxCode = property[10]
                        entity.receiver = property[11]
                        entity.tanker = property[12]
                        entity.alt1Desc = property[13]
                        entity.refuel1Alt1 = property[14]
                        entity.refuel1Alt2 = property[15]
                        entity.alt2Desc = property[16]
                        entity.refuel2Alt1 = property[17]
                        entity.refuel2Alt2 = property[18]
                        entity.alt3Desc = property[19]
                        entity.refuel3Alt1 = property[20]
                        entity.refuel3Alt2 = property[21]
                        entity.cycleDate = property[22]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 5:
                for property in lineItem {
                    if property.count >= 7 {
                        let entity = ArfSch(context: moc)
                        entity.arfIdent = property[0]
                        entity.direction = property[1]
                        entity.icao = property[2]
                        entity.schUnit = property[3]
                        entity.dsn = property[4]
                        entity.comNo = property[5]
                        entity.cycleDate = property[6]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 6:
                for property in lineItem {
                    if property.count >= 18 {
                        let entity = ArfPt(context: moc)
                        entity.arfIdent = property[0]
                        entity.direction = property[1]
                        entity.ptSeqNbr = property[2].toInt16
                        entity.icao = property[3]
                        entity.usage = property[4]
                        entity.ptNavFlag = property[5]
                        entity.navIdent = property[6]
                        entity.navType = property[7]
                        entity.navCtry = property[8]
                        entity.navKeyCd = property[9]
                        entity.bearing = property[10]
                        entity.distance = property[11]
                        entity.wgsLat = property[12]
                        entity.wgsDlat = property[13].toDouble
                        entity.wgsLong = property[14]
                        entity.wgsDlong = property[15].toDouble
                        entity.cycleDate = property[16].toInt16
                        entity.ptIdent = property[17]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class VfrCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["VFR_RTE.TXT", "VFR_RTE_SEG.TXT", "VFR_RTE_RMK.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: VfrRte.self)
            case 1:
                delete(entityType: VfrRteSeg.self)
            case 2:
                delete(entityType: VfrRteRmk.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .vfr)
            switch i {
            case 0:
                for property in lineItem {
                    if property.count >= 16 {
                        let entity = VfrRte(context: moc)
                        entity.heliIdent = property[0]
                        entity.heliName = property[1]
                        entity.ctry = property[2]
                        entity.stateProv = property[3]
                        entity.icao = property[4]
                        entity.faaHostId = property[5]
                        entity.wgsDatum = property[6]
                        entity.wgsLat = property[7]
                        entity.rpWgsDlat = property[8].toDouble
                        entity.wgsLong = property[9]
                        entity.rpWgsDlong = property[10].toDouble
                        entity.elev = property[11].toInt16
                        entity.magVar = property[12]
                        entity.cityCrossRef = property[13]
                        entity.locHdatum = property[14]
                        entity.cycleDate = property[15]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 1:
                for property in lineItem {
                    if property.count >= 29 {
                        let entity = VfrRteSeg(context: moc)
                        entity.heliIdent = property[0]
                        entity.rteIdent = property[1].toInt16
                        entity.segNbr = property[2].toInt16
                        entity.rteName = property[3]
                        entity.ptName = property[4]
                        entity.ptIdentity = property[5]
                        entity.ptWgsLat = property[6]
                        entity.ptWgsDlat = property[7].toDouble
                        entity.ptWgsLong = property[8]
                        entity.ptWgsDlong = property[9].toDouble
                        entity.utmGrid = property[10]
                        entity.ptLatOffR = property[11]
                        entity.ptDlatOffR = property[12]
                        entity.ptLongOffR = property[13]
                        entity.ptDlongOffR = property[14]
                        entity.ptLatOffL = property[15]
                        entity.ptDlatOffL = property[16]
                        entity.ptLongOffL = property[17]
                        entity.ptDlongOffL = property[18]
                        entity.ptType = property[19]
                        entity.ptSym = property[20]
                        entity.atHeli = property[21]
                        entity.segName = property[22]
                        entity.magCrs = property[23]
                        entity.pathCode = property[24]
                        entity.altDesc = property[25]
                        entity.alt = property[26].toInt16
                        entity.turnDir = property[27]
                        entity.cycleDate = property[28]
                    }}
                
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 4 {
                        let entity = VfrRteRmk(context: moc)
                        entity.heliIdent = property[0]
                        entity.rmkSeq = property[1].toInt16
                        entity.remarks = property[2]
                        entity.cycleDate = property[3]
                    }}
                
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        moc.performAndWait {
            do {
                try moc.save()
            } catch {
                print(error)
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
public class BdryCDU: DafifLoaderUtilities, CoreDataUtilities {
    
    public required init(){}
    
    // MARK: - File Handling
    public var fileNames: [String] = ["BDRY.TXT", "BDRY_CTRY.TXT", "BDRY_PAR.TXT"]
    
    public func deleteAllFromCoreData(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            switch i {
            case 0:
                delete(entityType: Bdry.self)
            case 1:
                delete(entityType: BdryCtry.self)
            case 2:
                delete(entityType: BdryPar.self)
            default:
                print("Nothing to delete")
            }}}
    
    public func loadAllFolderItems(moc: NSManagedObjectContext) {
        for i in 0..<fileNames.count {
            let lineItem: [[String]] = getData(from: fileNames[i], inDir: .bdry)
            switch i {
            case 0:
                func breakUp(lineItem: [[String]]) {
                    for property in lineItem {
                        if property.count >= 28 {
                            let entity = Bdry(context: moc)
                            entity.bdryIdent = property[0]
                            entity.segNbr = property[1].toInt16
                            entity.name = property[2]
                            entity.type = property[3].toInt16
                            entity.icao = property[4]
                            entity.shap = property[5]
                            entity.derivation = property[6]
                            entity.wgsLat1 = property[7]
                            entity.wgsDlat1 = property[8].toDouble
                            entity.wgsLong1 = property[9]
                            entity.wgsDlong1 = property[10].toDouble
                            entity.wgsLat2 = property[11]
                            entity.wgsDlat2 = property[12].toDouble
                            entity.wgsLong2 = property[13]
                            entity.wgsDlong2 = property[14].toDouble
                            entity.wgsLat0 = property[15]
                            entity.wgsDlat0 = property[16]
                            entity.wgsLong0 = property[17]
                            entity.wgsDlong0 = property[18]
                            entity.radius1 = property[19]
                            entity.radius2 = property[20]
                            entity.bearing1 = property[21]
                            entity.bearing2 = property[22]
                            entity.navIdent = property[23]
                            entity.navType = property[24]
                            entity.navCtry = property[25]
                            entity.navKeyCd = property[26]
                            entity.cycleDate = property[27]
                        }}
                    moc.performAndWait {
                        do {
                            try moc.save()
                            
                        } catch {
                            print(error)
                        }}}
                let smaller = lineItem.chunked(into: lineItem.count/10)
                for each in smaller {
                    breakUp(lineItem: each)
                }
                print("\(fileNames[i]) DONE")
            case 1:
                func breakUp(lineItem: [[String]]) {
                    for property in lineItem {
                        if property.count >= 8 {
                            let entity = BdryCtry(context: moc)
                            entity.bdryIdent = property[0]
                            entity.segNbr = property[1].toInt16
                            entity.ctry1 = property[2]
                            entity.ctry2 = property[3]
                            entity.ctry3 = property[4]
                            entity.ctry4 = property[5]
                            entity.ctry5 = property[6]
                            entity.cycleDate = property[7]
                        }}
                    moc.performAndWait {
                        do {
                            try moc.save()
                        } catch {
                            print(error)
                        }}}
                let smaller = lineItem.chunked(into: lineItem.count/10)
                for each in smaller {
                    breakUp(lineItem: each)
                }
                print("\(fileNames[i]) DONE")
            case 2:
                for property in lineItem {
                    if property.count >= 20 {
                        let entity = BdryPar(context: moc)
                        entity.bdryIdent = property[0]
                        entity.type = property[1].toInt16
                        entity.name = property[2]
                        entity.icao = property[3]
                        entity.conAuth = property[4]
                        entity.locHdatum = property[5]
                        entity.wgsDatum = property[6]
                        entity.commName = property[7]
                        entity.commFreq1 = property[8]
                        entity.commFreq2 = property[9]
                        entity.class_ = property[10]
                        entity.classExc = property[11]
                        entity.classExRmk = property[12]
                        entity.level = property[13]
                        entity.upperAlt = property[14]
                        entity.lowerAlt = property[15]
                        entity.rnp = property[16].toInt16
                        entity.cycleDate = property[17].toInt16
                        entity.upRvsm = property[18]
                        entity.loRvsm = property[19]
                    }}
                moc.performAndWait {
                    do {
                        try moc.save()
                        
                    } catch {
                        print(error)
                    }}
                print("\(fileNames[i]) DONE")
            default:
                print("Nothing to see here")
            }}
        print("\(#file) :: \(#function) :: complete")
    }
}
