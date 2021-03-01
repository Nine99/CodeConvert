//
//  NiSFWLoggerView.swift
//  NiSFrameWork
//
//  Created by ITTF04 on 2021/02/16.
//

import UIKit
import NiSLib

public extension NiLogLevel {
    func GetLevelColor() -> UIColor {
        switch self {
        case .ERROR:
            return .red
            
        case .INFO:
            return .green
            
        case .WARN:
            return .yellow
            
        default:
            return .darkGray
        }
    }
}

class FontRegisterClass {}

public var LoggerView : NiSLoggerView?

@IBDesignable public class NiSLoggerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewText: NiSBottomTextView!
    
    var loggerFont : UIFont?
    
    var headerAttr : [NSAttributedString.Key: Any]?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonSetup()
        //fatalError("init(coder:) has not been implemented")
    }
    
    func commonSetup() {
        guard let _ = loadView(bundleID: "com.Nine99.NiSFrameWork") else { return }

        self.addSubview(contentView)
        
        contentView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        NiSFrameWork.RegisterFont(bundle: Bundle(for: FontRegisterClass.self), name: "UbuntuMono-Regular", ext: "ttf")
        
        loggerFont = UIFont(name: "UbuntuMono-Regular", size: 12)
        headerAttr = [
            .foregroundColor : UIColor.blue,
            .font : loggerFont!
        ]
        viewText.font = loggerFont
        
//        let topViewCtrl = NiSFrameWork.GetTopViewController()!.view
//        contentView.frame = NiSMgrAlign.Instance().FitRect(frame: UIScreen.main.bounds, inset: topViewCtrl!.safeAreaInsets)
        contentView.frame = UIScreen.main.bounds
        
        let device = UIDevice.current

        let _ = NiSLogger.Instance()
        Begin(tag: "System Info")
        AddLog( device.name )
        //print( device.userInterfaceIdiom )
        
        AddLog( UIDevice.modelName )
        AddLog( UIScreen.main.bounds.debugDescription )
        
        NiSMgrAlign.Instance().InitAlignManager(baseRes: _LOGICAL_RES.IPHONE11.GetDeviceResolutionSize()!, deviceRes: UIScreen.main.bounds.size)
        let convertedPos = NiSMgrAlign.Instance().Convert(_LOGICAL_RES.IPHONE11.GetDeviceResolutionSize()!)
        AddLog( convertedPos.debugDescription )
        End()
        
        LoggerView = self

    }
    
    public func AddText(color: UIColor = .darkGray, _ content: String) {
        NiSLib.AsyncCall {
            
            let attr : [NSAttributedString.Key: Any] =
                [
                    .foregroundColor : color
                ]
            
            let header_str = NSAttributedString(string: NiSLogger.Instance().MakeHeaderString(), attributes: self.headerAttr)
            let log_str = NSAttributedString(string: content, attributes: attr)
            let mutableStr = self.viewText.attributedText.mutableCopy() as! NSMutableAttributedString
            mutableStr.append(header_str)
            mutableStr.append(log_str)
            self.viewText.attributedText = mutableStr
            //viewText.insertText(content)      // insertText() 사용시 didSet에 진입하지 않음.
            print(content)
        }
    }
    
    public func AddLog(color: UIColor = .green, _ log: String, logLevel: NiLogLevel = .DEBUG) {
        NiSLib.AsyncCall {
            let logNL = log + "\n"
            switch logLevel {
            case .INFO:
                // LogLevel 이 .INFO 일 경우만 Text 색을 변경할 수 있게 함.
                self.AddText(color: color, logNL)
            default :
                self.AddText(color: logLevel.GetLevelColor(), logNL)
            }
        }
    }
    
//    func fnLogger(content: Any)
//    {
//        self.viewText.attributedText = content as! NSAttributedString
//        print(content)
//    }
    
    public func Begin(tag: String)
    {
        // indent Stack 이 선처리라 어쩔 수 없이 SetText와 공유하지 못 함.
        NiSLib.AsyncCall {
            let attr : [NSAttributedString.Key: Any] =
                [
                    .foregroundColor : UIColor.brown
                ]
            
            let header_str = NSAttributedString(string: NiSLogger.Instance().MakeHeaderString(), attributes: self.headerAttr)
            let log_str = NSAttributedString(string: NiSLogger.Instance().MakeBeginString(tag: tag) + "\n", attributes: attr)
            let mutableStr = self.viewText.attributedText.mutableCopy() as! NSMutableAttributedString
            mutableStr.append(header_str)
            mutableStr.append(log_str)
            self.viewText.attributedText = mutableStr  //.text.append( content )

        }
    }
    
    public func End()
    {
        NiSLib.AsyncCall {
            self.AddText(NiSLogger.Instance().MakeEndString() + "\n")
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}
