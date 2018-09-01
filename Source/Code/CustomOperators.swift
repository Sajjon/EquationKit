//
//  CustomOperators.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

precedencegroup ExponentiationPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left
}

infix operator ^^: ExponentiationPrecedence


internal func += <N>(lhs: inout N?, rhs: N) where N: Numeric {
    if let lhsIndeed = lhs {
        lhs = lhsIndeed + rhs
    } else {
        lhs = rhs
    }
    if lhs == 0 {
        lhs = nil
    }
}

public struct NumberAndConstants<Number: NumberExpressible> {

    public let number: Number
    public let constants: Set<ConstantStruct<Number>>
    public init(number: Number, constants: Set<ConstantStruct<Number>>) {
        self.number = number
        self.constants = constants
    }

}
public extension NumberAndConstants {
    public init(number: Number, constants: [ConstantStruct<Number>]) {
        guard !constants.containsDuplicates() else { fatalError("Constants array should not contain duplicates") }
        self.init(number: number, constants: Set(constants))
    }
}

public typealias EvaluationOperand<N: NumberExpressible> = NumberAndConstants<N>
public extension EvaluationOperand {
    var reference: Number { return number }
}

public typealias ModularEvaluationOperand<N: NumberExpressible> = NumberAndConstants<N>
public extension ModularEvaluationOperand {
    var modulus: Number { return number }
}

public struct CongruentEqualityOperand<Number: NumberExpressible> {
    public let scalar: Number
    public let modulus: Number
    public let constants: Set<ConstantStruct<Number>>

    public init(scalar: Number, modulus: Number, constants: Set<ConstantStruct<Number>>) {
        self.scalar = scalar
        self.modulus = modulus
        self.constants = constants
    }
}

public extension CongruentEqualityOperand {
    public init(scalar: Number, modulusConstants: ModularEvaluationOperand<Number>) {
        self.init(scalar: scalar, modulus: modulusConstants.modulus, constants: modulusConstants.constants)
    }
}

//public func <- <N>(reference: N, makeConstants: () -> [ConstantStruct<N>]) -> EvaluationOperand<N> {
//    return EvaluationOperand(number: reference, constants: Set(makeConstants()))
//}

public func == <N>(polynomial: PolynomialType<N>, evaluationOperand: EvaluationOperand<N>) -> Bool {
    return polynomial.evaluate(constants: evaluationOperand.constants) == evaluationOperand.reference
}
public func != <N>(polynomial: PolynomialType<N>, evaluationOperand: EvaluationOperand<N>) -> Bool {
    return !(polynomial == evaluationOperand)
}

infix operator ≠: AssignmentPrecedence
public func ≠ <N>(polynomial: PolynomialType<N>, evaluationProxy: EvaluationOperand<N>) -> Bool {
    return polynomial != evaluationProxy
}

infix operator =%=: AssignmentPrecedence
public func =%= <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial.evaluate(constants: congruence.constants, modulus: congruence.modulus) == congruence.scalar
}

infix operator ≡≡: AssignmentPrecedence
public func ≡≡ <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial =%= congruence
}

infix operator =!%=: AssignmentPrecedence
public func =!%= <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return !(polynomial ≡≡ congruence)
}

infix operator !≡: AssignmentPrecedence
public func !≡ <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial =!%= congruence
}

infix operator ≢: AssignmentPrecedence
public func ≢ <N>(polynomial: PolynomialType<N>, congruence: CongruentEqualityOperand<N>) -> Bool {
    return polynomial !≡ congruence
}


public func % <N>(scalar: N, modulusConstants: ModularEvaluationOperand<N>) -> CongruentEqualityOperand<N> {
    return CongruentEqualityOperand(scalar: scalar, modulusConstants: modulusConstants)
}


infix operator <--: BitwiseShiftPrecedence
public func <-- <N>(number: N, constants: [ConstantStruct<N>]) -> NumberAndConstants<N> {
    return NumberAndConstants(number: number, constants: constants)
}

infix operator ↤: BitwiseShiftPrecedence
public func ↤ <N>(modulus: N, constants: [ConstantStruct<N>]) -> NumberAndConstants<N> {
    return modulus <-- constants
}

//public func <-- <N>(scalar: N, constants: [ConstantStruct<N>]) -> EvaluationOperand<N> {
//    guard !constants.containsDuplicates() else { fatalError("Constants array should not contain duplicates") }
//    return EvaluationOperand(scalar: scalar, constants: Set(constants))
//}
//public func ↤ <N>(scalar: N, constants: [ConstantStruct<N>]) -> EvaluationOperand<N> {
//    return scalar <-- constants
//}
