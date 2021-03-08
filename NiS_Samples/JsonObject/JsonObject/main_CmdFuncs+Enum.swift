//
//  main_CmdFuncs+Enum.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/08.
//

import Foundation
import NiSConsole

enum testEnum : Int {
    case aaa, bbb, ccc, ddd, eee, fff
    
    static let mapper: [testEnum: String] = [
        .aaa: "aaa",
        .bbb: "bbb",
        .ccc: "ccc",
        .ddd: "ddd",
        .eee: "eee",
        .fff: "fff"
    ]
    var toString: String {
        return testEnum.mapper[self]!
    }
}

var cmdNodes_Enum: [NiCmdNode] = [
    NiCmdNode("TOSTRING",         fnCmd_Enum_ToString,          desc: "" ),
    NiCmdNode("TOINT",            fnCmd_Enum_ToInt,             desc: "" ),
    NiCmdNode("TOENUM",           fnCmd_Enum_ToEnum,            desc: "" )
]

var cmdExecutor_Enum: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Enum( cmd: [String] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Enum.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))
    
    var _ = cmdExecutor_Enum.AddCmd(_nodes: cmdNodes_Enum)

    fwCon.CommandLoop(cmdExecutor_Enum, levelStr: cmd[0])
    
    return ._OK
}

func fnCmd_Enum_ToEnum(cmd: [String]) -> _ACTION_RESULT {
    
    return ._OK
}

func fnCmd_Enum_ToInt(cmd: [String]) -> _ACTION_RESULT {
    let index: Int = testEnum.ccc.rawValue
    Logger?.Log( "\(index)" )
    
    return ._OK
}

func fnCmd_Enum_ToString(cmd: [String]) -> _ACTION_RESULT {
    Logger?.Log( testEnum.aaa.toString )
    
    return ._OK
}

