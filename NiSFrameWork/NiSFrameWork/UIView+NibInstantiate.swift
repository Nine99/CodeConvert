//
//  UIViewEx.swift
//  testCustomView
//
//  Created by nine99p on 2021/02/12.
//

import UIKit

public extension UIView {
    var className : String? {
        get {
            return String(describing: type(of: self))
        }
    }
    
    func loadView(bundleID: String) -> UIView? {
        let bundle = Bundle(identifier: bundleID)
        let nib = UINib(nibName: className!, bundle: bundle)    // xib 와 swift 소스의 이름이 같다는 전제조건으로 불러 옴.(이름이 달라지면 큰일 남)
        let instance = nib.instantiate(withOwner: self, options: nil)
        return instance.first as? UIView
    }
    
    var mainView: UIView? {
        return subviews.first
    }
}

