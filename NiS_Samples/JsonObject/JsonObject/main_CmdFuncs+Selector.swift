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

let testClassInstance = testClass()

func fnCmd_Selector(cmd: [String?]) -> _ACTION_RESULT {
    // ------------------------------------------------ No Arg
    //let selFn = #selector(testClass.testFunc)         // Ambiguous : 함수명이 같은 것이 있으면 반드시 파라메터를 명시해 줘야 함.( TODO: 아직 해결 못 함 )
//    let fs_str: String = selFn.description
//    Logger?.Log( "fn(No Arg) : \(fs_str)" )
//
//    let fn = NSSelectorFromString(fs_str)
//    testClassInstance.perform(fn)
    
    // ------------------------------------------------
    let param : [String: Any]? = Dictionary<String, Any>()
    
    // ------------------------------------------------ 1 Arg
    let selFn1Arg = #selector(testClass.testFunc(params:))                  // fn(1 Arg) : testFuncWithParams:
    let fs1Arg_str: String = selFn1Arg.description
    Logger?.Log( "fn(1 Arg) : \(fs1Arg_str)")

    let fn1Arg = NSSelectorFromString(fs1Arg_str)
    testClassInstance.perform(fn1Arg, with: param)

    // ------------------------------------------------ 2 Arg
    let selFn2Arg  = #selector(testClass.testFunc(_ : with: ))                  // fn(2 Arg) : testFunc:with:
//    let selFn2Arg  = #selector(testClass.testFunc(params : with: ))         //  fn(2 Arg) : testFuncWithParams:with:
    let fs2Arg_str: String = selFn2Arg.description
    Logger?.Log( "fn(2 Arg) : \(fs2Arg_str)")

    let fn2Arg = NSSelectorFromString(fs2Arg_str)
//    testClassInstance.perform(fn2Arg)
    testClassInstance.perform(fn2Arg, with: param)
    testClassInstance.perform(fn2Arg, with: param, with: nil)

    return ._OK
}

class testClass: NSObject {
    
    // 인자가 없을 때 perform(with:)로 호출해도 상관 없음.
    @objc func testFunc() {
        Logger?.Log( "TestFunc ()")
    }
    
    // 인자가 명시 되어 있는데, Type 이 틀리면 죽음
    // 인자가 있는데, with: 없이 호출하면 죽음
    @objc func testFunc(params: [String : Any]?) {
        Logger?.Log( "TestFunc (params: [:]?{\(params?.count ?? -1)})")
    }

    @objc func testFunc(_ params: [String : Any]?, with callback: Any) {
        Logger?.Log("TestFunc (params: [:]?{\(params?.count ?? -1)}, callBack: Any{\(callback)})")
    }
}
