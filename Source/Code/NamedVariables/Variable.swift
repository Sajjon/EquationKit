//
//  Variable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol VariableProtocol: NamedVariable, Algebraic {
    init(_ name: String)
}

public struct VariableStruct<Number: NumberExpressible>: VariableProtocol {
    public typealias NumberType = Number
    public let name: String

    public init(_ name: String) {
        self.name = name
    }
}

// MARK: - Solvable
public extension VariableProtocol {
    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
        guard let constant = constants.first(where: { $0.toVariable().name == self.name }) else { return nil }
        return constant.value
    }
}

// MARK: - Differentiatable
public extension VariableProtocol {
    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> Polynomial<NumberType>? {
        fatalError()
//        guard variableToDifferentiate == self else { return nil }
//        return self
    }
}
