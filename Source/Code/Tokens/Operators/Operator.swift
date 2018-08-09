//
//  Operators.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - OperatorRepresentation
public protocol OperatorRepresentation: CustomStringConvertible {
    var arity: Int { get }
    var precedence: Precedence { get }
    var associativity: Associativity { get }
}

public protocol StoredArgumentOperator: OperatorRepresentation {
    var function: () throws -> Vector { get }
}
public protocol ArgumentPassingOperator: OperatorRepresentation {
    var function: (Vector) throws -> Vector { get }
}

// MARK: - Operator
public enum Operator {
    case unary(UnaryOperator)
    case binary(BinaryOperator)
    case ternary(TernaryOperator)
}

// MARK: - OperatorRepresentation
extension Operator: OperatorRepresentation {}
public extension Operator {
    var arity: Int {
        switch self {
        case .unary(let unary): return unary.arity
        case .binary(let binary): return binary.arity
        case .ternary(let ternary): return ternary.arity
        }
    }

    var precedence: Precedence {
        switch self {
        case .unary(let unary): return unary.precedence
        case .binary(let binary): return binary.precedence
        case .ternary(let ternary): return ternary.precedence
        }
    }


    var associativity: Associativity {
        switch self {
        case .unary(let unary): return unary.associativity
        case .binary(let binary): return binary.associativity
        case .ternary(let ternary): return ternary.associativity
        }
    }

//    var function: (Vector) throws -> Vector {
//        switch self {
//        case .unary(let unary): return unary.function
//        case .binary(let binary): return binary.function
//        case .ternary(let ternary): return {}
//        }
//    }
}

public extension Operator {
    var asUnary: UnaryOperator? {
        switch self {
        case .unary(let unary): return unary
        default: return nil
        }
    }

    var isUnary: Bool {
        return asUnary != nil
    }

    var asBinary: BinaryOperator? {
        switch self {
        case .binary(let binary): return binary
        default: return nil
        }
    }

    var isBinary: Bool {
        return asBinary != nil
    }

    var asTernary: TernaryOperator? {
        switch self {
        case .ternary(let ternary): return ternary
        default: return nil
        }
    }

    var isTernary: Bool {
        return asTernary != nil
    }
}

// MARK: - CustomStringConvertible
public extension Operator {
    public var description: String {
        switch self {
        case .unary(let unary): return unary.description
        case .binary(let binary): return binary.description
        case .ternary(let ternary): return ternary.description
        }
    }
}
