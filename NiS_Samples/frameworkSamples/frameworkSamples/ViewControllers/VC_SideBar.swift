//
//  VC_SideBar.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/25.
//

import UIKit
import NiSFrameWork

class VC_SideBar: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createControls()
    }
    
    func createControls() {
        let btnOpenVC = UIButton()
        btnOpenVC.setTitle("Open New VC", for: .normal)
        btnOpenVC.backgroundColor = .systemOrange
        btnOpenVC.addTarget(self, action: #selector(onBtnOpenVC(_:)), for: .touchUpInside)
        self.view.addSubview(btnOpenVC)
        NiSMgrAlign.FitToView(parentView: self.view, subView: btnOpenVC)
    }
    
    @objc func onBtnOpenVC(_ sender: Any?) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyBoard.instantiateViewController(identifier: "sbidVCAnim") as! VC_UIAnim

        show(newVC, sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
