//
//  EquationRepresentation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NumericConververtible: CustomStringConvertible {
//    func solveNumeric<SN>() -> SN? where SN: SignedNumeric
    func solveNumeric() -> Int?
    func hasNumericSolution() -> Bool
}

public protocol EquationRepresentation: NumericConververtible, Equatable {
    associatedtype Token: TokenRepresentation
    var tokens: [Token] { get }
    func trimmed() -> Self
    func toInfixNotation() -> InfixNotation
    func toReversePolishNotation() -> ReversePolishNotation
}

public extension EquationRepresentation {
    func trimmed() -> Self {
        return self
    }

    func hasNumericSolution() -> Bool {
        return !tokens.containsUnsetVariable()
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

extension Array where Element: TokenRepresentation {
    func containsUnsetVariable() -> Bool {
        return filter { $0.isUnsetVariable }.isEmpty == false
    }
}
