//
//  VC_SideMenu.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/23.
//

import UIKit
import NiSFoundation
import NiSFrameWork

class VC_SideMenu: UIViewController {

    @IBOutlet weak var menuBoard: UIStackView!
    
    var vcTemplate: VC_Template?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        adjustMenuBaord()
    }
    
    func adjustMenuBaord() {
        
        let btnMenus = [
            UIButton(),
            UIButton(),
            UIButton()
        ]
        
        for (index, btn) in btnMenus.enumerated() {
            btn.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
            btn.setTitle("Menu_\(index)", for: .normal)
            menuBoard.addArrangedSubview(btn)
        }
        
        btnMenus[0].addTarget(self, action: #selector(onBtnMenuBoard(_:)), for: .touchUpInside)
        btnMenus[1].addTarget(self, action: #selector(onBtnMenuBoard(_:)), for: .touchUpInside)
        btnMenus[2].addTarget(self, action: #selector(onBtnNext(_sender:)), for: .touchUpInside)
        
//        menuBoard.translatesAutoresizingMaskIntoConstraints = false
//        
//        let constraints = [
//            menuBoard.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
//            menuBoard.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
//            menuBoard.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            menuBoard.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200),
//        ]
//        
//        NSLayoutConstraint.activate(constraints)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func onTestMenu_01(_ sender: Any?) {
        Logger?.Log("onTestMenu 01")
    }
    
    @objc func onBtnMenuBoard( _ sender: UIButton?) {
        Logger?.Log( "\(sender!.currentTitle!)" )
    }
    
    @objc func onBtnNext( _sender: Any?) {
        Logger?.Log( "Next ViewController" )
        
        vcTemplate?.AddVCTemplate()
    }
    
}
