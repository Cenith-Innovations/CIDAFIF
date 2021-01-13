// ********************** File *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** File *********************************


import Foundation
import CoreData

extension Arpt {

    public class func getAllAirports() -> [Arpt]? {
        do {
            return try moc.fetch(NSFetchRequest<Arpt>(entityName: "Arpt"))
        } catch {
            return nil
        }
    }
    
    public class func getArptWithId(id: String) -> Arpt? {
        let fetchRequest = NSFetchRequest<Arpt>(entityName: "Arpt")
        let arptPredicate = NSPredicate(format: "%K = %@", #keyPath(Arpt.arptIdent) , id)
        fetchRequest.predicate = arptPredicate
        do {
            return try moc.fetch(fetchRequest).first
        } catch {
            print(error)
            return nil
        }
    }
    
    public class func getArptWithICAO(icao: String) -> Arpt? {
        let fetchRequest = NSFetchRequest<Arpt>(entityName: "Arpt")
        let arptPredicate = NSPredicate(format: "%K = %@", #keyPath(Arpt.icao) , icao.uppercased())
        fetchRequest.predicate = arptPredicate
        do {
            return try moc.fetch(fetchRequest).first
        } catch {
            print(error)
            return nil
        }
    }
}

extension Nav {
        
    public class func getWithAirport(icao: String) -> [Nav]? {
        let fetchRequest = NSFetchRequest<Nav>(entityName: "Nav")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Nav.arptIcao) , icao.uppercased())
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Rwy {
    class func getWithAirPortId(id: String) -> [Rwy]? {
        
        let fetchRequest = NSFetchRequest<Rwy>(entityName: "Rwy")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Rwy.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
    
    class func getWithAirPortIdAndMinRunwayLength(id: String, rwyL: Int16) -> [Rwy] {
        var newResult: [Rwy] = []
        
        let CDFetchRequest = NSFetchRequest<Rwy>(entityName: "Rwy")
        do {
            let result = try moc.fetch(CDFetchRequest).filter { $0.length >= rwyL }
            newResult = result.filter({$0.arptIdent == id})
        } catch {
            print(error)
        }
        return newResult
    }
}

public extension AddRwy {
    class func getWithAirPortId(id: String) -> [AddRwy]? {
        
        let fetchRequest = NSFetchRequest<AddRwy>(entityName: "AddRwy")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(AddRwy.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension TrmSeg {
    class func getWithAirPortId(id: String) -> [TrmSeg]? {
        
        let fetchRequest = NSFetchRequest<TrmSeg>(entityName: "TrmSeg")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(TrmSeg.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension TrmRmk {
    class func getWithAirPortId(id: String) -> [TrmRmk]? {
    
    let fetchRequest = NSFetchRequest<TrmRmk>(entityName: "TrmRmk")
    let predicate = NSPredicate(format: "%K = %@", #keyPath(TrmRmk.arptIdent) , id)
    fetchRequest.predicate = predicate
    do {
        return try moc.fetch(fetchRequest)
    } catch {
        print(error)
        return nil
    }}
}

public extension TrmPar {
    class func getWithAirPortId(id: String) -> [TrmPar]? {
        
        let fetchRequest = NSFetchRequest<TrmPar>(entityName: "TrmPar")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(TrmPar.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension TrmClb {
    class func getWithAirPortId(id: String) -> [TrmClb]? {
        
        let fetchRequest = NSFetchRequest<TrmClb>(entityName: "TrmClb")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(TrmClb.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension TrmMsa {
    class func getWithAirPortId(id: String) -> [TrmMsa]? {
        
        let fetchRequest = NSFetchRequest<TrmMsa>(entityName: "TrmMsa")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(TrmMsa.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension TrmMin {
    class func getWithAirPortId(id: String) -> [TrmMin]? {
        
        let fetchRequest = NSFetchRequest<TrmMin>(entityName: "TrmMin")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(TrmMin.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension SvcRmk {
    class func getWithAirPortId(id: String) -> [SvcRmk]? {
        
        let fetchRequest = NSFetchRequest<SvcRmk>(entityName: "SvcRmk")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(SvcRmk.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Anav {
    class func getWithAirPortId(id: String) -> [Anav]? {
        
        let fetchRequest = NSFetchRequest<Anav>(entityName: "Anav")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Anav.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Acom {
    class func getWithAirPortId(id: String) -> [Acom]? {
        
        let fetchRequest = NSFetchRequest<Acom>(entityName: "Acom")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Acom.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension AcomRmk {
    class func getWithAirPortId(id: String) -> [AcomRmk]? {
        
        let fetchRequest = NSFetchRequest<AcomRmk>(entityName: "AcomRmk")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(AcomRmk.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Gen {
    class func getWithAirPortId(id: String) -> [Gen]? {
        
        let fetchRequest = NSFetchRequest<Gen>(entityName: "Gen")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Gen.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Fueloil {
    class func getWithAirPortId(id: String) -> [Fueloil]? {
        
        let fetchRequest = NSFetchRequest<Fueloil>(entityName: "Fueloil")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Fueloil.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Ils {
    class func getWithAirPortId(id: String) -> [Ils]? {
        
        let fetchRequest = NSFetchRequest<Ils>(entityName: "Ils")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Ils.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Agear {
    class func getWithAirPortId(id: String) -> [Agear]? {
        
        let fetchRequest = NSFetchRequest<Agear>(entityName: "Agear")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Agear.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension ArptRmk {
    class func getWithAirPortId(id: String) -> [ArptRmk]? {
        
        let fetchRequest = NSFetchRequest<ArptRmk>(entityName: "ArptRmk")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(ArptRmk.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

public extension Papp {
    class func getWithAirPortId(id: String) -> [Papp]? {
        
        let fetchRequest = NSFetchRequest<Papp>(entityName: "Papp")
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Papp.arptIdent) , id)
        fetchRequest.predicate = predicate
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }}
}

