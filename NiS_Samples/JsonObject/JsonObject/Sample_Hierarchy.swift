//
//  Sample_Hierarchy.swift
//  JsonObject
//
//  Created by nine99p on 2021/03/10.
//

import Foundation
import NiSConsole

enum _C_TYPE : String {
    case _NATIVE = "_NATIVE", _HYBRID
}

class SC0 {

}

class C1A : SC0 {
    
}

class C1B : SC0 {
    
}

class VNative {
    var nName: String?
}

class VHybrid {
    var hName: String?
}

protocol P0 {
    var classID: String? { get set }
    var vClass: AnyObject? { get set }
    
    var classType: _C_TYPE { get set }
    static func Create(_ cID: String) -> P0
}

extension P0 {
    func getVClass<T>() -> T {
        return vClass as! T
    }
}

class C2Native : C1A, P0 {
    var classID: String?
    
    var vClass: AnyObject?
    
    var classType: _C_TYPE = ._NATIVE
    
    static func Create(_ cID: String) -> P0 {
        Logger?.Log( "Create Native")
        let cobj = C2Native()
        cobj.classID = cID
        cobj.vClass = VNative() as AnyObject
        
        return cobj
    }
}

class C2Hybrid : C1B, P0 {
    var classID: String?
    
    var vClass: AnyObject?
    
    var classType: _C_TYPE = ._HYBRID
    
    static func Create(_ cID: String) -> P0 {
        Logger?.Log( "Create Hybrid")
        let cobj = C2Hybrid()
        cobj.classID = cID
        cobj.vClass = VHybrid() as AnyObject
        
        return cobj
    }
    
}

class C2Common: SC0, P0 {
    var classID: String?
    
    var vClass: AnyObject?
    
    var classType: _C_TYPE
    
    static func Create(_ cID: String) -> P0 {
        return C2Common(cID, type: ._NATIVE)
    }
    
    init(_ cID: String?, type: _C_TYPE) {
        self.classID = cID
        self.classType = type
        switch self.classType {
        case ._NATIVE:
            self.vClass = VNative() as AnyObject
            break;
            
        case ._HYBRID:
            self.vClass = VHybrid() as AnyObject
            break;
        }
    }
    
//    func getVClass<T>() -> T {
//        return vClass as! T
//    }
}

typealias fnClassCreator = (String) -> P0

protocol P2Delegate: class {
    var createDelegator: SC0? { get set }
    
    var fnCreate : Dictionary<_C_TYPE, fnClassCreator>? { get set }
}

extension P2Delegate {
    
    func Create(_ cID: String, type:_C_TYPE) -> P0 {
        return fnCreate![type]!(cID)
    }
}

class HManager: P2Delegate {
    var fnCreate: Dictionary<_C_TYPE, fnClassCreator>? = Dictionary<_C_TYPE, fnClassCreator>()
    
    var createDelegator: SC0?

    func AddClassType(type: _C_TYPE, fn: @escaping fnClassCreator)
    {
        fnCreate!.updateValue(fn, forKey: type)
    }
    
}

var mgrHier: HManager?


