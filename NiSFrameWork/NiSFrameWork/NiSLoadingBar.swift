//
//  SLoadingBar.swift
//  SMobile
//
//  Created by 60029566 on 2019. 1. 31..
//  Copyright © 2019년 Shinhan DS. All rights reserved.
//

import UIKit
import NiSFoundation

/**
 * 로딩바 클래스
 * 이미지 설정 및 show, hide
 */

@objc public class NiSLoadingBar: NSObject {
    // MARK: 변수 선언
    var spinnerView: UIView
    var activityIndicator: UIActivityIndicatorView
    var iconList: Array<String>
    var iconImageList: Array<UIImage>
    var iconSize: CGSize
    let iconImageView: UIImageView
    var count: Int
    @objc public var isDisable = false
    
    @objc static let shared: NiSLoadingBar = {
        let obj = NiSLoadingBar()
        return obj
    }()
    
    @objc public static func Instance() -> NiSLoadingBar {
        return shared
    }
    
    override private init() {
        spinnerView = UIView()
        activityIndicator = UIActivityIndicatorView()
        iconList = Array<String>()
        iconImageList = Array<UIImage>()
        iconSize = CGSize()
        iconImageView = UIImageView()
        count = 0
    }
    
    // MARK: 로딩바 커스텀 이미지 셋팅 (인자값 iconList: 이미지명 배열, iconSize: 이미지 크기)
    @objc public func setIcon(iconList: Array<String>, iconSize: CGSize) {
        self.iconList = iconList
        self.iconSize = iconSize
    }
    
    // MARK: 로딩바 커스텀 이미지 셋팅 (인자값 iconList: 이미지명 배열, iconSize: 이미지 크기)
    @objc public func setIcon(iconImageList: Array<UIImage>, iconSize: CGSize) {
        self.iconImageList = iconImageList
        self.iconSize = iconSize
    }
    
    // MARK: 로딩바 호출
    @objc public func show() {
        if isDisable {
            return
        }
        
        if self.count > 0 {
            self.count += 1
            return
        }
        
//        guard let keyWindow = UIApplication.shared.keyWindow else {
//            SUtil.log("keyWindow is nil")
//            return
//        }
        guard let keyWindow = UIApplication.shared.windows.first else {
            //SUtil.log("keyWindow is nil")
            NiSLogger.Instance().Log("keyWindow is nil")
            return
        }

        NiSUtils.AsyncCall {

            self.spinnerView.frame = UIScreen.main.bounds
            self.spinnerView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)

            // 커스텀 이미지가 있을 경우 해당 이미지 로딩, 그외는 기본 UIActivityIndicatorView 사용
            if (self.iconList.count > 0 && self.iconSize.width > 0) {
                var arrIcon = Array<UIImage>()

                for i in 0...self.iconList.count-1 {
                    if let image = UIImage(named: self.iconList[i]) {
                        arrIcon.append(image)
                    }
                }

                self.iconImageView.frame = CGRect.init(x: 0, y: 0, width: self.iconSize.width, height: self.iconSize.height)
                self.iconImageView.center = self.spinnerView.center
                self.spinnerView.addSubview(self.iconImageView)
                self.iconImageView.animationImages = arrIcon
                self.iconImageView.animationDuration = 1.2
                self.iconImageView.startAnimating()
            }
            else if (self.iconImageList.count > 0 && self.iconSize.width > 0) {
                var arrIcon = Array<UIImage>()

                for i in 0...self.iconImageList.count-1 {
                    arrIcon.append(self.iconImageList[i] as UIImage)
                }

                self.iconImageView.frame = CGRect.init(x: 0, y: 0, width: self.iconSize.width, height: self.iconSize.height)
                self.iconImageView.center = self.spinnerView.center
                self.spinnerView.addSubview(self.iconImageView)
                self.iconImageView.animationImages = arrIcon
                self.iconImageView.animationDuration = 1.2
                self.iconImageView.startAnimating()
            }
            else {
                self.activityIndicator.style = .medium
                self.activityIndicator.startAnimating()
                self.activityIndicator.center = self.spinnerView.center
                self.spinnerView.addSubview(self.activityIndicator)
            }

            keyWindow.addSubview(self.spinnerView)
            self.count += 1
        }
    }
    
    @objc public func showExceptNavigationBar() {
        
        if isDisable {
            return
        }
        
        guard let topVC = NiSFrameWork.GetTopViewController() else {
            //SUtil.log("topVC is nil")
            NiSLogger.Instance().Log("topVC is nil")
            return
        }
        
        if self.count > 0 {
            self.count += 1
            return
        }

        NiSUtils.AsyncCall {

            self.spinnerView.frame = CGRect.init(x: topVC.view.frame.origin.x, y: 0.0, width: topVC.view.frame.size.width, height: topVC.view.frame.size.height)
            self.spinnerView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)

            // 커스텀 이미지가 있을 경우 해당 이미지 로딩, 그외는 기본 UIActivityIndicatorView 사용
            if (self.iconList.count > 0 && self.iconSize.width > 0) {
                var arrIcon = Array<UIImage>()

                for i in 0...self.iconList.count-1 {
                    if let image = UIImage(named: self.iconList[i]) {
                        arrIcon.append(image)
                    }
                }

                self.iconImageView.frame = CGRect.init(x: 0, y: 0, width: self.iconSize.width, height: self.iconSize.height)
                self.iconImageView.center = self.spinnerView.center
                self.spinnerView.addSubview(self.iconImageView)
                self.iconImageView.animationImages = arrIcon
                self.iconImageView.animationDuration = 1.2
                self.iconImageView.startAnimating()
            } else if (self.iconImageList.count > 0 && self.iconSize.width > 0) {
                var arrIcon = Array<UIImage>()

                for i in 0...self.iconImageList.count-1 {
                    arrIcon.append(self.iconImageList[i] as UIImage)
                }

                self.iconImageView.frame = CGRect.init(x: 0, y: 0, width: self.iconSize.width, height: self.iconSize.height)
                self.iconImageView.center = self.spinnerView.center
                self.spinnerView.addSubview(self.iconImageView)
                self.iconImageView.animationImages = arrIcon
                self.iconImageView.animationDuration = 1.2
                self.iconImageView.startAnimating()
            } else {
                self.activityIndicator.style = .medium
                self.activityIndicator.startAnimating()
                self.activityIndicator.center = self.spinnerView.center
                self.spinnerView.addSubview(self.activityIndicator)
            }

            topVC.view.addSubview(self.spinnerView)
            self.count += 1
        }
    }
    
    // MARK: 로딩바 닫기
    @objc public func hide() {
        if isDisable {
            return
        }

        NiSUtils.AsyncCall {
            self.count -= 1

            if (self.count <= 0) {
                self.count = 0
                self.iconImageView.removeFromSuperview()
                self.activityIndicator.stopAnimating()
                self.spinnerView.removeFromSuperview()
            }
        }
    }
}
