// ********************** CoreDataLoader *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** CoreDataLoader *********************************


import SwiftUI
import Combine
import CoreData


public class CoreDataLoader: ObservableObject, CoreDataUtilities {
    
    public static var shared = CoreDataLoader()
    
    private let allDafifLoaders: [DafifLoaderUtilities.Type] = [AtsCDU.self, HlptCDU.self, SuppCDU.self, TrmCDU.self, AppcCDU.self, ArptCDU.self, OrtcaCDU.self, WptCDU.self, PjaCDU.self, IrCDU.self, MtrCDU.self, PappCDU.self, NavCDU.self, PrCDU.self, TzCDU.self, HoldCDU.self, SuasCDU.self, ArfCDU.self, VfrCDU.self, BdryCDU.self]
    
    private let allDafifEntities = [VfrRte.self, VfrRteSeg.self, VfrRteRmk.self, Pja.self, PjaPar.self, Ortca.self, IrPar.self, Ir.self, IrCtry.self, ArfFt.self, ArfSeg.self, ArfAtc.self, ArfRmk.self, ArfPar.self, ArfSch.self, ArfPt.self, MtrOsm.self, Mtr.self, MtrOv.self, MtrRmk.self, MtrPar.self, SuasPar.self, Suas.self, SuasNote.self, SuasCtry.self, Ils.self, Rwy.self, ArptRmk.self, Acom.self, Arpt.self, AcomRmk.self, Anav.self, Agear.self, TrmRmk.self, TrmClb.self, TrmSeg.self, TrmMin.self, TrmMsa.self, TrmPar.self, TrmFdr.self, Pad.self, Hnav.self, HlptRmk.self, Hlpt.self, Hcom.self, HcomRmk.self, AppcSuasWx.self, AppcComSymbols.self, AppcPrAcftType.self, AppcNavType.self, AppcAbsorbingSys.self, AppcTrmTrackCd.self, AppcComType.self, AppcLevel.self, AppcFluids.self, AppcAtsWptDesc1.self, AppcIlsCat.self, AppcUsStateCodes.self, AppcAtsFreqClass.self, AppcTrmType.self, AppcFuelCodes.self, AppcAtsWptDesc2.self, AppcEngagingDev.self, AppcPrPtType.self, AppcTrmNavType.self, AppcCcIcao.self, AppcAtsWptDesc3.self, AppcMtrCrsAlt.self, AppcAtsStatus.self, AppcBdryType.self, AppcAtsWptDesc4.self, AppcHeliType.self, AppcMtrUsageCd.self, AppcWptType.self, AppcIlsCompType.self, AppcWptUsageCd.self, AppcOils.self, AppcArDir.self, AppcDerivation.self, AppcArUsageCd.self, AppcRwySfcCodes.self, AppcAtsType.self, AppcRwyLgtCodes.self, AppcNavStatus.self, AppcPjaType.self, AppcNavRcc.self, AppcOprAgcy.self, AppcArType.self, AppcTrmProc.self, AppcTrmWptDesc3.self, AppcTrmWptDesc2.self, AppcShape.self, AppcComFreqUnit.self, AppcTrmWptDesc1.self, AppcDaylightSav.self, AppcJasu.self, AppcArptType.self, AppcAcftCap.self, AppcPjaOprTime.self, AppcTrmWptDesc4.self, AppcNavUsageCd.self, AppcLclHorizDatums.self, AppcIlsColctn.self, AppcAltitudeDesc.self, AppcSuasType.self, Pr.self, PrPar.self, Wpt.self, Papp.self, Nav.self, Bdry.self, BdryCtry.self, BdryPar.self, AtsRmk.self, AtsCtry.self, Ats.self, TzPar.self, Tz.self, Hold.self, Fueloil.self, SvcRmk.self, AddRwy.self, Gen.self]
    
    internal func zeroOutCounters() {
        DispatchQueue.main.async {
            DafifAPI.shared.processingCoreDataProgress = 0
        }}
    
    internal func incrementComplete(_ counter: CGFloat, total: CGFloat) -> CGFloat {
        let counter = counter + 1
        DispatchQueue.main.async {
            DafifAPI.shared.processingCoreDataProgress = counter / total
        }
        return counter
    }
    
    public static func loadSomeData(data: DafifDesired) {
        let deleteGroup = DispatchGroup()
        deleteGroup.enter()
        CoreDataLoader.deleteData(data: data)
        deleteGroup.leave()
        pc.performBackgroundTask({ (moc) in
            CoreDataLoader.shared.zeroOutCounters()
            var counter: CGFloat = 0
            switch data {
            case .all:
                for loader in CoreDataLoader.shared.allDafifLoaders {
                    loader.self.init().loadAllFolderItems(moc: moc)
                    counter = CoreDataLoader.shared.incrementComplete(counter, total: CGFloat(CoreDataLoader.shared.allDafifLoaders.count))
                }
            case .some(let requiredData):
                for rd in requiredData {
                    rd.self.init().loadAllFolderItems(moc: moc)
                    counter = CoreDataLoader.shared.incrementComplete(counter, total: CGFloat(requiredData.count))
                }
            }})}
    
    
    public static func deleteData(data: DafifDesired) {
        pc.performBackgroundTask({ (moc) in
            switch data {
            case .all:
                for loader in CoreDataLoader.shared.allDafifLoaders {
                    loader.self.init().deleteAllFromCoreData(moc: moc)
                }
            case .some(let requiredData):
                for loader in requiredData {
                    loader.self.init().deleteAllFromCoreData(moc: moc)
                }
            }
            
        })
    }
    
