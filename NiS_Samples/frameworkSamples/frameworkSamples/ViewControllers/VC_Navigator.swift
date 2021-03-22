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

    static var navigationIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    static func AddVCTemplate(navigationController: UINavigationController!) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyBoard.instantiateViewController(identifier: "sbidVCTemplate") as! VC_Template
        newVC.modalPresentationStyle = .fullScreen

        navigationIndex += 1
//        newVC.vcID = "VC[\(navigationIndex)]"
        navigationController.pushViewController(newVC, animated: true)
        Logger?.Log("New Template ViewController.")
    }
}
