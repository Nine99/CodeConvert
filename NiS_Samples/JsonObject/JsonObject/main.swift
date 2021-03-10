//
//  main.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/03.
//

import Foundation
import NiSConsole

let Logger : NiSLogger? = NiSLogger.Instance()


var cmdNodes : [NiCmdNode] = [
    NiCmdNode("SIMPLE",         fnCmd_SimpleClass,          desc: "Codable Test for Simple Class"),
    NiCmdNode("VIEWINFO",       fnCmd_AliothViewInfo,       desc: "Codable Test for AliothViewInfo(Complex)"),
    NiCmdNode("DICTIONARY",     fnCmd_Dictionary,           desc: "Load File by Binary."),
    
    NiCmdNode("STACK",          fnCmd_Stack,                desc: "Make Stack & Test"),
    NiCmdNode("TYPENAME",       fnCmd_TypeName,             desc: "" ),
    NiCmdNode("ENUM",           fnCmd_Enum,                 desc: "" ),
    NiCmdNode("SELECTOR",       fnCmd_Selector,             desc: "" ),
    NiCmdNode("PROTOCOL",       fnCmd_Protocol,             desc: "" ),
    
    NiCmdNode("ACTION1",        { _ -> _ACTION_RESULT in
        Logger?.Log(color: NiColor.LightBlue, "Action 1.")
        Logger?.Log(color: NiColor.White, "Second Line.")
        return ._OK
    }, desc: "Action 001"),
    NiCmdNode.init("ACTION2", { (args) -> _ACTION_RESULT in
        args.count > 1 ? Logger?.Log(color: NiColor.Blue, args[1]! ) : Logger?.Log(color: NiColor.Red, "No Argument")
        return ._OK
    }, desc: "Action 002" )
]

var fwCon = NiSConsoleFW( { _ in
    Logger?.Log("On Command Exit.")
    return ._EXIT
} )

if false == fwCon.AddCmd(_nodes: cmdNodes) {
    exit(0)
}

fwCon.CommandLoop()


