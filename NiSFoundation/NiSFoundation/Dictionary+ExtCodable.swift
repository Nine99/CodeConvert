//
//  Dictionary+ExtCodable.swift
//  NiSConsole
//
//  Created by ITTF04 on 2021/03/03.
//

import Foundation
import CoreGraphics

public typealias pairStringAny = [String:Any]

public extension Dictionary where Key == String, Value: Any {
    
    func object<T: Decodable>() ->T? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        else {
            return nil
        }
    }
    
    func jsonObject() -> Data {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return Data()
        }
        
        return jsonData
    }
    
    func toJson() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            return String(data: jsonData, encoding: .utf8)
        }
        
        return nil
    }

}

public struct JSONCodingKeys: CodingKey {
    public var stringValue: String
    public var intValue: Int?

    public init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }

    public init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}

// MARK: - Decode
public extension KeyedDecodingContainer {
    func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
        let container = try nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.decode(type)
    }

    func decodeIfPresent(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any]? {
        guard contains(key) else { return nil }
        return try decode(type, forKey: key)
    }

    func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
        var container = try nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }

    func decodeIfPresent(_ type: [Any].Type, forKey key: K) throws -> [Any]? {
        guard contains(key) else { return nil }
        return try decode(type, forKey: key)
    }

    func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        var dictionary = [String: Any]()

        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode([Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            }
        }
        return dictionary
    }
}

public extension UnkeyedDecodingContainer {
    mutating func decode(_ type: [Any].Type) throws -> [Any] {
        var array: [Any] = []

        while !isAtEnd {
            let value: String? = try decode(String?.self)
            guard value != nil else { continue }

            if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Int.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode([String: Any].self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode([Any].self) {
                array.append(nestedArray)
            }
        }
        return array
    }

    mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}

// MARK: - Encode
public extension KeyedEncodingContainerProtocol where Key == JSONCodingKeys {
    mutating func encode(_ value: [String: Any]) throws {
        try value.forEach({ (key, value) in
            let key = JSONCodingKeys(stringValue: key)
            switch value {
            case let value as Bool:
                try encode(value, forKey: key)
            case let value as Int:
                try encode(value, forKey: key)
            case let value as String:
                try encode(value, forKey: key)
            case let value as Double:
                try encode(value, forKey: key)
            case let value as CGFloat:
                try encode(value, forKey: key)
            case let value as [String: Any]:
                try encode(value, forKey: key)
            case let value as [Any]:
                try encode(value, forKey: key)
            case Optional<Any>.none:
                try encodeNil(forKey: key)
            default:
                let context = EncodingError.Context(codingPath: codingPath + [key],
                                                    debugDescription: "Invalid JSON value")
                throw EncodingError.invalidValue(value, context)
            }
        })
    }
}

public extension KeyedEncodingContainerProtocol {
    mutating func encode(_ value: [String: Any], forKey key: Key) throws {
        var container = nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        try container.encode(value)
    }

    mutating func encodeIfPresent(_ value: [String: Any]?, forKey key: Key) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    mutating func encode(_ value: [Any], forKey key: Key) throws {
        var container = nestedUnkeyedContainer(forKey: key)
        try container.encode(value)
    }

    mutating func encodeIfPresent(_ value: [Any]?, forKey key: Key) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }
}

public extension UnkeyedEncodingContainer {
    mutating func encode(_ value: [Any]) throws {
        try value.enumerated().forEach { (index, value) in
            switch value {
            case let value as Bool:
                try encode(value)
            case let value as Int:
                try encode(value)
            case let value as String:
                try encode(value)
            case let value as Double:
                try encode(value)
            case let value as CGFloat:
                try encode(value)
            case let value as [String: Any]:
                try encode(value)
            case let value as [Any]:
                try encode(value)
            case Optional<Any>.none:
                try encodeNil()
            default:
                let keys = JSONCodingKeys(intValue: index).map { [$0] } ?? []
                let context = EncodingError.Context(codingPath: codingPath + keys,
                                                    debugDescription: "Invalid JSON value")
                throw EncodingError.invalidValue(value, context)
            }
        }
    }

    mutating func encode(_ value: [String: Any]) throws {
        var nestedContainer = self.nestedContainer(keyedBy: JSONCodingKeys.self)
        try nestedContainer.encode(value)
    }
}
