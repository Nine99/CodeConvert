//
//  NiSLogger.swift
//  NiSLogger
//
//  Created by nine99p on 2021/02/13.
//

import Foundation

public enum NiLogLevel : Int {
    case DEBUG, INFO, WARN, ERROR
}

public enum NiColor : String {
    case Black = "\u{001B}[0;30m"
    case Red = "\u{001B}[0;31m"
    case Green = "\u{001B}[0;32m"
    case Yellow = "\u{001B}[0;33m"
    case Blue = "\u{001B}[0;34m"
    case Magenta = "\u{001B}[0;35m"
    case Cyan = "\u{001B}[0;36m"
    case White = "\u{001B}[0;37m"
    case Gray = "\u{001B}[0;90m"
    case LightRed = "\u{001B}[0;91m"
    case LightGreen = "\u{001B}[0;92m"
    case LightYellow = "\u{001B}[0;93m"
    case LightBlue = "\u{001B}[0;94m"
    case LightMagenta = "\u{001B}[0;95m"
    case LightCyan = "\u{001B}[0;96m"
    case LightWhite = "\u{001B}[0;97m"
}

public typealias fnHeaderFunc = (NiLogLevel) -> String
public typealias fnLoggerFunc = (String) -> Void

public class NiSLogger : NSObject {

    static let shared: NiSLogger = {
        let logger = NiSLogger()
        return logger
    }()
    
    public static func Instance() -> NiSLogger {
        return shared
    }

    var isMono : Bool = true
    
    var fnHeader : fnHeaderFunc?
    var fnLogger : fnLoggerFunc?
    
    private let formatter = DateFormatter()
    
    private var indentStack = NiSStack<String>()     // String Tag
    
    public override init() {
        super.init()
        self.InitLogger()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "yy.MM.dd hh:mm:ss"
        
        self.Log("================== Start Log")
        formatter.dateFormat = "hh:mm:ss"
    }
    
    private func fnHeaderMono(_ logLevel: NiLogLevel = .INFO) -> String {
        let time = Date()
        let interval = time.timeIntervalSince1970 * 1000
        let reminder = Int(interval.truncatingRemainder(dividingBy: 1) * 100)
        let time_str =
            formatter.string(from: time) +
            String(format: ".%02d", reminder) +
            "] "
        
        return String(repeating: "    ", count: indentStack.Count) + time_str
    }
    
    private func fnHeaderDefault(_ logLevel: NiLogLevel = .INFO) -> String {
        let time = Date()
        let interval = time.timeIntervalSince1970 * 1000
        let reminder = Int(interval.truncatingRemainder(dividingBy: 1) * 100)
        var time_str = ( true == isMono ? "" : NiColor.Blue.rawValue) +
            formatter.string(from: time) +
            String(format: ".%02d", reminder)
            
        switch logLevel {
        case .ERROR:
            time_str += " ⭕️ "
        case .WARN:
            time_str += " 🩹 "
        default:
            time_str += " ⭐️ "
        }
            
        
        return String(repeating: "    ", count: indentStack.Count) + time_str
    }
    
    @inlinable func fnLoggerDefault(_ log: String ) {
        print( log )
    }
    
    public func InitLogger(argIsMono: Bool = true)
    {
        InitLogger(argFnHeader: fnHeaderDefault, argFnLogger: fnLoggerDefault, argIsMono: argIsMono)
    }

    public func InitLogger(argFnHeader: @escaping fnHeaderFunc, argFnLogger: @escaping fnLoggerFunc, argIsMono: Bool = true)
    {
        isMono = argIsMono
        fnHeader = argFnHeader
        fnLogger = argFnLogger
    }
    
    //_______________________________________________ About Block Indent
    public func MakeBeginString(tag: String) -> String {
        let endBlockStr = "Begin of \(tag) [i\(indentStack.Count)]"
        indentStack.push(_element : tag)

        return endBlockStr
    }
    
    public func MakeEndString() -> String {
        guard indentStack.Count > 0 else { return "PAIR NOT MATCH" }

        let tag = indentStack.pop()
        let endBlockStr = (isMono ? "End of \(tag ?? "NONAME")" : "End of \(tag ?? "NONAME")")
        
        return endBlockStr
    }
    
