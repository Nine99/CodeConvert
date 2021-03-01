//
//  UIViewController+Ext.swift
//  NiSFrameWork
//
//  Created by ITTF04 on 2021/02/22.
//

import UIKit

public extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
//    var bottombarHeight: CGFloat {
//
//
//        //return ( view.window?.windowScene?.tabbar)
//    }
}