    //Debug Printer
    public static func printCDCounter() {
        pc.performBackgroundTask({ (moc) in
            CoreDataLoader.shared.get(entityType: VfrRte.self)
            CoreDataLoader.shared.get(entityType: VfrRteSeg.self)
            CoreDataLoader.shared.get(entityType: VfrRteRmk.self)
            CoreDataLoader.shared.get(entityType: Pja.self)
            CoreDataLoader.shared.get(entityType: PjaPar.self)
            CoreDataLoader.shared.get(entityType: Ortca.self)
            CoreDataLoader.shared.get(entityType: IrPar.self)
            CoreDataLoader.shared.get(entityType: Ir.self)
            CoreDataLoader.shared.get(entityType: IrCtry.self)
            CoreDataLoader.shared.get(entityType: ArfFt.self)
            CoreDataLoader.shared.get(entityType: ArfSeg.self)
            CoreDataLoader.shared.get(entityType: ArfAtc.self)
            CoreDataLoader.shared.get(entityType: ArfRmk.self)
            CoreDataLoader.shared.get(entityType: ArfPar.self)
            CoreDataLoader.shared.get(entityType: ArfSch.self)
            CoreDataLoader.shared.get(entityType: ArfPt.self)
            CoreDataLoader.shared.get(entityType: MtrOsm.self)
            CoreDataLoader.shared.get(entityType: Mtr.self)
            CoreDataLoader.shared.get(entityType: MtrOv.self)
            CoreDataLoader.shared.get(entityType: MtrRmk.self)
            CoreDataLoader.shared.get(entityType: MtrPar.self)
            CoreDataLoader.shared.get(entityType: SuasPar.self)
            CoreDataLoader.shared.get(entityType: Suas.self)
            CoreDataLoader.shared.get(entityType: SuasNote.self)
            CoreDataLoader.shared.get(entityType: SuasCtry.self)
            CoreDataLoader.shared.get(entityType: Ils.self)
            CoreDataLoader.shared.get(entityType: Rwy.self)
            CoreDataLoader.shared.get(entityType: ArptRmk.self)
            CoreDataLoader.shared.get(entityType: Acom.self)
            CoreDataLoader.shared.get(entityType: Arpt.self)
            CoreDataLoader.shared.get(entityType: AcomRmk.self)
            CoreDataLoader.shared.get(entityType: Anav.self)
            CoreDataLoader.shared.get(entityType: Agear.self)
            CoreDataLoader.shared.get(entityType: TrmRmk.self)
            CoreDataLoader.shared.get(entityType: TrmClb.self)
            CoreDataLoader.shared.get(entityType: TrmSeg.self)
            CoreDataLoader.shared.get(entityType: TrmMin.self)
            CoreDataLoader.shared.get(entityType: TrmMsa.self)
            CoreDataLoader.shared.get(entityType: TrmPar.self)
            CoreDataLoader.shared.get(entityType: TrmFdr.self)
            CoreDataLoader.shared.get(entityType: Pad.self)
            CoreDataLoader.shared.get(entityType: Hnav.self)
            CoreDataLoader.shared.get(entityType: HlptRmk.self)
            CoreDataLoader.shared.get(entityType: Hlpt.self)
            CoreDataLoader.shared.get(entityType: Hcom.self)
            CoreDataLoader.shared.get(entityType: HcomRmk.self)
            CoreDataLoader.shared.get(entityType: AppcSuasWx.self)
            CoreDataLoader.shared.get(entityType: AppcComSymbols.self)
            CoreDataLoader.shared.get(entityType: AppcPrAcftType.self)
            CoreDataLoader.shared.get(entityType: AppcNavType.self)
            CoreDataLoader.shared.get(entityType: AppcAbsorbingSys.self)
            CoreDataLoader.shared.get(entityType: AppcTrmTrackCd.self)
            CoreDataLoader.shared.get(entityType: AppcComType.self)
            CoreDataLoader.shared.get(entityType: AppcLevel.self)
            CoreDataLoader.shared.get(entityType: AppcFluids.self)
            CoreDataLoader.shared.get(entityType: AppcAtsWptDesc1.self)
            CoreDataLoader.shared.get(entityType: AppcIlsCat.self)
            CoreDataLoader.shared.get(entityType: AppcUsStateCodes.self)
            CoreDataLoader.shared.get(entityType: AppcAtsFreqClass.self)
            CoreDataLoader.shared.get(entityType: AppcTrmType.self)
            CoreDataLoader.shared.get(entityType: AppcFuelCodes.self)
            CoreDataLoader.shared.get(entityType: AppcAtsWptDesc2.self)
            CoreDataLoader.shared.get(entityType: AppcEngagingDev.self)
            CoreDataLoader.shared.get(entityType: AppcPrPtType.self)
            CoreDataLoader.shared.get(entityType: AppcTrmNavType.self)
            CoreDataLoader.shared.get(entityType: AppcCcIcao.self)
            CoreDataLoader.shared.get(entityType: AppcAtsWptDesc3.self)
            CoreDataLoader.shared.get(entityType: AppcMtrCrsAlt.self)
            CoreDataLoader.shared.get(entityType: AppcAtsStatus.self)
            CoreDataLoader.shared.get(entityType: AppcBdryType.self)
            CoreDataLoader.shared.get(entityType: AppcAtsWptDesc4.self)
            CoreDataLoader.shared.get(entityType: AppcHeliType.self)
            CoreDataLoader.shared.get(entityType: AppcMtrUsageCd.self)
            CoreDataLoader.shared.get(entityType: AppcWptType.self)
            CoreDataLoader.shared.get(entityType: AppcIlsCompType.self)
            CoreDataLoader.shared.get(entityType: AppcWptUsageCd.self)
            CoreDataLoader.shared.get(entityType: AppcOils.self)
            CoreDataLoader.shared.get(entityType: AppcArDir.self)
            CoreDataLoader.shared.get(entityType: AppcDerivation.self)
            CoreDataLoader.shared.get(entityType: AppcArUsageCd.self)
            CoreDataLoader.shared.get(entityType: AppcRwySfcCodes.self)
            CoreDataLoader.shared.get(entityType: AppcAtsType.self)
            CoreDataLoader.shared.get(entityType: AppcRwyLgtCodes.self)
            CoreDataLoader.shared.get(entityType: AppcNavStatus.self)
            CoreDataLoader.shared.get(entityType: AppcPjaType.self)
            CoreDataLoader.shared.get(entityType: AppcNavRcc.self)
            CoreDataLoader.shared.get(entityType: AppcOprAgcy.self)
            CoreDataLoader.shared.get(entityType: AppcArType.self)
            CoreDataLoader.shared.get(entityType: AppcTrmProc.self)
            CoreDataLoader.shared.get(entityType: AppcTrmWptDesc3.self)
            CoreDataLoader.shared.get(entityType: AppcTrmWptDesc2.self)
            CoreDataLoader.shared.get(entityType: AppcShape.self)
            CoreDataLoader.shared.get(entityType: AppcComFreqUnit.self)
            CoreDataLoader.shared.get(entityType: AppcTrmWptDesc1.self)
            CoreDataLoader.shared.get(entityType: AppcDaylightSav.self)
            CoreDataLoader.shared.get(entityType: AppcJasu.self)
            CoreDataLoader.shared.get(entityType: AppcArptType.self)
            CoreDataLoader.shared.get(entityType: AppcAcftCap.self)
            CoreDataLoader.shared.get(entityType: AppcPjaOprTime.self)
            CoreDataLoader.shared.get(entityType: AppcTrmWptDesc4.self)
            CoreDataLoader.shared.get(entityType: AppcNavUsageCd.self)
            CoreDataLoader.shared.get(entityType: AppcLclHorizDatums.self)
            CoreDataLoader.shared.get(entityType: AppcIlsColctn.self)
            CoreDataLoader.shared.get(entityType: AppcAltitudeDesc.self)
            CoreDataLoader.shared.get(entityType: AppcSuasType.self)
            CoreDataLoader.shared.get(entityType: Pr.self)
            CoreDataLoader.shared.get(entityType: PrPar.self)
            CoreDataLoader.shared.get(entityType: Wpt.self)
            CoreDataLoader.shared.get(entityType: Papp.self)
            CoreDataLoader.shared.get(entityType: Nav.self)
            CoreDataLoader.shared.get(entityType: Bdry.self)
            CoreDataLoader.shared.get(entityType: BdryCtry.self)
            CoreDataLoader.shared.get(entityType: BdryPar.self)
            CoreDataLoader.shared.get(entityType: AtsRmk.self)
            CoreDataLoader.shared.get(entityType: AtsCtry.self)
            CoreDataLoader.shared.get(entityType: Ats.self)
            CoreDataLoader.shared.get(entityType: TzPar.self)
            CoreDataLoader.shared.get(entityType: Tz.self)
            CoreDataLoader.shared.get(entityType: Hold.self)
            CoreDataLoader.shared.get(entityType: Fueloil.self)
            CoreDataLoader.shared.get(entityType: SvcRmk.self)
            CoreDataLoader.shared.get(entityType: AddRwy.self)
            CoreDataLoader.shared.get(entityType: Gen.self)
        })
    }
    
    
}
