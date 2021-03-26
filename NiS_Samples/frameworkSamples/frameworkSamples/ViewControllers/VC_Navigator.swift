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
    @IBOutlet weak var contentsMenuBoard: UIStackView!
    
    var vcSideMenu: VC_SideMenu?
    
    static var navigationIndex: Int = 0
    
    var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //createControls()
        adjustContentsMenuBoard()
        adjustSideMenu()
    }
    
    func adjustSideMenu() {
        // 일단 연결된 ViewController 내에서 조정해 보자.
        NiSMgrAlign.StickToRight(parentView: self.view!, subView: sideMenu)
        
    }
    
    func adjustContentsMenuBoard() {
        contentsMenuBoard.backgroundColor = #colorLiteral(red: 0.9836583137, green: 1, blue: 0.7669297921, alpha: 1)
        contentsMenuBoard.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            contentsMenuBoard.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentsMenuBoard.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            contentsMenuBoard.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            contentsMenuBoard.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func createControls() {
        testView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        self.view.addSubview(testView)
        testView.backgroundColor = .systemOrange

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
        
        let oTr = sideMenu.transform
        
        let dir = sideMenu.isHidden ? -1 : 1
        let talpha : CGFloat = sideMenu.isHidden ? 1.0 : 0.0
        let tTr = oTr.translatedBy(x: sideMenu.frame.width * CGFloat(dir), y: 0)

        sideMenu.isHidden = false

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.sideMenu.transform = tTr
                self.sideMenu.alpha = talpha
            }, completion: { _ in
                self.sideMenu.isHidden = dir > 0 ? true : false
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgidSideMenu" {
            vcSideMenu = segue.destination as? VC_SideMenu
            vcSideMenu?.vcTemplate = self
        }
    }
    
    
}
