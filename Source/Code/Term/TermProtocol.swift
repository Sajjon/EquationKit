//
//  TermProtocol.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol TermProtocol:
    Algebraic,
    Negatable,
    Comparable,
    CustomDebugStringConvertible
    where
    ExponentiationType.NumberType == Self.NumberType
{

    associatedtype ExponentiationType: ExponentiationProtocol

    var coefficient: NumberType { get }
    var exponentiations: [ExponentiationType] { get }

    init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm<NumberType>], coefficient: NumberType)

}

// MARK: - Convenience Initializers
public extension TermProtocol {
    init(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm<NumberType>] = SortingWithinTerm<NumberType>.defaultArray, coefficient: NumberType = .one) {
        self.init(exponentiations: exponentiations, sorting: sorting, coefficient: coefficient)
    }

    init(exponentiation: ExponentiationType, coefficient: NumberType = .one) {
        self.init(exponentiations: [exponentiation], coefficient: coefficient)
    }

    init(_ exponentiations: ExponentiationType..., coefficient: NumberType = .one) {
        self.init(exponentiations: exponentiations, coefficient: coefficient)
    }


    init(_ variable: VariableStruct<NumberType>) {
        self.init(exponentiation: ExponentiationType(variable))
    }

    init(_ variables: [VariableStruct<NumberType>]) {
        self.init(exponentiations: variables.map { ExponentiationType($0) })
    }

    init(_ variables: VariableStruct<NumberType>...) {
        self.init(variables)
    }

}

// MARK: - Public Extensions
public extension TermProtocol {
    var isNegative: Bool {
        return coefficient.isNegative
    }

    func contains(variable: VariableStruct<NumberType>) -> Bool {
        return exponentiations.map { $0.variable }.contains(variable)
    }
}

// MARK: - Internal Extensions
internal extension TermProtocol {

    var signString: String {
        return isNegative ? "-" : "+"
    }

    var highestExponent: NumberType {
        return exponentiations.sorted(by: .descendingExponent)[0].exponent
    }

    var variableNames: String {
        return exponentiations.map { $0.variable.name }.joined()
    }
}
