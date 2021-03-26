//
//  ViewController.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/19.
//

import UIKit
import NiSFoundation
import NiSFrameWork

class VC_Entry: UIViewController {

    @IBOutlet weak var btnTarget: UIButton!
    @IBOutlet weak var bottomSheet: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        animateControls()
        
        setupBottomSheet()
    }
    
    func setupBottomSheet() {
        self.view.bringSubviewToFront(bottomSheet)
        NiSMgrAlign.StickToBottom(parentView: self.view, subView: bottomSheet)
    }

    func animateControls() {
        let txtTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        txtTitle.font = txtTitle.font.withSize(30)
        txtTitle.textColor = .systemOrange
        txtTitle.alpha = 0
        txtTitle.text = "Entry : Title"
        self.view.addSubview(txtTitle)
        
        NiSMgrAlign.StickToTop(parentView: self.view, subView: txtTitle)

        let targetTr = txtTitle.transform.translatedBy(x: 0, y: 300)
        
        UIView.animate(withDuration: 0.7, delay: 1, options: .curveEaseInOut, animations: {
            txtTitle.transform = targetTr
            txtTitle.alpha = 1
        }, completion: { isFinish in
            Logger?.Log( "Animation is Done.")
            UIView.transition(with: txtTitle, duration: 3, options: .transitionCrossDissolve, animations: {
                txtTitle.textColor = .systemBlue
            }, completion: { isTrans in
                Logger?.Log( "Transition is Done." )
            })
        })
        
        self.btnTarget.backgroundColor = .clear
        
        UIView.transition(with: btnTarget, duration: 2, options: .transitionCrossDissolve, animations: {
            self.btnTarget.backgroundColor = .systemOrange
        }, completion: { isTrans in
            Logger?.Log( "Transition is Done.[btnTarget]")
        })
    }
}

