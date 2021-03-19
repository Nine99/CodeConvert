//
//  ViewController.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/19.
//

import UIKit
import NiSFoundation

class VC_UIAnim: UIViewController {

    @IBOutlet weak var btnTarget: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let txtTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        txtTitle.font = txtTitle.font.withSize(30)
        txtTitle.textColor = .systemOrange
        //txtTitle.alpha = 1
        txtTitle.text = "testLabel"
        
        self.view.addSubview(txtTitle)
        
        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseInOut, animations: {
            //txtTitle.alpha = 0
            txtTitle.frame = CGRect(x: 0, y: 100, width: 300, height: 30)
        }, completion: { isFinish in
            Logger?.Log( "Animation is Done.")
            UIView.transition(with: txtTitle, duration: 3, options: .transitionCrossDissolve, animations: {
                txtTitle.textColor = .systemBlue
            }, completion: { isTrans in
                Logger?.Log( "Transition is Done." )
            })
        })
        
        self.btnTarget.backgroundColor = .clear
        
        UIView.transition(with: btnTarget, duration: 3, options: .transitionCrossDissolve, animations: {
            self.btnTarget.backgroundColor = .systemOrange
        }, completion: { isTrans in
            Logger?.Log( "Transition is Done.[btnTarget]")
        })
        
    }


}

