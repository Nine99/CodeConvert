//
//  VC_Template.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/22.
//

import UIKit
import NiSFoundation
import NiSFrameWork
import SwiftUI

class VC_Template: UIViewController, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate {
    
//    var vcID: String!
//    var txtID: UILabel!
//    var btnNextVC: UIButton!
//    var btnNewView: UIButton!
    
    var naviView: NavigatedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //naviView = NavigatedView(frame: self.view.frame)

//        self.txtID = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
//        self.view.addSubview(txtID)
//        self.txtID.text = self.vcID
//        self.txtID.isUserInteractionEnabled = false
//        NiSMgrAlign.Instance().StickToTop(parentView: self.view, targetView: txtID)
//
//        self.btnNextVC = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 20) )
//        self.view.addSubview(self.btnNextVC)
//        self.btnNextVC.setTitle("Next VC", for: .normal)
//        self.btnNextVC.setTitleColor(.systemOrange, for: .normal)
//        self.btnNextVC.addTarget(self, action: #selector(openNextVC), for: .touchUpInside)
//        NiSMgrAlign.Instance().AlignToCenter(parentView: self.view, targetView: self.btnNextVC)
//
//        self.btnNewView = UIButton(frame: btnNextVC.frame)
//        self.btnNextVC.addSubview(self.btnNewView)
//        self.btnNewView.setTitle("New View", for: .normal)
//        self.btnNewView.setTitleColor(.systemBlue, for: .normal)
//        self.btnNewView.addTarget(self, action: #selector(onNewView), for: .touchUpInside)
        
        

        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeRightGesture.direction = .right
        self.view.addGestureRecognizer(swipeRightGesture)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @objc func openNextVC() {
        VC_Navigator.AddVCTemplate(navigationController: navigationController!)
    }
    
    @objc func onNewView() {
//        let newView = NavigatedView()
//        newView.alpha = 0.5
//        NiSMgrAlign.Instance().FitToView(parent: self.view, subView: newView)
        
//        self.view.bringSubviewToFront(btnNextVC)
//        self.view.bringSubviewToFront(btnNewView)
    }
    
    @objc func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            Logger?.Log( "Swipe Right" )
            navigationController?.popViewController(animated: true)
            //Navigator?.backPress()

        default:
            Logger?.Log( "Other" )
        }
    }
}