    public func Begin(tag : String)
    {
        NiSUtils.AsyncCall {
            let startBlockStr = (self.fnHeader ?? self.fnHeaderDefault)(.DEBUG) + self.MakeBeginString(tag: tag)
            (self.fnLogger ?? self.fnLoggerDefault)(startBlockStr)
        }
    }
    
    public func End()
    {
        NiSUtils.AsyncCall {
            let endBlockStr = (self.fnHeader ?? self.fnHeaderDefault)(.DEBUG) + self.MakeEndString()
            (self.fnLogger ?? self.fnLoggerDefault)(endBlockStr)
        }
    }
    
    public func MakeHeaderString(_ logLevel: NiLogLevel = .INFO) -> String {
        return (fnHeader ?? fnHeaderDefault)(logLevel)
    }
    
    //_______________________________________________ Internal MakeLogString with [CVarArg]
    func MakeLogString(color: NiColor, format: String, withArg: [CVarArg]) -> String {
        return MakeHeaderString() + (true == isMono ? "" : color.rawValue) + String(format: format, arguments: withArg)
    }
    
    func MakeLogString(format: String, _ argLog: [CVarArg]) -> String {
        return MakeHeaderString() + String(format: format, arguments: argLog)
    }
    
    func MakeLogString(color: NiColor, _ log: String) -> String {
        return MakeHeaderString() + (true == isMono ? "" : color.rawValue) + log
    }
    
//    func MakeLogString(obj: Encodable) -> String {
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .withoutEscapingSlashes
//        let data_str = "" //try encoder.encode(obj)
//        return data_str
//    }
    
    //_______________________________________________ Public MakeLogString
    public func MakeLogString(color: NiColor, format: String, _ argLog: CVarArg...) -> String {
        return MakeLogString(color: color, format: format, withArg: argLog)
    }
        
    public func MakeLogString(format: String, _ argLog: CVarArg...) -> String {
        return MakeLogString(format: format, argLog)
    }
    
    public func MakeLogString(_ log: String) -> String {
        return MakeHeaderString() + log
    }
    
    //_______________________________________________ Public Log
    public func Log(color: NiColor, format: String, _ argLog: CVarArg...) {
        NiSUtils.AsyncCall({
            (self.fnLogger ?? self.fnLoggerDefault)(self.MakeLogString(color: color, format: format, withArg: argLog))
        })
    }
    
    public func Log(format: String, _ argLog: CVarArg...) {
        NiSUtils.AsyncCall({
            (self.fnLogger ?? self.fnLoggerDefault)(self.MakeLogString(format: format, argLog))
        })
    }
    
    public func Log(color: NiColor, _ log: String) {
        NiSUtils.AsyncCall({
            (self.fnLogger ?? self.fnLoggerDefault)(self.MakeLogString(color: color, log))
        })
    }
    
    public func Log(_ log:String) {
        NiSUtils.AsyncCall({
            (self.fnLogger ?? self.fnLoggerDefault)(self.MakeLogString(log))
        })
    }
    
    public func Log(argLog: CVarArg...)
    {
        //(fnLogger ?? fnLoggerDefault)()
    }
    
    static public func log(_ params: CVarArg..., level: NiLogLevel = .DEBUG, file: String = #file, function: String = #function, line: Int = #line) {
        DispatchQueue.main.async {
            let fileString: NSString = NSString(string: file)
            let now = Date()
            let dateString = NiSUtils.dateToString(date: now, format: "yyyy-MM-dd HH:mm:ss.SSS")
            
//            if SConfig.shared.isLog, SConfig.shared.logLevel.rawValue <= level.rawValue {
                let prefix = (level == .ERROR) ? "[ERROR] " : " "
                print("\(prefix)\(dateString) file:\(fileString.lastPathComponent) \(function) line:\(line) \(params)")
                
//                if SDebugConsole.shared.superview != nil {
//                    SDebugConsole.shared.add(text: String(format:"\(prefix)\(dateString) file:\(fileString.lastPathComponent) \(function) line:\(line) \(params)"))
//                }
//            }
        }
    }
}
