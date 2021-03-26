//
//  VC_BottomSheet.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/26.
//

import UIKit
import NiSFoundation

class VC_BottomSheet: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragGrabber(_:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onBtnHide(_ sender: Any) {
        if let pvc = parent {
            let entry_vc = pvc as! VC_Entry
            entry_vc.closeBottomSheet()
        }
    }
    
    @objc func dragGrabber( _ sender: UIPanGestureRecognizer ) {
        let translate = sender.translation(in: self.view)
        
        sender.view!.center = CGPoint(x: sender.view!.center.x, y: sender.view!.center.y + translate.y)
        sender.setTranslation(.zero, in: self.view)
    }
    
}
