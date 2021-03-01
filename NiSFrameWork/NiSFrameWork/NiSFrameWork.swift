//
//  NiSFrameWork.swift
//  NiSFrameWork
//
//  Created by ITTF04 on 2021/02/18.
//

import UIKit
import NiSLib

public class NiSFrameWork {
    
    // MARK: 최상단 뷰컨트롤러 가져오기
    @objc static public func GetTopViewController(controller: UIViewController? = nil) -> UIViewController? {
//        UIApplication.shared.keyWindow?.rootViewController
        
        var viewCtrl: UIViewController?
        
        if controller == nil {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            viewCtrl = keyWindow?.rootViewController
        }
        else {
            viewCtrl = controller
        }
            
        if let navigationController = viewCtrl as? UINavigationController {
            return GetTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = viewCtrl as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return GetTopViewController(controller: selected)
            }
        }
        if let presented = viewCtrl?.presentedViewController {
            return GetTopViewController(controller: presented)
        }
        return viewCtrl
    }
    
    public static func RegisterFont(bundle: Bundle = Bundle.main, name: String!, ext: String!) {
        guard let url = bundle.url(forResource: name, withExtension: ext), CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        else {
            NiSLogger.Instance().Log("Failed To Regist \(String(describing: name))")
            return
        }
    }
}
