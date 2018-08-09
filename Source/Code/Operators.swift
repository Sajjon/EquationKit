//
//  Operators.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum OperatorError: Error {
    case expectedInteger
    case expectedArrayWithTwoElements
    case expectedArrayWithThreeElements
}

enum TernaryError: Error {
    typealias ArgumentIndex = Int
    case equationArgumentLacksNumericSolution(ArgumentIndex, Equation)
    case operandArgumentLacksNumericValue(Operand)
}

public protocol Vector {}
extension Int: Vector {}
extension Double: Vector {}
extension Array: Vector where Element: Vector {
    func asTuple(choseTwo: (([Element]) -> (Element, Element)) = { ($0[0], $0[1]) }) -> (Element, Element)? {
        guard count >= 2 else { return nil }
        return choseTwo(self)
    }

    func asTripple(choseThree: (([Element]) -> (Element, Element, Element)) = { ($0[0], $0[1], $0[2]) }) -> (Element, Element, Element)? {
        guard count >= 3 else { return nil }
        return choseThree(self)
    }
}

//public struct Tuple<Value> {
//    public var first: Value
//    public var second: Value
//
//    public init(_ first: Value, _ second: Value) {
//        self.first = first
//        self.second = second
//    }
//}

public protocol OperatorRepresentation {
    var arity: Int { get }
    var function: (Vector) throws -> Vector { get }
}

extension Double {
    init?(any: Any) {
        if let double = any as? Double {
            self.init(double)
        } else if let float = any as? Float {
            self.init(float)
        } else if let integer = any as? Int {
            self.init(integer)
        } else {
            return nil
        }
    }
}

enum UnaryOperator: OperatorRepresentation {
    var arity: Int { return 1 }

    case absolute
    case squareRoot

    var function: (Vector) throws -> Vector {
        switch self {
        case .absolute: return {
            guard let scalar = $0 as? Int else { throw OperatorError.expectedInteger }
            return abs(scalar)
            }
        case .squareRoot: return {
            guard let double = Double(any: $0) else { throw OperatorError.expectedInteger }
            return sqrt(double)
            }
        }
    }
}

enum BinaryOperator: OperatorRepresentation {
    var arity: Int { return 2 }

    case add
    //    case sub
    //    case mul
    //    case div
    //    case mod
    //    case pow

    var function: (Vector) throws -> Vector {

        let transform: (Vector, (Int, Int) -> Int) throws -> (Int) = {
            guard
                let array = $0 as? [Int],
                let tuple = array.asTuple()
                else { throw OperatorError.expectedArrayWithTwoElements }
            return $1(tuple.0, tuple.1)
        }

        switch self {
        case .add: return { try transform($0) { $0 + $1 } }

            //        case .sub: return { $0[0] - $0[1] }
            //        case .mul: return { $0[0] * $0[1] }
            //        case .div: return { $0[0] / $0[1] }
            //        case .mod: return { $0[0] % $0[1] }
            //        case .pow: return { $0[0] ** $0[1] }
        }
    }
}

enum TernaryOperator: OperatorRepresentation {
    var arity: Int { return 3 }

    case modInverse(Equation, Equation, Operand)


    var function: (Vector) throws -> Vector {

        let transform: (Vector, (Int, Int, Int) -> Int) throws -> (Int) = {
            guard
                let array = $0 as? [Int],
                let tripple = array.asTripple()
                else { throw OperatorError.expectedArrayWithThreeElements }
            return $1(tripple.0, tripple.1, tripple.2)
        }

        switch self {
        case .modInverse: return { try transform($0) { multiplicativeInverseOf($0, and: $1, mod: $2) } }
        }
    }
}

enum Operators: OperatorRepresentation {
    case unary(UnaryOperator)
    case binary(BinaryOperator)
    case ternary(TernaryOperator)

    var arity: Int {
        switch self {
        case .unary(let unary): return unary.arity
        case .binary(let binary): return binary.arity
        case .ternary(let ternary): return ternary.arity
        }
    }
    var function: (Vector) throws -> Vector {
        switch self {
        case .unary(let unary): return unary.function
        case .binary(let binary): return binary.function
        case .ternary(let ternary): return ternary.function
        }
    }
}
