//
//  VC_NavigationEntry.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/22.
//

import UIKit
import NiSFoundation
import NiSFrameWork

class VC_Navigator: VC_Template {

    @IBOutlet weak var sideMenu: UIView!
    
    static var navigationIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //sideMenu.isHidden = true
        self.view.bringSubviewToFront(sideMenu)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onBtnShowSideMenu(_ sender: UIBarButtonItem) {
//        sideMenu.accessibilityFrame.size = CGSize(width: 10, height: 500)
        //sideMenu.isHidden = !sideMenu.isHidden
    }
    
}
