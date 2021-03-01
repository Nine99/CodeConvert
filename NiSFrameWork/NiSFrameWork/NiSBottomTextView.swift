//
//  DerivedTextView.swift
//  testLibAndFramework
//
//  Created by ITTF04 on 2021/02/17.
//

import UIKit
import NiSFoundation

class NiSBottomTextView: UITextView, UITextViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override var text: String! {
        didSet {
            onTextChange()
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            onTextChange()
        }
    }
    
    func onTextChange() {
//        let logger = NiSLogger.GetInstance()
//        logger.Log("Text Changed")
        
        self.sizeThatFits(CGSize(width: self.visibleSize.width, height: self.visibleSize.height))
        self.layoutIfNeeded()

//        logger.Log(self.textInputView.frame.debugDescription)
//        logger.Log(self.contentSize.debugDescription)
//        logger.Log(self.visibleSize.debugDescription)
//        logger.Log(self.frame.debugDescription)
//        logger.Log(self.intrinsicContentSize.debugDescription)
//        logger.Log(self.text)
//        logger.Log(self.frame.debugDescription)
        
        let scroll_value = self.contentSize.height - self.visibleSize.height
        if ( scroll_value > 0 ) {
            self.setContentOffset(CGPoint(x: 0, y: scroll_value), animated: true)
        }
        
        NiSLogger.Instance().Log( "onTextChange" )
    }
    
    func textViewDidChange(_ textView: UITextView) {
        NiSLogger.Instance().Log("textViewDidChange")
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        NiSLogger.Instance().Log( "shouldChangeTextIn" )
        
        return true
    }
}
