//
//  NiSConsole.swift
//  NiSConsole
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation

public var Logger : NiSLogger?

public class NiSConsoleFW
{
    static let shared: NiSConsoleFW = {
        let con = NiSConsoleFW()
        return con
    }()
    
    public static func Instance() -> NiSConsoleFW {
        return shared
    }
    
    var cmdExecuter : NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor()
    
    var fnCmdExit : fnAction?

    public init(_ ConsoleExitDelegate : @escaping fnAction = ({_ -> _ACTION_RESULT in return ._EXIT }))
    {
////        NiSLogger.Instance().InitLogger()
////
//        NiSLogger.Instance().Log(color: NiColor.Green, "================================ Nine99 Swift Console")
//
//        _ = AddCmd( _node: NiCmdNode.init("EXIT",
//                                      { _ in
//                                        self.fnCmdExit([])
//                                        self.isRunning = false
//                                      }, desc: "Exit"
//        ))
//
//        fnCmdExit = ConsoleExitDelegate
        InitCommonDelegate(ConsoleExitDelegate)
    }
    
    public func InitCommonDelegate(_ ConsoleExitDelegate : @escaping fnAction = ({ _  -> _ACTION_RESULT in return ._EXIT }))
    {
        Logger = NiSLogger.Instance()
        Logger?.Log(color: NiColor.Green, "================================ Nine99 Swift Console")

        fnCmdExit = ConsoleExitDelegate
        
        _ = AddCmd( _node: NiCmdNode.init("EXIT",
                                      { _ in
                                        self.fnCmdExit!([])
                                      }, desc: "Exit"
        ))
    }
    
    public func ReadLine() -> [String]
    {
        print("🖥 ", terminator:"")
        let response = readLine()
        let in_strings = response?.uppercased().components(separatedBy: " ")

        return in_strings ?? [String]()
    }
    
//    func ExecuteCmd(_args:[String])
//    {
//        if ._INVALIED_CMD == cmdExecuter.ExecuteCmd(_id: _args[0], _args:_args )
//        {
//            NiSLogger.Instance().Log(color: NiColor.Red, "Invalid Command[\(_args[0])]")
//        }
//    }
    
    public func CommandLoop()
    {
        CommandLoop(cmdExecutor: cmdExecuter)
//        while true
//        {
//            let args = ReadLine()
//            let result = cmdExecuter.ExecuteCmd(_id: args[0], _args:args )
//            if result == ._EXIT { break }
//            switch result {
//            case ._INVALIED_CMD:
//                Logger?.Log(.ERROR, "Invalid Command")
//            default:
//                break;
//            }
//        }
    }
    
    public func CommandLoop(cmdExecutor: NiSCmdExecutor<NiCmdNode>) {
        while true
        {
            let args = ReadLine()
            let result = cmdExecutor.ExecuteCmd(_id: args[0], _args:args )
            if result == ._EXIT { break }
            switch result {
            case ._INVALIED_CMD:
                Logger?.Log(.ERROR, "Invalid Command")
            default:
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
