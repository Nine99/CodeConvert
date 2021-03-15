//
//  main_CmdFuncs+Json.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/15.
//

import Foundation
import NiSConsole

var cmdNodes_Json: [NiCmdNode] = [
    NiCmdNode("SIMPLE",             fnCmd_Json_SimpleType,            desc: "Codable Test for Simple Class" ),
    NiCmdNode("DICTIONARY",         fnCmd_Json_Dictionary,            desc: "Codable Test for Dictionary" )
]

var cmdExecutor_Json: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Json( cmd: [String?] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Json.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))
    
    var _ = cmdExecutor_Json.AddCmd(_nodes: cmdNodes_Json)
    
    fwCon.CommandLoop(cmdExecutor_Json, levelStr: cmd[0]!)
    
    return ._OK
}

func fnCmd_Json_SimpleType( cmd: [String?] ) -> _ACTION_RESULT {
    let sPacket = simplePacket(tag: "TAG", msg: "This is Message.")
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let spData = try? encoder.encode(sPacket)

    let spJson = String(data: spData!, encoding: .utf8)
    Logger?.Log( spJson! )

    let spTarget = try? decoder.decode(simplePacket.self, from: spData!)
    Logger?.Log( "\(spTarget!.tag!) : \(spTarget!.msg!)")

    return ._OK
}

func fnCmd_Json_Dictionary( cmd: [String?] ) -> _ACTION_RESULT {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
//    for (key, value) in testDic {
//        Logger?.Log(format: "%@ : %@", key, "\(value ?? "Value not Exist.")")
//    }
    
    let encodedDic = testDic.toJson()
    Logger?.Log(encodedDic ?? "Cannot Encode to JSON.")
    
    if let data = encodedDic!.data(using: .utf8) {
        //let dicObject = try? decoder.decode(type(of: Dictionary<String,Any?>), from: data)
        
        if let decodedJson = try? JSONSerialization.jsonObject(with: data, options:  .allowFragments) as? [String:Any] {
            for( key, value) in decodedJson {
                Logger?.Log("> " + key + ": \(value)")
            }
        }
        else {
            Logger?.Log("Encoding Error!")
        }
    }
    
    

    return ._OK
}

var testDic: Dictionary<String, Any?> = [
    "A": "1 as String",
    "B": 2,
    "C": 3.0
]
