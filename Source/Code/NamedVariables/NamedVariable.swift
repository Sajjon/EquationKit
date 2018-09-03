//
//  NamedVariable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NamedVariable: NumberTypeSpecifying, CustomStringConvertible, Hashable, Comparable {
    var name: String { get }
    static func == <N>(lhs: N, rhs: Self) -> Bool where N: NamedVariable, N.NumberType == Self.NumberType
//    static func == (lhs: PolynomialType<NumberType>, rhs: Self) -> Bool
}

public extension NamedVariable {
    static func == <N>(lhs: N, rhs: Self) -> Bool where N: NamedVariable, N.NumberType == Self.NumberType {
        return lhs.name == rhs.name
    }

//    static func == (lhs: PolynomialType<NumberType>, rhs: Self) -> Bool {
//        guard
//            let term = lhs.terms.first,
//            lhs.terms.count == 1,
//            let exp = term.exponentiations.first,
//            term.exponentiations.count == 1,
//            exp.variable
//    }
//
//    static func == (lhs: Self, rhs: PolynomialType<NumberType>) -> Bool {
//        return rhs == lhs
//    }
}

// MARK: - Equatable
public extension NamedVariable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - Comparable
public extension NamedVariable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.name < rhs.name
    }
}

// MARK: - Hashable
public extension NamedVariable {
    var hashValue: Int {
        return name.hashValue
    }
}

// MARK: - CustomStringConvertible
public extension NamedVariable {
    var description: String {
        return name
    }
}
