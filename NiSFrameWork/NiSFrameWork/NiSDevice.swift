//
//  NiSDevice.swift
//  NiSLib
//
//  Created by ITTF04 on 2021/02/16.
//

import Foundation
import UIKit

public enum _LOGICAL_RES {
    case IPHONE11
    
    public func GetDeviceResolutionSize() -> CGSize? {
        switch self {
        case .IPHONE11 :
            return CGSize(width: 414, height: 896)
            
        default :
            return nil
        }
    }
    
    public func GetDeviceResolution() -> CGRect? {
        let size = self.GetDeviceResolutionSize()!
        
        return CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
}

public class NiSDevice {
    
}
