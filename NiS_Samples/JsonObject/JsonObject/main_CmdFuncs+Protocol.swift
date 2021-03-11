//
//  main_CmdFuncs+Protocol.swift
//  JsonObject
//
//  Created by nine99p on 2021/03/10.
//

import Foundation
import NiSConsole

var cmdNodes_Protocol: [NiCmdNode] = [
    NiCmdNode("INIT",               fnCmd_Protocol_Init,            desc: "" ),
    NiCmdNode("CALL",               fnCmd_Protocol_Call,            desc: "" ),
    NiCmdNode("ADD",                fnCmd_Protocol_Add,             desc: "" )
]

var cmdExecutor_Protocol: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Protocol( cmd: [String?] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Protocol.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        mgrHier = nil
        
        return ._EXIT
    }))
    
    var _ = cmdExecutor_Protocol.AddCmd(_nodes: cmdNodes_Protocol)
    
    mgrHier = HManager()
    
    mgrHier?.AddClassType(type: ._HYBRID, fn: C2Hybrid.Create(_:))
    mgrHier?.AddClassType(type: ._NATIVE, fn: C2Native.Create(_:))
    
    fwCon.CommandLoop(cmdExecutor_Protocol, levelStr: cmd[0]!)
    
    return ._OK
}

func fnCmd_Protocol_Init(cmd: [String?]) -> _ACTION_RESULT {
    
    return ._OK
}

func fnCmd_Protocol_Add(cmd: [String?]) -> _ACTION_RESULT {
    guard let type:_C_TYPE = _C_TYPE(rawValue: cmd[1]!) else {
        return ._INVALIED_ARGUMENT
    }
    
    let prtcl = mgrHier?.Create("NewClass", type: type)
    switch prtcl?.classType {
    case ._HYBRID:
        let obj = prtcl?.vClass as! VHybrid
        obj.hName = "Hybrid Class"
        Logger?.Log(obj.hName!)
        break
        
    case ._NATIVE:
        let obj = prtcl?.vClass as! VNative
        obj.nName = "Native Class"
        Logger?.Log(obj.nName!)
        break
        
    default:
        break
    }
    
    Logger?.Log( "\(prtcl!.self)" )
    
    return ._OK
}

func fnCmd_Protocol_Call(cmd: [String?]) -> _ACTION_RESULT {
    guard let type:_C_TYPE = _C_TYPE(rawValue: cmd[1]!) else {
        return ._INVALIED_ARGUMENT
    }

    let prtcl = C2Common("Test Class", type: type )
    switch type {
    case ._NATIVE:
        let cls: VNative = prtcl.getVClass()
        cls.nName = "Native Class String"
        Logger?.Log(cls.nName!)
        break
    case ._HYBRID:
        let cls: VHybrid = prtcl.getVClass()
        cls.hName = "Hybrid Class String"
        Logger?.Log(cls.hName!)
        break
    }
    
    return ._OK
}

