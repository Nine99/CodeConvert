//
//  NiSConsole.swift
//  NiSConsole
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation

public var Logger : NiSLogger? = nil

public class NiSConsoleFW
{
    static let shared: NiSConsoleFW = {
        let con = NiSConsoleFW()
        return con
    }()
    
    public static func Instance() -> NiSConsoleFW {
        return shared
    }
    
    var cmdExecuter = NiSCmdExecutor<NiCmdNode>()
    public var promptStack = NiSStack<String>()

    var fnCmdExit : fnAction?
    

    public init(_ ConsoleExitDelegate : @escaping fnAction = ({_ -> _ACTION_RESULT in return ._EXIT }), beLog: Bool = true)
    {
        InitCommonDelegate(ConsoleExitDelegate, beLog: beLog)
    }
    
    public func InitCommonDelegate(_ ConsoleExitDelegate : @escaping fnAction = ({ _  -> _ACTION_RESULT in return ._EXIT }), beLog: Bool = true)
    {
        if beLog == true {
            Logger = NiSLogger.Instance()
        }

        Logger?.Log(color: NiColor.Green, "================================ Nine99 Swift Console")

        fnCmdExit = ConsoleExitDelegate
        
        _ = AddCmd( _node: NiCmdNode.init("EXIT",
                                      { _ in
                                        self.fnCmdExit!([])
                                      }, desc: "Exit"
        ))
    }
    
    public func ReadLine() -> [String]?
    {
        var prompt : String = ""
        for cmdLevel in promptStack.Elements {
            prompt += cmdLevel + "/"
        }
        prompt += " 🖥 "
        print(prompt, terminator:"")
        let response = readLine()
        let in_strings = response?.uppercased().components(separatedBy: " ")
        //let in_strings = response?.components(separatedBy: " ")

        return in_strings ?? [String]()
    }
    
    public func CommandLoop() {
        CommandLoop(cmdExecuter)
    }
    
    public func CommandLoop( _ cmdExecutor: NiSCmdExecutor<NiCmdNode>, levelStr: String = "" ) {
        promptStack.push(levelStr)
        
        while true
        {
            let args = ReadLine()
            let result = cmdExecutor.ExecuteCmd(_id: args?[0] ?? "", _args:args )
            if result == ._EXIT { break }
            switch result {
            case ._INVALIED_CMD:
                Logger?.Log(.ERROR, "Invalid Command.")
            case ._INVALIED_ARGUMENT:
                Logger?.Log(.WARN, "Invalid Argument.")
            default:
                break;
            }
        }
        
        var _ = promptStack.pop()
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
