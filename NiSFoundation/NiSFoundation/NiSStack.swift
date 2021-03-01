//
//  NiSStack.swift
//  NiSLogger
//
//  Created by nine99p on 2021/02/13.
//

import Foundation

public struct NiSStack<T> {
    private var elements = [T]()
    public var Elements : [T] {
        get { return elements }
    }
    
    public var Count: Int {
        get {
            return self.elements.count
        }
    }
    
    public var IsEmpty: Bool {
        get {
            return self.elements.isEmpty
        }
    }
    
    public mutating func pop() -> T?
    {
        return self.elements.popLast()
    }
    
    public mutating func push(_element: T)
    {
        self.elements.append(_element)
    }
    
    public func peek() -> T?
    {
        return self.elements.last
    }
}

extension NiSStack : CustomStringConvertible, ExpressibleByArrayLiteral
{
    //public typealias ArrayLiteralElement = <#type#>
    // 외부 파일로 뺐더니 private 를 억세스 하지 못 하더라...
    
    public init(arrayLiteral fromElements: T...)
    {
        self.init()
        for element in fromElements
        {
            self.elements.append(element)
        }
    }
    
    public var description: String {
        return self.elements.description
    }
}
