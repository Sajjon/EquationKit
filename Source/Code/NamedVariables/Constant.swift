//
//  Constant.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol ConstantProtocol: NamedVariable, VariableTypeSpecifying {
//    associatedtype NumberType: NumberExpressible
    var name: String { get }
    var value: VariableType.NumberType { get }
    init(name: String, value: VariableType.NumberType)

    func toVariable() -> VariableType//VariableStruct<NumberType>
}

// MARK: - Convenience Initializers
public extension ConstantProtocol {

    init(variable: VariableType, value: VariableType.NumberType) {
        self.init(name: variable.name, value: value)
    }

    init(_ variable: VariableType, value: Double) {
        self.init(variable: variable, value: VariableType.NumberType(value))
    }

    init(_ variable: VariableType, value: Int) {
        self.init(variable: variable, value: VariableType.NumberType(value))
    }
}

// MARK: - Public
public extension ConstantProtocol {
    func toVariable() -> VariableType { //VariableStruct<NumberType> {
        return VariableType(name)
    }
}

// MARK: - CustomStringConvertible
public extension ConstantProtocol {
    var description: String {
        return "<\(name)=\(value.shortFormat)>"
    }
}

public struct ConstantStruct<Variable_: VariableProtocol>: ConstantProtocol {
    public typealias VariableType = Variable_
    public let name: String
    public let value: VariableType.NumberType
    public init(name: String, value: VariableType.NumberType) {
        self.name = name
        self.value = value
    }
}

public typealias Constant = ConstantStruct<VariableStruct<Double>>
