//
//  Sample_Hierarchy.swift
//  JsonObject
//
//  Created by nine99p on 2021/03/10.
//

import Foundation

enum _C_TYPE : String {
    case _NATIVE = "_NATIVE", _HYBRID
}

class SC0 {

}

class C1A : SC0 {
    
}

class C1B : SC0 {
    
}

protocol P0 {
    func Create()
}

class C2Native : C1A, P0 {
    func Create() {
        Logger?.Log( "Create Native")
    }
    
    
    
}

class C2Hybrid : C1B, P0 {
    func Create() {
        Logger?.Log( "Create Hybrid")
    }
    
}

protocol P2Delegate: class {
    var createDelegator: SC0? { get set }
    
    func CreateByType(cID: String, type: _C_TYPE)
}

class HManager: P2Delegate {
    var createDelegator: SC0?

    func CreateByType(cID: String, type: _C_TYPE) {
        switch type {
            case ._NATIVE:
                let cc = C2Native()
                cc.Create()
                break
            case ._HYBRID:
                let cc = C2Hybrid()
                cc.Create()
                break
        }
    }
}

var mgrHier: HManager?


