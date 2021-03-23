//
//  NiSStorage.swift
//  NiSFoundation
//
//  Created by ITTF04 on 2021/03/23.
//

import Foundation

public var NiSGlobalStorage: NiSGlobalStorageModel = NiSGlobalStorageModel.Instance()
public var NiSSessionStorage: NiSSessionStorageModel = NiSSessionStorageModel.Instance()

public class NiSStorage: NSObject {
    
    var storage: pairStringAny = pairStringAny()
 
    public func set<T>(key: String!, value: T) {
        storage.updateValue(value, forKey: key)
    }
    
    public func get<T>(_ key: String!) -> T {
        return storage[key] as! T
    }
    
    public func remove(key: String!) {
        storage.removeValue(forKey: key)
    }
    
    public func clear() {
        // Component 안 지우고 removeAll 해도 memory Leak 안 나려나?
        storage.removeAll()
    }
    
    public func toString() -> String! {
        return storage.toJson()
    }
}

public class NiSGlobalStorageModel: NiSStorage {
    static let shared: NiSGlobalStorageModel = {
        let gstorage = NiSGlobalStorageModel()
        return gstorage
    }()
    
    public static func Instance() -> NiSGlobalStorageModel {
        return shared
    }

}

public class NiSSessionStorageModel: NiSStorage {
    static let shared: NiSSessionStorageModel = {
        let sstorage = NiSSessionStorageModel()
        return sstorage
    }()
    
    public static func Instance() -> NiSSessionStorageModel {
        return shared
    }

}
