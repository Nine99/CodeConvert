//
//  VC_SubViewDelegate.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/25.
//

import UIKit
import NiSFoundation

protocol VC_SubViewDelegate : UIViewController {
    var delegate: UIViewController? { get set }
}
