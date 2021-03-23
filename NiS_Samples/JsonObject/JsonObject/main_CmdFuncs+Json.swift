//
//  main_CmdFuncs+Json.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/15.
//

import Foundation
import NiSConsole

var cmdNodes_Json: [NiCmdNode] = [
    NiCmdNode("SIMPLE",             fnCmd_Json_SimpleType,          desc: "Codable Test for Simple Class" ),
    NiCmdNode("DICTIONARY",         fnCmd_Json_Dictionary,          desc: "Codable Test for Dictionary" ),
    NiCmdNode("STORAGE",            fnCmd_Json_Storage,             desc: "Storage Test" ),
    NiCmdNode("NESTED",             fnCmd_Json_NestedDictionary,    desc: "")
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

func fnCmd_Json_NestedDictionary( cmd: [String?] ) -> _ACTION_RESULT {
    Logger?.Begin()
    
    let encodedDic = testDic.toJson()
    Logger?.Log(encodedDic ?? "Cannot Encode to JSON.")
    
//    let jsonTestObject = encodedDic! as! [String:Any]
//    for (k, v) in jsonTestObject {
//        Logger?.Log( "\(k): \(v)")
//    }
    
    var nested = testDic["D"] as! [String:Any]
    Logger?.Log( nested.toJson()! )
    
    let nestedObject = testDic["D"] as! [String:Any]
    for (k, v) in nestedObject {
        Logger?.Log( "\(k): \(v)")
    }
    
    Logger?.End()

    return ._OK
}

func fnCmd_Json_Storage( cmd: [String?] ) -> _ACTION_RESULT {
    
    testDic.forEach({
        key, value in NiSGlobalStorage.set(key: key, value: value)
    })
    
    Logger?.Log( NiSGlobalStorage.toString() )
    
    let bnum: NSNumber = NiSGlobalStorage.get("B")
    let cnum: NSNumber = NiSGlobalStorage.get("C")
    
    let fnum = Float(truncating: bnum) + Float(truncating: cnum)
    let inum = Int(truncating: bnum) + Int(truncating: cnum)
    Logger?.Log( "\(bnum) + \(cnum) = \(fnum)[\(inum)]" )
    
    let dic: pairStringAny = NiSGlobalStorage.get("D")
    
    Logger?.Log( dic.toJson()! )
    
    let arr: [Any] = NiSGlobalStorage.get("E")
    arr.forEach({
        component in Logger?.Log("\(component)")
    })
    
    storageTestDic.forEach({
        key, value in NiSSessionStorage.set(key: key, value: value)
    })
    
    Logger?.Log( NiSSessionStorage.toString())
    
    return ._OK
}

var testDic: Dictionary<String, Any> = [
    "A": "1 as String",
    "B": 2,
    "C": 3.14,
    "D": ["aa": 0, "bb": "String", "cc": 0],
    "E": ["aa", "bb", "cc", "dd"]
]

var storageTestDic: pairStringAny = [
    "한글로": "함 해보자",
    "그래": "그래보자"
]

//class jsonTestClass : Codable {
//    var A: String!
//    var B: Int!
//    var C: Double!
//    var D: [String:Any]?
//
//    enum CodingKeys : String, CodingKey {
//        case A, B, C
//        case D
//    }
//}
