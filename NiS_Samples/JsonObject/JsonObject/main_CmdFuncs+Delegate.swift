//
//  main_CmdFuncs+Delegate.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/15.
//

import Foundation
import NiSConsole

var cmdNodes_Delegate: [NiCmdNode] = [
    NiCmdNode("INIT",               fnCmd_Delegate_Init,            desc: "Codable Test for Simple Class" ),
    NiCmdNode("CALL",               fnCmd_Delegate_Derivation,      desc: "Codable Test for Dictionary" )
]

var cmdExecutor_Delegate: NiSCmdExecutor<NiCmdNode> = NiSCmdExecutor<NiCmdNode>()

func fnCmd_Delegate( cmd: [String?] ) -> _ACTION_RESULT {
    let _ = cmdExecutor_Delegate.AddCmd(_node: NiCmdNode("EXIT", {_ ->_ACTION_RESULT in
        return ._EXIT
    }))
    
    var _ = cmdExecutor_Delegate.AddCmd(_nodes: cmdNodes_Delegate)
    
    fwCon.CommandLoop(cmdExecutor_Delegate, levelStr: cmd[0]!)
    
    return ._OK
}

func fnCmd_Delegate_Init(cmd: [String?]) -> _ACTION_RESULT {
    
    return ._OK
}

func fnCmd_Delegate_Derivation(cmd: [String?]) -> _ACTION_RESULT {
    let tdc = testDerivedClass()
    
    tdc.fnDerivationDelegate()
    
    tdc.fnDelegate =  { () -> Void in
        Logger?.Log("Delegate Function by variable.")
    }
    
    tdc.fnDelegate?()
    
    return ._OK
}

protocol testDelegator {
    func fnDerivationDelegate()
}

class testDelegateClass : testDelegator {
    func fnDerivationDelegate() {
        Logger?.Log( #function + "] \(#line)" )
    }
}

class testDerivedClass : testDelegateClass {
    var fnDelegate: (() -> Void)?
    
    override func fnDerivationDelegate() {
        super.fnDerivationDelegate()
        
        Logger?.Log( #function + "] \(#line)" )
    }
}
