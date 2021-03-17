//
//  NiSLib.swift
//  NiSLib
//
//  Created by ITTF04 on 2021/02/16.
//

//import UIKit
import Foundation

public typealias fnNoArgAction = () -> Void

public class NiSUtils {
    public static func GetClassName(_ obj: Any) -> String {
        return String(describing: type(of: self))
    }
    
    @objc static public func AsyncCall(_ fnBlock: @escaping()->Void) {
        if Thread.isMainThread {
            fnBlock()
        } else {
            DispatchQueue.main.async {
                fnBlock()
            }
        }
    }
    
    public static func DelayCall(_ delay: Double, fn: @escaping fnNoArgAction) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            fn()
        }
    }

    @objc public static func dateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public static func EnumBundle() {
        Logger?.Begin(tag: "All Bundle Count : \(Bundle.allBundles.count)")
        Bundle.allBundles.forEach( {
            Logger?.Log( "Identifier : \($0.bundleIdentifier!)")
        })
        Logger?.End()
        
        Logger?.Begin(tag: "Framework Count : \(Bundle.allFrameworks.count)")
        Bundle.allFrameworks.forEach( {
            let pathWithoutLastFoler = $0.sharedFrameworksURL!.deletingLastPathComponent()
            Logger?.Log( "Name : \(pathWithoutLastFoler.lastPathComponent)")
        })
        Logger?.End()
    }
}
