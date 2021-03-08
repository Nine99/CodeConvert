//
//  main_CmdFuncs+TypeName.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/08.
//

import Foundation
import NiSConsole

var cmdNodes_TypeName: [NiCmdNode] = [
    NiCmdNode("TOSTRING",         fnCmd_TypeName_ToString,            desc: "" ),
    NiCmdNode("TOCLASS",          fnCmd_TypeName_ToClass,             desc: "" )
]

var cmdExecutor_TypeName: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_TypeName( cmd: [String] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_TypeName.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))
    
    var _ = cmdExecutor_TypeName.AddCmd(_nodes: cmdNodes_TypeName)
    
    fwCon.CommandLoop(cmdExecutor_TypeName, levelStr: cmd[0])
    
    return ._OK
}

func fnCmd_TypeName_ToClass(cmd: [String]) -> _ACTION_RESULT {
    let aClassType = NSClassFromString("JsonObject.TempClass") as! NSObject.Type
    let instance = aClassType.init()
    return ._OK
}

func fnCmd_TypeName_ToString(cmd: [String]) -> _ACTION_RESULT {
    Logger?.Log(TempClass.typeName)
    return ._OK
}

protocol NameDescribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    var typeName: String {
        return String(describing: type(of: self))
    }

    static var typeName: String {
        return String(describing: self)
    }
}

class TempClass : NSObject, NameDescribable {
    override init() {
        super.init()
    }
}

extension Bundle {
    static func appName() -> String? {
         guard let dictionary = Bundle.main.infoDictionary else {
             return nil
         }
         if let version : String = dictionary["CFBundleName"] as? String {
             return version
         } else {
             return nil
         }
     }
}
