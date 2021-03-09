//
//  main_CmdFuncs+Selector.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/09.
//

import Foundation
import NiSConsole

let className = "testClass"
let funcName = "testFuncWith"

func fnCmd_Selector(cmd: [String?]) -> _ACTION_RESULT {
    
    var tc = testClass()
    
    let fnSelector  = #selector(testClass.testFunc)
    let fnWithSelectorS = Selector(className + "." + funcName)
    let fnWithSelector  = #selector(testClass.testFuncWith)
    
    let fs: String = fnSelector.description
    let fsWith: String = fnWithSelector.description
    
    Logger?.Log( "fn Selector : \(fs)" )
    Logger?.Log( "fnWithS Selector : \(fnWithSelectorS.description)")
    Logger?.Log( "fnWith Selector : \(fsWith)" )    // 함수명 뒤에 Parameter가 있으면 With는 무조건 들어감.

    let fn = NSSelectorFromString(fs)
    tc.perform(fn, with: "Welcome")
    tc.perform(fn, with: 1)
    tc.perform(fn)

    let fnWith = NSSelectorFromString(fsWith)   // fnWith가 정상적인 함수인지는 알 방법이 없음.
    
//    tc.perform(fnWith, with: "withParameter" )
    var param : [String: Any]? = nil
    tc.perform(fnWith, with: param )
//    tc.perform(fnWith, with: 1)
//    tc.perform(fnWith)
    
    return ._OK
}

class testClass: NSObject {
    
    // 인자가 명시 되어 있는데, Type 이 틀리면 죽음
    // 인자가 있는데, with: 없이 호출하면 죽음
    @objc func testFuncWith(Params: [String : Any]?) {
        Logger?.Log( "TestFunc params[]")
    }
    
    // 인자가 없을 때 perform(with:)로 호출해도 상관 없음.
    @objc func testFunc() {
        Logger?.Log( "TestFunc params[NoParameters]")
    }
}
