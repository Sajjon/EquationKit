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

// MARK: - Substitution
public extension VariableProtocol {
    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Substitution<NumberType> {
        guard let constant = constants.first(where: { $0 == self }) else { return .algebraic(self) }
        return .constant(constant.value)
    }
}


// MARK: - Solvable
public extension VariableProtocol {

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return Set([self as! VariableStruct<NumberType>])
    }

    func findRoots(constants: Set<ConstantStruct<NumberType>>) -> Set<ConstantStruct<NumberType>> {
        guard let constant = constants.first(where: { $0.toVariable() == self }) else { return Set() }
        return Set([ConstantStruct<NumberType>(name: self.name, value: constant.value)])
    }
}

// MARK: - Differentiatable
public extension VariableProtocol {
    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> PolynomialType<NumberType>? {
        guard variableToDifferentiate == self else { return nil }
        // actually this is never used.... but makes us able to distinguish between
        // doing `exponentiations.append(exponentiation)` and doing
        // nothing in differentiation in TermProtocol
        return PolynomialType(constant: .one)
    }
}
