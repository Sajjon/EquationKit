//
//  Unary.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum UnaryOperator {
    case absolute(NumericConververtible)
    case squareRoot(NumericConververtible)
}

extension UnaryOperator: StoredArgumentOperator {}
public extension UnaryOperator {
    var arity: Int { return 1 }

    var precedence: Precedence { return .unary }
    var associativity: Associativity { return .none }

    var function: () throws -> Vector {

        func transform<T>(_ numeric: NumericConververtible, transform: (Int) -> T, function: (T) -> Vector) throws -> (Vector) {
            guard let integer = numeric.solveNumeric() else { throw StoredArgumentOperatorError.argumentLacksNumericSolution(0, numeric) }
            return function(transform(integer))
        }

        //        switch self {
        //        case .absolute(let operand): return {
        //            guard let value = operand.value else { throw StoredArgumentOperatorError.operandArgumentLacksNumericValue(operand) }
        //            return abs(value)
        //            }
        //        case .squareRoot(let operand): return {
        //            guard let value = operand.value else { throw StoredArgumentOperatorError.operandArgumentLacksNumericValue(operand) }
        //            return sqrt(Double(value))
        //            }
        //        }

        switch self {
        case .absolute(let numeric): return { try transform(numeric, transform: { $0 }) { abs($0) } }
        case .squareRoot(let numeric): return { try transform(numeric, transform: { Double($0) }) { Int(sqrt($0)) } }
        }
    }
}

// MARK: - CustomStringConvertible
public extension UnaryOperator {
    public var description: String {
        switch self {
        case .absolute(let numeric): return "abs(\(numeric.description))"
        case .squareRoot(let numeric): return "sqrt(\(numeric.description))"
        }
    }
}
