//
//  Equation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Equation {

    public var infix: [Token]

    public init(infix: [Token]) {
        self.infix = infix
    }

}

public extension Equation {
    func evaluate() -> Int? {
        guard isSolvable() else { return nil }
        let tokens = reversePolishNotationFrom(infix: infix)
        return ReversePolishNotation.evaluate(tokens)
    }

    func isSolvable() -> Bool {
        return !containsUnsetVariables()
    }

    func containsUnsetVariables() -> Bool {
        return !infix.filter { $0.isUnsetVariable }.isEmpty
    }

    func differentiate() -> Equation {
        fatalError("todo")
    }
}

// MARK: - Convenience Initializers
public extension Equation {
    init(infix terms: [Term]) {
        self.infix = terms.flatMap { $0.toTokens() }
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Equation: ExpressibleByArrayLiteral {}
public extension Equation {
    init(arrayLiteral elements: Token...) {
        self.init(infix: elements)
    }
}

// MARK: - CustomStringConvertible
extension Equation: CustomStringConvertible {}
public extension Equation {
    var description: String {
        return infix.map { $0.description }.joined(separator: " ")
    }
}
