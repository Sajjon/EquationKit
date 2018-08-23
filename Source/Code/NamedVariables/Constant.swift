//
//  Constant.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol ConstantProtocol: NamedVariable {
    associatedtype NumberType: NumberExpressible
    var name: String { get }
    var value: NumberType { get }
    init(name: String, value: NumberType)

    func toVariable() -> Variable
}

// MARK: - Convenience Initializers
public extension ConstantProtocol {

    init(variable: Variable, value: NumberType) {
        self.init(name: variable.name, value: value)
    }

    init(_ variable: Variable, value: Double) {
        self.init(variable: variable, value: NumberType(value))
    }

    init(_ variable: Variable, value: Int) {
        self.init(variable: variable, value: NumberType(value))
    }
}

// MARK: - Public
public extension ConstantProtocol {
    func toVariable() -> Variable {
        return Variable(name)
    }
}

// MARK: - CustomStringConvertible
public extension ConstantProtocol {
    var description: String {
        return "<\(name)=\(value.shortFormat)>"
    }
}

public struct ConstantStruct<Number: NumberExpressible>: ConstantProtocol {
    public typealias NumberType = Number
    public let name: String
    public let value: NumberType
    public init(name: String, value: NumberType) {
        self.name = name
        self.value = value
    }
}

public typealias Constant = ConstantStruct<Double>
