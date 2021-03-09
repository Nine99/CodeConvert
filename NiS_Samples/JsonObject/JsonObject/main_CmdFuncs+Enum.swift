//
//  main_CmdFuncs+Enum.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/08.
//

import Foundation
import NiSConsole

enum testEnum : String, CaseIterable {
    case AAA = "AAA", BBB, CCC, DDD, EEE, FFF
}

extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}

let fns: [() -> Void] = [
    aaa, bbb, ccc, ddd, eee, fff
]

func fnCmd_Enum( cmd: [String?] ) -> _ACTION_RESULT {
    guard let eStr = cmd[1] else { return ._INVALIED_CMD }
    
    Logger?.Log(eStr)
    guard let eid = testEnum(rawValue: eStr) else { return ._INVALIED_ARGUMENT }
    Logger?.Log("\(eid.index!) : \(eid)")
    fns[eid.index!]()
    
    return ._OK
}


func aaa() { Logger?.Log( "fn aaa()" ) }
func bbb() { Logger?.Log( "fn bbb()" ) }
func ccc() { Logger?.Log( "fn ccc()" ) }
func ddd() { Logger?.Log( "fn ddd()" ) }
func eee() { Logger?.Log( "fn eee()" ) }
func fff() { Logger?.Log( "fn fff()" ) }
