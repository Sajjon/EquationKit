//
//  Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// *****************************************
///         NOT IMPLEMENTED YET
/// *****************************************

public enum Solution<Number: NumberExpressible>: NumberTypeSpecifying {
    public typealias NumberType = Number

    case roots(Set<ConstantStruct<NumberType>>)
    case number(NumberType)
}

public protocol Solvable: Substitutionable {
    func solve(constants: Set<ConstantStruct<NumberType>>) -> Solution<NumberType>

    /// Might have a look at Sympys solver: https://github.com/sympy/sympy/blob/master/sympy/solvers/solvers.py#L450-L1349
    func findRoots(constants: Set<ConstantStruct<NumberType>>) -> Set<ConstantStruct<NumberType>>
}

public extension Solvable {

    func solve(constants: Set<ConstantStruct<NumberType>>) -> Solution<NumberType> {
        let variablesPassed = Set<VariableStruct<NumberType>>(constants.map { $0.toVariable() })

        if variablesPassed.isSuperset(of: uniqueVariables) {
            fatalError()
//            return .number(evaluate(constants: constants)!)
        } else {
            return .roots(findRoots(constants: constants))
        }
    }
}

public extension Set where Element: ConstantProtocol {
    func toVariables() -> [VariableStruct<Element.NumberType>: Element.NumberType] {
        let array: [(VariableStruct<Element.NumberType>, Element.NumberType)] = self.map { ($0.toVariable(), $0.value) }
        let dictionary: [VariableStruct<Element.NumberType>: Element.NumberType] = array.reduce(into: [:]) { $0[$1.0] = $1.1 }
        return dictionary
    }
}
public extension ExponentiationProtocol {

    func findRoots(constants: Set<ConstantStruct<NumberType>>) -> Set<ConstantStruct<NumberType>> {
        fatalError()
    }
}
// MARK: - Solvable
public extension TermProtocol {

    func findRoots(constants: Set<ConstantStruct<NumberType>>) -> Set<ConstantStruct<NumberType>> {
        fatalError()
    }
}


// MARK: - Solvable
public extension PolynomialProtocol {

    func findRoots(constants: Set<ConstantStruct<NumberType>>) -> Set<ConstantStruct<NumberType>> {
        fatalError()
    }
}
