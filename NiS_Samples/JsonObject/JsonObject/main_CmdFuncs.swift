//
//  main_CmdFuncs.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation
import NiSConsole

var testDic: Dictionary<String, Any?> = [
    "A": "1 as String",
    "B": 2,
    "C": 3.0
]

// "DICTIONARY"
func fnCmd_Dictionary(cmd: [String?]) -> _ACTION_RESULT {
    for (key, value) in testDic {
        Logger?.Log(format: "%@ : %@", key, "\(value ?? "Value not Exist.")")
    }

    let encodedDic = testDic.toJson()
    Logger?.Log(encodedDic ?? "Cannot Encode to JSON.")

    if let data = encodedDic!.data(using: .utf8) {
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

// "SIMPLE"
func fnCmd_SimpleClass(cmd: [String?]) -> _ACTION_RESULT {
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

// "VIEWINFO"
func fnCmd_AliothViewInfo(cmd: [String?]) -> _ACTION_RESULT {
    let vi = AliothViewInfo(viewId: "TestView", params: testDic.toJson(), results: "Ok")

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let viData = try? encoder.encode(vi)

    let viJson = String(data: viData!, encoding: .utf8)
    Logger?.Log( viJson! )

    let viTarget = try? decoder.decode(AliothViewInfo.self, from: viData!)
    
    Logger?.Log( "\(viTarget!.uniqueKey!), \(viTarget!.parameters!)")
    
    return ._OK

}

typealias packetStack = NiSStack<simplePacket>

var stackedStack = NiSStack<packetStack>()

func stackAdd()
{
    let stack = NiSStack<simplePacket>()
 
    stackedStack.push(_element: stack)
}

func stackAddPacket(node: simplePacket)
{
    guard var lastStack = stackedStack.pop() else {
        Logger?.Log("Push Error")
        return
    }
    
    // 뺐다가 넣어야 함. Struct 라서 그런가?
    lastStack.push(_element: node)
    stackedStack.push(_element: lastStack)
}

func stackSearch(tag: String!)
{
    while stackedStack.Count > 0 {
        var packetStack = stackedStack.peek()
        
        while packetStack!.Count > 0 {
            Logger?.Begin(tag: "Packet Stack")
            let packet = packetStack!.peek()
            Logger?.Log( "Pop \(packet!.tag!), \(packet!.msg!)[View Stack Count : \(stackedStack.Count), Packet Stack Count : \(packetStack!.Count)]")
            if tag! == packet!.tag! {
                Logger?.Log( "Found" )
                return
            }
            _ = packetStack!.pop()
            Logger?.End()
        }
        
        _ = stackedStack.pop()
        Logger?.Log( "Pop StackedStack." )
    }
}

