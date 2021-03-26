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
    
    var bottomSheetVC: VC_BottomSheet?
    var bottomSheetOpenTr: CGAffineTransform!
    var bottomSheetCloseTr: CGAffineTransform!
    
    let bottomSheetLimitRatio: CGFloat = 0.8
    var bottomSheetLimitHeight: CGFloat = 0
    let bottomSheetMiddleRatio: CGFloat = 0.5
    var bottomSheetMiddleHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupBottomSheet()

        animateControls()
        
        setupGesture()
//        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
//        swipeRightGesture.direction = .right
//        addGestureRecognizer(swipeRightGesture)
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGesture))
        self.view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture))
        self.view.addGestureRecognizer(panGesture)
    }
    
    func setupBottomSheet() {
        self.view.bringSubviewToFront(bottomSheet)
        let scrSize = UIScreen.main.bounds.size
        bottomSheetLimitHeight = CGFloat(scrSize.height) * bottomSheetLimitRatio
        bottomSheetMiddleHeight = CGFloat(scrSize.height) * bottomSheetMiddleRatio
        
        bottomSheet.frame.size = scrSize
        bottomSheet.frame.origin = CGPoint(x: 0, y: Int(scrSize.height) - Int(bottomSheetLimitHeight))
        NiSMgrAlign.StickToBottom(parentView: self.view, subView: bottomSheet)
        
        Logger?.Log( "\(bottomSheet.center)" )

        bottomSheetOpenTr = bottomSheet.transform
        bottomSheetCloseTr = bottomSheetOpenTr.translatedBy(x: 0, y: bottomSheet.frame.height)

        Logger?.Log( "o:\(bottomSheetOpenTr!), c:\(bottomSheetCloseTr!)" )
    }

    func animateControls() {
        let txtTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        txtTitle.font = txtTitle.font.withSize(30)
        txtTitle.textColor = .systemOrange
        txtTitle.alpha = 0
        txtTitle.text = "Entry : Title"
        self.view.addSubview(txtTitle)
        
        NiSMgrAlign.StickToTop(parentView: self.view, subView: txtTitle)

        let targetTr = txtTitle.transform.translatedBy(x: 0, y: 200)

        UIView.animate(withDuration: 0.7, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .allowAnimatedContent, animations: {
            txtTitle.transform = targetTr
            txtTitle.alpha = 1
        }, completion: { isTranslated in
            Logger?.Log( "Animation is Done.")
            UIView.transition(with: txtTitle, duration: 3, options: .transitionCrossDissolve, animations: {
                txtTitle.textColor = .systemBlue
            }, completion: { isTrans in
                Logger?.Log( "Transition is Done." )
            })
        })
        
        // Title Animation by no SpringDamper
//        UIView.animate(withDuration: 0.7, delay: 1, options: .curveEaseInOut, animations: {
//            txtTitle.transform = targetTr
//            txtTitle.alpha = 1
//        }, completion: { isFinish in
//            Logger?.Log( "Animation is Done.")
//            UIView.transition(with: txtTitle, duration: 3, options: .transitionCrossDissolve, animations: {
//                txtTitle.textColor = .systemBlue
//            }, completion: { isTrans in
//                Logger?.Log( "Transition is Done." )
//            })
//        })

        // Aim Target Button Animation
//        self.btnTarget.backgroundColor = .clear
//
//        UIView.transition(with: btnTarget, duration: 2, options: .transitionCrossDissolve, animations: {
//            self.btnTarget.backgroundColor = .systemOrange
//        }, completion: { isTrans in
//            Logger?.Log( "Transition is Done.[btnTarget]")
//        })

        closeBottomSheet()
//        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
//            self.bottomSheet.transform = self.bottomSheetCloseTr
//        }, completion: nil)
    }
    
    func openBottomSheet() {
//        let oriTr = bottomSheet.transform
//        let oriCoord = self.view.convert(bottomSheet.frame.origin, to: nil)
//        let targetTr = oriTr.translatedBy(x: 0, y: (oriCoord.y - UIScreen.main.bounds.height))
        
        self.view.bringSubviewToFront(bottomSheet)
        UIView.animate(
            withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .allowAnimatedContent,
            animations: {
                self.bottomSheet.transform = self.bottomSheetOpenTr
            },
            completion: nil
        )
        
        Logger?.Log( "Open BottomSheet")
    }
    
    func closeBottomSheet() {
        UIView.animate(
            withDuration: 0.3, delay: 0, options: .curveEaseInOut,
            animations: {
                self.bottomSheet.transform = self.bottomSheetCloseTr
            }, completion: { _ in
                
            }
        )
        
        Logger?.Log( "Close BottomSheet" )
        Logger?.Log( "\(bottomSheet.center)" )
    }
    
    // Recognize Swipe with UIView
//    @objc func didSwipe(_ gesture: UISwipeGestureRecognizer) {
//        switch gesture.direction {
//        case .right:
//            Logger?.Log( "Swipe Right" )
//            Navigator?.backPress()
//
//        default:
//            Logger?.Log( "Other" )
//        }
//    }
    
    @IBAction func onBtnOpenBottomSheet(_ sender: Any) {
        openBottomSheet()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgidBottomSheet" {
            bottomSheetVC = segue.destination as? VC_BottomSheet
        }
    }
    
    @objc func onTapGesture(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: bottomSheet)
        
        if (bottomSheet.bounds.contains(touchPoint) == false) {
            closeBottomSheet()
        }
    }
    
    @objc func onPanGesture(_ sender: UIPanGestureRecognizer) {
//        let location = sender.location(in: bottomSheet)
        let translate = sender.translation(in: bottomSheet)
//        let origin = self.view.convert( bottomSheet.frame.origin, to: nil )
//        Logger?.Log("\(location) : \(translate) : \(origin)")

        // Transform 으로 처리 했기 때문에 Center를 건드리면 안됨, 계속 Transform만 갖고 놀아야 함.
        //bottomSheet.center = CGPoint(x: bottomSheet.center.x, y: bottomSheet.center.y + translate.y)
        bottomSheet.transform.ty += translate.y
        sender.setTranslation(.zero, in: bottomSheet)

        // 갱신이 늦기 때문에 크기를 늘려가는 건 안 됨.
//        let oriSize = bottomSheet.frame.size
//        bottomSheet.frame.size = CGSize(width: oriSize.width, height: UIScreen.main.bounds.height - origin.y)
        
    }
    
}

