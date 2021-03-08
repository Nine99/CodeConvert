//
//  main_CmdFuncs+Enum.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/08.
//

import Foundation
import NiSConsole

var cmdNodes_Enum: [NiCmdNode] = [
    NiCmdNode("TOSTRING",         fnCmd_Enum_ToString,            desc: "" ),
    NiCmdNode("TOINT",            fnCmd_Enum_ToInt,             desc: "" ),
    NiCmdNode("TOENUM",           fnCmd_Enum_ToEnum,             desc: "" )
]

var cmdExecutor_Enum: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Enum( cmd: [String] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Enum.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))
    
    var _ = cmdExecutor_Enum.AddCmd(_nodes: cmdNodes_Enum)

    fwCon.CommandLoop(cmdExecutor: cmdExecutor_Enum)
    
    return ._OK
}

func fnCmd_Enum_ToEnum(cmd: [String]) -> _ACTION_RESULT {

    return ._OK
}

func fnCmd_Enum_ToInt(cmd: [String]) -> _ACTION_RESULT {

    return ._OK
}

func fnCmd_Enum_ToString(cmd: [String]) -> _ACTION_RESULT {
    Logger?.Log( testEnum.aaa.rawValue )
    return ._OK
}

enum testEnum : String {
    case aaa = "aaa"
    case bbb, ccc, ddd, eee, fff
}
