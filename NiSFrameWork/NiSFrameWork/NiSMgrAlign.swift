//
//  NiSMgrAlign.swift
//  NiSLib
//
//  Created by ITTF04 on 2021/02/16.
//

import UIKit
import NiSFoundation

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
    
    public static func ApplyConstrains(constrains: [NSLayoutConstraint], targetView: UIView?) {
        guard let subView = targetView else { return }
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(constrains)
    }
    
    public static func FitToView( parentView: UIView?, subView: UIView? )
    {
        guard let oriView = parentView, let targetView = subView else { return }
        
        ApplyConstrains(constrains: [ targetView.topAnchor.constraint(equalTo: oriView.topAnchor),
                                      targetView.bottomAnchor.constraint(equalTo: oriView.bottomAnchor),
                                      targetView.leftAnchor.constraint(equalTo: oriView.leftAnchor),
                                      targetView.rightAnchor.constraint(equalTo: oriView.rightAnchor) ], targetView: targetView)
    }
    
    public static func FitToSafeArea( parentView: UIView?, subView: UIView?)
    {
        guard let oriView = parentView, let targetView = subView else {
            Logger?.Log(.ERROR, "Invalid Source View")
            return
        }
        
        ApplyConstrains(constrains: [ targetView.topAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.topAnchor),
                                      targetView.bottomAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.bottomAnchor),
                                      targetView.leftAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.leftAnchor),
                                      targetView.rightAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.rightAnchor) ], targetView: targetView)
    }
    
    public static func StickToTop( parentView: UIView?, subView: UIView?)
    {
        guard let oriView = parentView, let targetView = subView else {
            Logger?.Log(.ERROR, "Invalid Source View")
            return
        }
        
        ApplyConstrains(constrains: [targetView.topAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.topAnchor),
                                     targetView.centerXAnchor.constraint(equalTo: oriView.centerXAnchor)], targetView: targetView)
    }
    
    public static func StickToBottom( parentView: UIView?, subView: UIView?)
    {
        guard let oriView = parentView, let targetView = subView else {
            Logger?.Log(.ERROR, "Invalide Source View" )
            return
        }

        ApplyConstrains(constrains: [ targetView.bottomAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.bottomAnchor),
                                      targetView.centerXAnchor.constraint(equalTo: oriView.centerXAnchor) ], targetView: targetView)
    }
    
    public static func StickToRight( parentView: UIView?, subView: UIView? ) {
        guard let oriView = parentView, let targetView = subView else {
            Logger?.Log(.ERROR, "Invalid Source View")
            return
        }
        
        ApplyConstrains(constrains: [ targetView.topAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.topAnchor),
                                      targetView.bottomAnchor.constraint(equalTo: oriView.safeAreaLayoutGuide.bottomAnchor),
                                      targetView.leftAnchor.constraint(equalTo: oriView.leftAnchor, constant: oriView.frame.width - subView!.frame.width),
                                      targetView.rightAnchor.constraint(equalTo: oriView.rightAnchor) ], targetView: targetView)
    }

    public static func AlignToCenter( parentView: UIView?, subView: UIView?)
    {
        guard let oriView = parentView, let targetView = subView else {
            Logger?.Log(.ERROR, "Invalid Source View" )
            return
        }
        
        ApplyConstrains(constrains: [ targetView.centerXAnchor.constraint(equalTo: oriView.centerXAnchor),
                                      targetView.centerYAnchor.constraint(equalTo: oriView.centerYAnchor) ], targetView: targetView)
    }
}
