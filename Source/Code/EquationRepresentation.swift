//
//  EquationRepresentation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol EquationRepresentation: CustomStringConvertible, Equatable {
    associatedtype Token: TokenRepresentation
    var tokens: [Token] { get }

    func trimmed() -> Self
    func hasNumericSolution() -> Bool
    func solveNumeric() -> Int?
    func toInfixNotation() -> InfixNotation
    func toReversePolishNotation() -> ReversePolishNotation
}

public extension EquationRepresentation {
    func trimmed() -> Self {
        return self
    }

    func hasNumericSolution() -> Bool {
        return tokens.filter { $0.isUnsetVariable }.isEmpty
    }

    var description: String {
        return tokens.map { $0.description }.joined(separator: " ")
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        if let lhsSolution = lhs.solveNumeric(), let rhsSolution = rhs.solveNumeric() {
            return lhsSolution == rhsSolution
        } else {
            return lhs.trimmed().description == rhs.trimmed().description
        }
    }
}
