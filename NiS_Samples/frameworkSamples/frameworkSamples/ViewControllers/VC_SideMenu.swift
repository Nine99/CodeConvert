//
//  VC_SideMenu.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/23.
//

import UIKit
import NiSFoundation
import NiSFrameWork

class VC_SideMenu: UIViewController {

//    var vstackMenu: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        
//        NiSMgrAlign.Instance().StickToTop(parentView: self.view, subView: vstackMenu)
        
        //vstackMenu.widthAnchor
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        vstackMenu = UIStackView()
//        vstackMenu.axis = .vertical
//        vstackMenu.distribution = .fillEqually
//        vstackMenu.alignment = .fill
//        vstackMenu.spacing = 10
//        vstackMenu.translatesAutoresizingMaskIntoConstraints = false
//
//        let txtViewId = UILabel()
//        txtViewId.text = "View ID"
//        txtViewId.textAlignment = .center
//        let btnOpenNextVC = UIButton()
//        btnOpenNextVC.setTitle("Next View Controller", for: .normal)
//        btnOpenNextVC.setTitleColor(.systemOrange, for: .normal)
//        btnOpenNextVC.addTarget(self, action: #selector(onTestMenu_01(_:)), for: .touchUpInside)
//
//        let btnOnNewView = UIButton()
//        btnOnNewView.setTitle("New View", for: .normal)
//        btnOnNewView.setTitleColor(.systemBlue, for: .normal)
//
//        let ctrlArray = [ txtViewId, btnOpenNextVC, btnOnNewView ]
//        for ctrl in ctrlArray {
//            vstackMenu.addArrangedSubview(ctrl)
//        }
//
//        self.view.addSubview(vstackMenu)
//        NiSMgrAlign.Instance().StickToTop(parentView: self.view, subView: vstackMenu)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func onTestMenu_01(_ sender: Any?) {
        Logger?.Log("onTestMenu 01")
    }
}
