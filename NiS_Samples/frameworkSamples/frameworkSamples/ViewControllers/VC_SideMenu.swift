//
//  VC_SideMenu.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/23.
//

import UIKit
import NiSFrameWork

class VC_SideMenu: UIViewController {

    @IBOutlet weak var vstackMenu: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        NiSMgrAlign.Instance().StickToTop(parentView: self.view, subView: vstackMenu)
        
        vstackMenu.widthAnchor
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
