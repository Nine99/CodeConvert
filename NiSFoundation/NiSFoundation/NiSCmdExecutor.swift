//
//  cmdExecutor.swift
//  testSwiftConsole
//
//  Created by nine99p on 2020/12/17.
//

import Foundation

public typealias fnAction = ([String]) -> Void

protocol NipCmdNode{
    var id : String { get set }
    var desc : String { get set }
    var fnCmdAction : fnAction { get set }
    
    init(_ _id:String, _ _fn:@escaping fnAction, _desc:String)
}

public struct NiCmdNode : NipCmdNode
{
    public var id : String
    public var desc : String
    public var fnCmdAction : fnAction
    
    public init(_ _id:String, _ _fn:@escaping fnAction, _desc:String = "")
    {
        id = _id
        desc = _desc
        fnCmdAction = _fn
    }
}

class NiCmdExecuter<T:NipCmdNode>
{
    private var cmdNodes : Dictionary = [String:T]()
    
    init()
    {
        _ = AddCmd( _node: T.init("HELP", fnCmd_Help, _desc: "Print Help Message") )
    }
    
    func AddCmd(_node:T) -> Bool
    {
        cmdNodes.updateValue(_node, forKey: _node.id)
        
        return true
    }
    
    func AddCmd(_nodes:[T]) -> Bool
    {
        for arr_index in 0..<_nodes.count
        {
            let cmd_node = _nodes[arr_index]
            let res = AddCmd(_node:cmd_node)
            if false == res
            {
                NiSLogger.Instance().Log( "[\(cmd_node.id)] Command Aready Exist." )
            }
        }
        
        return true
    }
    
    func ExecuteCmd(_id:String, _args:[String]) -> Bool
    {
        let node = cmdNodes[_id]
        if node == nil {
            return false
        }
        node?.fnCmdAction(_args)
        
        return true
    }
    
    func fnCmd_Help(args:[String])
    {
        for (key, value) in cmdNodes
        {
            print(String(repeating: " ", count : 16-key.count), terminator:"")
            print(String(format: "%@%@ %@: %@",
                         NiColor.Yellow.rawValue, key,
                         NiColor.White.rawValue, value.desc ))
        }
    }

}
