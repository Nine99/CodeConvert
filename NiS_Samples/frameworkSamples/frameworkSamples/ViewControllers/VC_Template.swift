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

//class VC_Template: UIViewController, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate {
class VC_Template: UIViewController {
    
//    var vcID: String!
//    var txtID: UILabel!
//    var btnNextVC: UIButton!
//    var btnNewView: UIButton!
    
    var iView: NavigatedView!

    var hostingController: UIHostingController<NavigatedView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        addControlsBySwiftUI()
//        addControlsByUIKit()

        // Do any additional setup after loading the view.
        
//        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
//        swipeRightGesture.direction = .right
//        self.view.addGestureRecognizer(swipeRightGesture)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addControlsBySwiftUI() {
        // vStack 활용을 위한 SwiftUI View 사용
        let extModel = NavigatedViewExt()
        extModel.viewId = "ViewID :"
        extModel.onNewViewController = openNextVC
        extModel.onNewView = onNewView

        iView = NavigatedView(extModel: extModel)
        hostingController = UIHostingController(rootView: iView)
        self.view.addSubview(hostingController.view)
        NiSMgrAlign.Instance().StickToTop(parentView: self.view, subView: hostingController.view)
        self.addChild(hostingController)
    }
    
    func addControlsByUIKit() {
        // StackedView 를 이용하여 정렬
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let txtViewId = UILabel()
        txtViewId.text = "View ID"
        txtViewId.textAlignment = .center
        let btnOpenNextVC = UIButton()
        btnOpenNextVC.setTitle("Next View Controller", for: .normal)
        btnOpenNextVC.setTitleColor(.systemOrange, for: .normal)
        btnOpenNextVC.addTarget(self, action: #selector(openNextVC), for: .touchUpInside)

        let btnOnNewView = UIButton()
        btnOnNewView.setTitle("New View", for: .normal)
        btnOnNewView.setTitleColor(.systemBlue, for: .normal)

        let ctrlArray = [ txtViewId, btnOpenNextVC, btnOnNewView ]
        for ctrl in ctrlArray {
            stackView.addArrangedSubview(ctrl)
        }

        self.view.addSubview(stackView)
        NiSMgrAlign.Instance().StickToTop(parentView: self.view, subView: stackView)
    }

    func AddVCTemplate() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyBoard.instantiateViewController(identifier: "sbidVCTemplate") as! VC_Template
        newVC.modalPresentationStyle = .fullScreen

//        navigationIndex += 1
//        newVC.vcID = "VC[\(navigationIndex)]"
        navigationController?.pushViewController(newVC, animated: true)
        Logger?.Log("New Template ViewController.")
    }
    
    @objc func openNextVC() {
        AddVCTemplate()
        //iView.extModel.viewId = "Modified ID : "
        //Logger?.Log("Hamberger")
    }
    
    @objc func onNewView() {
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
