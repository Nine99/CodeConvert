//
//  NiSMgrAlign.swift
//  NiSLib
//
//  Created by ITTF04 on 2021/02/16.
//

import UIKit
import NiSLib

public class NiSMgrAlign : NSObject{
    public static let shared: NiSMgrAlign = {
        let setter = NiSMgrAlign()
        return setter
    }()
    
    public static func Instance() -> NiSMgrAlign {
        return shared
    }
    
    private var baseResolution : CGSize?
    private var deviceResolution : CGSize?
    private var convertRatio : CGVector?
    
    public override init() {
        NiSLogger.Instance().Log( String(format: "Scale : %.1f, Bounds : %@", UIScreen.main.scale, UIScreen.main.bounds.debugDescription) )
    }
    
    public func InitAlignManager(baseRes: CGSize, deviceRes: CGSize)
    {
        baseResolution = baseRes
        deviceResolution = deviceRes
        
        convertRatio = CGVector(dx: deviceResolution!.width / baseResolution!.width, dy: deviceResolution!.height / baseResolution!.height)
    }
 
    public func ConvertX(_ x: CGFloat) -> CGFloat {
        return x * convertRatio!.dx
    }
    
    public func ConvertY(_ y: CGFloat) -> CGFloat {
        return y * convertRatio!.dy
    }
    
    public func Convert(_ res: CGSize) ->CGSize {
        return CGSize(width: ConvertX(res.width), height: ConvertY(res.height))
    }
    
    public func FitToView( parent: UIView, subView: UIView )
    {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        subView.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        subView.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
    }
}
