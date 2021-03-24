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
    
    var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
//        sideMenu.isHidden = true
//        self.view.bringSubviewToFront(sideMenu)
        
        testView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        self.view.addSubview(testView)
        testView.backgroundColor = .systemOrange

//        testView.translatesAutoresizingMaskIntoConstraints = false
////        testView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
////        testView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
////        testView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
////        testView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
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
        testView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            testView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
//            testView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100),
            testView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            testView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
//            testView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
}
