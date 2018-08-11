//
//  Ternary.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum TernaryOperator {
    case modInverse(NumericConververtible, NumericConververtible, NumericConververtible)
}

extension TernaryOperator: StoredArgumentOperator {}
public extension TernaryOperator {

    var arity: Int { return 3 }

    var associativity: Associativity {
        return .none
    }

    var precedence: Precedence {
        return .function
    }

    var function: () throws -> Vector {
        switch self {
        case .modInverse(let eq0, let eq1, let mod):
            return {
                guard let n0 = eq0.solveNumeric() else { throw StoredArgumentOperatorError.argumentLacksNumericSolution(0, eq0) }
                guard let n1 = eq1.solveNumeric() else { throw StoredArgumentOperatorError.argumentLacksNumericSolution(1, eq1) }
                guard let p = mod.solveNumeric() else { throw StoredArgumentOperatorError.argumentLacksNumericSolution(2, mod) }
                return multiplicativeInverseOf(n0, and: n1, mod: p)
            }
        }
    }
}

// MARK: - CustomStringConvertible
public extension TernaryOperator {
    var description: String {
        switch self {
        case .modInverse(let eq0, let eq1, let mod): return "modInverse(\(eq0.description), \(eq1.description), mod: \(mod.description))"
        }
    }
}

enum StoredArgumentOperatorError: Error {
    typealias ArgumentIndex = Int
    case argumentLacksNumericSolution(ArgumentIndex, NumericConververtible)
}
