//
//  main_CmdFuncs+Stack.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/08.
//

import Foundation
import NiSConsole

var cmdNodes_Stack: [NiCmdNode] = [
    NiCmdNode("ADD",            fnCmd_Stack_Add,            desc: "" ),
    NiCmdNode("CLEAR",          fnCmd_Stack_Clear,          desc: "" )
]

var cmdExecutor_Stack: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Stack( cmd: [String?] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Stack.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))

    var _ = cmdExecutor_Stack.AddCmd(_nodes: cmdNodes_Stack)
    
    fwCon.CommandLoop(cmdExecutor_Stack, levelStr: cmd[0]!)
    
    return ._OK
}

func fnCmd_Stack_Add(cmd: [String?]) -> _ACTION_RESULT {
    stackAdd()
    return ._OK
}

func fnCmd_Stack_Search(cmd: [String?]) -> _ACTION_RESULT {
    return ._OK
}

func fnCmd_Stack_Clear(cmd: [String?]) -> _ACTION_RESULT {
    return ._OK
}

func fnCmd_MakeStack( cmd: [String?]) -> _ACTION_RESULT {
    stackAdd()
    stackAddPacket(node: simplePacket(tag: "S01", msg: "L1 1st Packet"))
    stackAddPacket(node: simplePacket(tag: "S02", msg: "L1 2nd Packet"))
    stackAddPacket(node: simplePacket(tag: "S03", msg: "L1 3rd Packet"))
    stackAddPacket(node: simplePacket(tag: "S04", msg: "L1 4th Packet"))
    stackAddPacket(node: simplePacket(tag: "S05", msg: "L1 5th Packet"))
    stackAdd()
    stackAddPacket(node: simplePacket(tag: "S11", msg: "L2 1st Packet"))
    stackAddPacket(node: simplePacket(tag: "S12", msg: "L2 2nd Packet"))
    stackAddPacket(node: simplePacket(tag: "S13", msg: "L2 3rd Packet"))
    stackAddPacket(node: simplePacket(tag: "S14", msg: "L2 4th Packet"))
    stackAddPacket(node: simplePacket(tag: "S15", msg: "L2 5th Packet"))
    stackAdd()
    stackAddPacket(node: simplePacket(tag: "S21", msg: "L3 1st Packet"))
    stackAddPacket(node: simplePacket(tag: "S22", msg: "L3 2nd Packet"))
    stackAddPacket(node: simplePacket(tag: "S23", msg: "L3 3rd Packet"))
    stackAddPacket(node: simplePacket(tag: "S24", msg: "L3 4th Packet"))
    stackAddPacket(node: simplePacket(tag: "S25", msg: "L3 5th Packet"))

    stackSearch(tag: "S13")
    
    return ._OK
}
