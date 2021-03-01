//
//  NiSPreference.swift
//  NiSLib
//
//  Created by ITTF04 on 2021/02/18.
//

import Foundation

public class NiSPreference : NSObject {
    public static let shared: NiSPreference = {
        let pref = NiSPreference()
        //pref.InitLogger()
        return pref
    }()
    
    static public func Instance() -> NiSPreference {
        return shared
    }
    
    let kSetting = "SETTING"
    
    var userDict:[String : Any] = [:]
    var appDic:[String : Any] = [:]
    
    var isLoadUserSetting  = false
    var isLoadAppSetting   = false
    
    
    //========================================
    // 계정 전용
    @objc public func put(key:String, value:Any) {
        if isLoadUserSetting == false {
            //SUtil.log("[WARN] UserDefault not loaded.", level:.WARN)
            NiSLogger.Instance().Log("[WARN] UserDefault not loaded.")
        }
        userDict[key] = value
    }
    
    @objc public func get(key:String) -> Any? {
        if isLoadUserSetting == false {
            //SUtil.log("[WARN] UserDefault not loaded.", level:.WARN)
            NiSLogger.Instance().Log("[WARN] UserDefault not loaded.")
        }
        return userDict[key]
    }
    
    @objc public func remove(key:String) {
        if isLoadUserSetting == false {
            //SUtil.log("[WARN] UserDefault not loaded.", level:.WARN)
            NiSLogger.Instance().Log("[WARN] UserDefault not loaded.")
        }
        userDict.removeValue(forKey: key)
    }
    
    @objc public func load(user:String) {
        userDict = UserDefaults.standard.object(forKey: user) as? [String : Any] ?? [:]
        isLoadUserSetting = true
    }
    
    @objc public func save(user:String) {
        if isLoadUserSetting == false {
            //SUtil.log("[WARN] UserDefault not loaded.", level:.WARN)
            NiSLogger.Instance().Log("[WARN] UserDefault not loaded.")
        }
        UserDefaults.standard.set(userDict, forKey: user)
        UserDefaults.standard.synchronize()
    }
        
    //========================================
    // 디바이스 전역
    
    @objc public func putSetting(key:String, value:Any) {
        if isLoadAppSetting == false {
            loadSetting()
        }
        
        appDic[key] = value
    }
    
    @objc public func getSetting(key:String) -> Any? {
        if isLoadAppSetting == false {
            loadSetting()
        }
        
        return appDic[key]
    }
    
    @objc public func removeSetting(key:String) {
        if isLoadUserSetting == false {
            loadSetting()
        }
        appDic.removeValue(forKey: key)
    }
    
    func loadSetting() {
        appDic = UserDefaults.standard.object(forKey: kSetting) as? [String : Any] ?? [:]
        isLoadAppSetting  = true
    }
    
    @objc public func saveSetting() {
        UserDefaults.standard.set(appDic, forKey: kSetting)
        UserDefaults.standard.synchronize()
    }
    
}
