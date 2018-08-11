//
//  Binary.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum BinaryOperator {
    case add
    case sub
    case mul
    case div
    case mod
    case pow
}

extension BinaryOperator: ArgumentPassingOperator {}
public extension BinaryOperator {
    var arity: Int { return 2 }

    var function: (Vector) throws -> Vector {

        let transform: (Vector, (Int, Int) -> Int) throws -> (Int) = {
            guard
                let array = $0 as? [Int],
                let tuple = array.asTuple()
                else { throw BinaryOperatorError.expectedArrayWithTwoElements }
            return $1(tuple.0, tuple.1)
        }

        switch self {
        case .add: return { try transform($0) { $0 + $1 } }
        case .sub: return { try transform($0) { $0 - $1 } }
        case .mul: return { try transform($0) { $0 * $1 } }
        case .div: return { try transform($0) { $0 / $1 } }
        case .mod: return { try transform($0) { modulus($0, modulus: $1) } }
        case .pow: return { try transform($0) { $0 ** $1 } }
        }
    }
    
    var associativity: Associativity {
        switch self {
        case .pow: return .right
        default: return .left
        }
    }

    var precedence: Precedence {
        switch self {
        case .add: return .addition
        case .sub: return .addition
        case .mul: return .multiplication
        case .div: return .multiplication
        case .mod: return .multiplication
        case .pow: return .power
        }
    }
}


// MARK: - CustomStringConvertible
public extension BinaryOperator {
    var description: String {
        switch self {
        case .add: return "＋"
        case .sub: return "－"
        case .mul: return "·"
        case .div: return "୵"
        case .mod: return "％"
        case .pow: return "＾"
        }
    }
}

enum BinaryOperatorError: Error {
    case expectedArrayWithTwoElements
}
