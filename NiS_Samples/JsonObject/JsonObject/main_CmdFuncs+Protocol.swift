//
//  main_CmdFuncs+Protocol.swift
//  JsonObject
//
//  Created by nine99p on 2021/03/10.
//

import Foundation
import NiSConsole

var cmdNodes_Protocol: [NiCmdNode] = [
    NiCmdNode("CALL",             fnCmd_Protocol_Call,            desc: "" ),
    NiCmdNode("ADD",              fnCmd_Protocol_Add,             desc: "" )
]

var cmdExecutor_Protocol: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Protocol( cmd: [String?] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Protocol.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))
    
    var _ = cmdExecutor_Protocol.AddCmd(_nodes: cmdNodes_Protocol)
    
    mgrHier = HManager()
    
    fwCon.CommandLoop(cmdExecutor_Protocol, levelStr: cmd[0]!)
    
    return ._OK
}

func fnCmd_Protocol_Add(cmd: [String?]) -> _ACTION_RESULT {
    guard let type:_C_TYPE = _C_TYPE(rawValue: cmd[1]!) else {
        return ._INVALIED_ARGUMENT
    }
    
    mgrHier?.CreateByType(cID: "NewClass", type: type)
    
    return ._OK
}

func fnCmd_Protocol_Call(cmd: [String?]) -> _ACTION_RESULT {

    
    return ._OK
}

