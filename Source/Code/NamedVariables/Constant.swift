//
//  Constant.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol ConstantExpressible: NumberTypeSpecifying {
    var asConstant: NumberType? { get }
}

public protocol ConstantProtocol: NamedVariable, ConstantExpressible {
    var name: String { get }
    var value: NumberType { get }
    init(name: String, value: NumberType)

    func toVariable() -> VariableStruct<NumberType>
}

// MARK: - Default Implementation
public extension ConstantProtocol {
    func toVariable() -> VariableStruct<NumberType> {
        return VariableStruct<NumberType>(name)
    }
}

// MARK: - CustomStringConvertible
public extension ConstantProtocol {
    var description: String {
        return "<\(name)=\(value.shortFormat)>"
    }
}

public extension ConstantProtocol {
    var asConstant: NumberType? { return value }
}

// MARK: - Convenience Initializers
public extension ConstantProtocol {

    init(_ variable: VariableStruct<NumberType>, value: NumberType) {
        self.init(name: variable.name, value: value)
    }
}

public extension ConstantProtocol where NumberType: FloatingPointNumberExpressible {
    init(_ variable: VariableStruct<NumberType>, value: Int) {
        self.init(variable, value: NumberType(Double(value)))
    }
}

// MARK: - ConstantStruct
public struct ConstantStruct<Number: NumberExpressible>: ConstantProtocol {
    public typealias NumberType = Number
    public let name: String
    public let value: NumberType
    public init(name: String, value: NumberType) {
        self.name = name
        self.value = value
    }
}

