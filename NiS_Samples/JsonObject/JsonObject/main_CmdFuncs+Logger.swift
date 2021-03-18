//
//  main_CmdFuncs.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation
import NiSConsole

var cmdNodes_Logger: [NiCmdNode] = [
    NiCmdNode("INDENT",             fnCmd_Logger_Indent,        desc: "Codable Test for Simple Class" ),
    NiCmdNode("LOG",                fnCmd_Logger_Log,           desc: "Codable Test for Simple Class" )
]

var cmdExecutor_Logger: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Logger( cmd: [String?] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Logger.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))
    
    var _ = cmdExecutor_Logger.AddCmd(_nodes: cmdNodes_Logger)
    
    fwCon.CommandLoop(cmdExecutor_Logger, levelStr: cmd[0]!)
    
    return ._OK
}

func fnCmd_Logger_Indent( cmd: [String?] ) -> _ACTION_RESULT {
    if cmd.count < 2 {
        return ._INVALIED_ARGUMENT
    }
    guard let direction = cmd[1] else {
        Logger?.Log(.ERROR, "Syntex Error.")
        return ._INVALIED_ARGUMENT
    }
    
    switch direction {
    case "+":
        Logger?.Begin()
    case "-":
        Logger?.End()
    default:
        Logger?.Log(.ERROR, "Syntex Error.")
        return ._INVALIED_ARGUMENT
    }
    
    return ._OK
}

func fnCmd_Logger_Log( cmd: [String?] ) -> _ACTION_RESULT {
    if cmd.count < 2 {
        return ._INVALIED_ARGUMENT
    }
    guard let text = cmd[1] else {
        return ._INVALIED_ARGUMENT
    }
    Logger?.Log(text)
    
    return ._OK
}
