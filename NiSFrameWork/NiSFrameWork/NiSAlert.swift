//
//  NiSAlert.swift
//  NiSFrameWork
//
//  Created by ITTF04 on 2021/02/18.
//

import UIKit
import NiSFoundation

public protocol NiSAlertControl {
    init(title: String?, message: String, buttons: Array<String>, actionBlock: @escaping (Int) -> Void)
    func show()
}

public class NiSAlert {
    static let shared: NiSAlert = {
        return NiSAlert()
    }()
    
    public static func Instance() -> NiSAlert {
        return shared
    }

    @objc public func show(title: String?, message: String, buttons: Array<String>, actionBlock: @escaping (Int) -> Void) {
        if let alertClass = SConfig.shared.alertClass {
            // Custom Alert 리소스가 등록되어 있다면 진입...
            let alert = alertClass.init(title: title, message: message, buttons: buttons, actionBlock: actionBlock)
            alert.show()
        }
        else {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for i in 0...buttons.count-1 {
                let action = UIAlertAction(title: buttons[i], style: .default, handler: { action in
                    actionBlock(i)
                })
                alert.addAction(action)
            }
            //SUtil.topViewController()!.present(alert, animated: true, completion: nil)
            NiSFrameWork.GetTopViewController()!.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc public func show(title: String?, message: String) {
        self.show(title: title, message: message, buttons: ["확인"]) { (index) in }
    }
    
    @objc public func show(message: String) {
        self.show(title: nil, message: message, buttons: ["확인"]) { (index) in }
    }
    
    @objc public func alertWithTextField() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addTextField { (myTextField) in
            myTextField.text = "http://"
        }
        let ok = UIAlertAction(title: "변경", style: .default) { (ok) in
            NiSPreference.Instance().putSetting(key: "devUrl", value: alert.textFields![0].text!)
            NiSPreference.Instance().saveSetting()
            exit(0)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancel) in
            exit(0)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        NiSFrameWork.GetTopViewController()!.present(alert, animated: true, completion: nil)
    }
}
