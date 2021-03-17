//
//  cmdExecutor.swift
//  testSwiftConsole
//
//  Created by nine99p on 2020/12/17.
//

import Foundation

public enum _ACTION_RESULT {
    case _OK, _INVALIED_CMD, _INVALIED_ARGUMENT, _EXIT, _HELP
}

public typealias fnAction = ([String?]) -> _ACTION_RESULT

public protocol NipCmdNode{
    var id : String { get set }
    var desc : String { get set }
    var fnCmdAction : fnAction { get set }
    
    init(_ id:String, _ fn:@escaping fnAction, desc:String)
}

public struct NiCmdNode : NipCmdNode
{
    public var id : String
    public var desc : String
    public var fnCmdAction : fnAction
    
    public init(_ id:String, _ fn:@escaping fnAction, desc:String = "")
    {
        self.id = id
        self.desc = desc
        self.fnCmdAction = fn
    }
}

public class NiSCmdExecutor<T:NipCmdNode>
{
    private var cmdNodes : Dictionary = [String:T]()
    
    public init()
    {
        _ = AddCmd( _node: T.init("HELP", fnCmd_Help, desc: "Print Help Message") )
    }
    
    public func AddCmd(_node:T) -> Bool
    {
        cmdNodes.updateValue(_node, forKey: _node.id)
        
        return true
    }
    
    public func AddCmd(_nodes:[T]) -> Bool
    {
        for arr_index in 0..<_nodes.count
        {
            let cmd_node = _nodes[arr_index]
            let res = AddCmd(_node:cmd_node)
            if false == res
            {
                Logger?.Log( "[\(cmd_node.id)] Command Aready Exist." )
            }
        }
        
        return true
    }
    
    public func ExecuteCmd(_id:String, _args:[String]) -> _ACTION_RESULT
    {
        let node = cmdNodes[_id]
        if node == nil {
            return ._INVALIED_CMD
        }
        return node!.fnCmdAction(_args)
    }
    
    public func fnCmd_Help(args:[String?]) -> _ACTION_RESULT
    {
        for (key, value) in cmdNodes
        {
            print(String(repeating: " ", count : 16-key.count), terminator:"")
            print(String(format: "%@ ▷ %@", key, value.desc ))
        }
        
        return ._HELP
    }

}
