//
//  main_CmdFuncs.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation
import NiSConsole


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
 
    stackedStack.push(stack)
}

func stackAddPacket(node: simplePacket)
{
    guard var lastStack = stackedStack.pop() else {
        Logger?.Log("Push Error")
        return
    }
    
    // 뺐다가 넣어야 함. Struct 라서 그런가?
    lastStack.push(node)
    stackedStack.push(lastStack)
}

func stackSearch(tag: String!)
{
    while stackedStack.Count > 0 {
        var packetStack = stackedStack.peek()
        
        while packetStack!.Count > 0 {
            Logger?.Begin("Packet Stack")
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

