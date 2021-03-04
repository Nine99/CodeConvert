//
//  NiSConsole.swift
//  NiSConsole
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation

public class NiSConsoleFW
{
    var cmdExecuter : NiCmdExecuter<NiCmdNode> = NiCmdExecuter()
    
    var isRunning : Bool = false;
    
    var fnCmdExit : fnAction = { (args) -> Void in }

    public init(_ _fn_cmd_exit : @escaping fnAction = ({_ in }))
    {
        NiSLogger.Instance().InitLogger()
        
        NiSLogger.Instance().Log(color: NiColor.Green, "================================ Nine99 Swift Console")

        _ = AddCmd( _node: NiCmdNode.init("EXIT",
                                      { _ in
                                        self.fnCmdExit([])
                                        self.isRunning = false
                                      }, desc: "Exit"
        ))
        
        fnCmdExit = _fn_cmd_exit
    }
    
    public func ReadLine() -> [String]
    {
        print("🖥 ", terminator:"")
        let response = readLine()
        let in_strings = response?.uppercased().components(separatedBy: " ")

        return in_strings ?? [String]()
    }
    
    func ExecuteCmd(_args:[String])
    {
        if false == cmdExecuter.ExecuteCmd(_id: _args[0], _args:_args )
        {
            NiSLogger.Instance().Log(color: NiColor.Red, "Invalid Command[]")
        }
    }
    
    public func CommandLoop()
    {
        isRunning = true
        
        while true == isRunning
        {
            ExecuteCmd(_args: ReadLine())
            
            if false == isRunning
            {
                break;
            }
        }
    }
    
    public func AddCmd(_node: NiCmdNode) -> Bool
    {
        return cmdExecuter.AddCmd(_node: _node)
    }
    
    public func AddCmd(_nodes: [NiCmdNode]) -> Bool
    {
        return cmdExecuter.AddCmd(_nodes: _nodes)
    }
    


}
