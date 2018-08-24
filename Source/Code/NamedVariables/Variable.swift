//
//  Variable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol VariableProtocol: NamedVariable, Concatenating, NumberTypeSpecifying { // Solvable
    init(_ name: String)
}

public typealias Variable = VariableStruct<Double>

public struct VariableStruct<Number: NumberExpressible>: VariableProtocol {
    public typealias NumberType = Number
    public let name: String

    public init(_ name: String) {
        self.name = name
    }
}

// MARK: - Solvable
//public extension VariableProtocol {
//    func solve(constants: Set<ConstantStruct<Self>>, modulus: NumberType?, modulusMode: ModulusMode) -> NumberType? {
////        guard let constant = constants.first(where: { $0.toVariable() == self }) else { return nil }
////        return constant.value
//        fatalError()
//    }
//}
//
//// MARK: - Differentiatable
//public extension VariableProtocol {
//    func differentiateWithRespectTo(_ variableToDifferentiate: Self) -> PolynomialStruct<NumberType>? {
//        fatalError()
////        guard variableToDifferentiate == self else { return nil }
////        return self
//    }
//}
