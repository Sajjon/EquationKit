//
//  PolynomialProtocol+Contains.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-03.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

//public extension PolynomialProtocol {
//    func contains(other: Self) -> Bool {
//        
//    }
//}

//public extension Algebraic {
//    func contains<A>(_ algebraic: A) -> Bool where A: Algebraic {
//        fatalError()
//    }
//}
//
//public extension PolynomialProtocol {
//    func contains<A>(_ algebraic: A) -> Bool where A: Algebraic {
//        if algebraic is VariableExpressible || algebraic is ExponentiationExpressible || algebraic is TermExpressible {
//            return terms.map { $0.contains(algebraic) }.filter { $0 == true }.isEmpty
//        } else if let polynomial = algebraic as? PolynomialType<NumberType> {
//            fatalError()
//            // `4x²y² + 4y`.contains(2y) -> TRUE
//            // `4x²y² + 4y`.contains(2y + 100) -> FALSE
//            // `4x²y² + 4y + 200`.contains(2y + 100) -> FALSE
//            for term in polynomial.terms {
//                if self.contains(term)  }
//
//            }
//        } else {
//            fatalError("incorrect implementation")
//        }
//    }
//}
//
//public extension TermProtocol {
//    func contains<A>(_ algebraic: A) -> Bool where A: Algebraic {
//        if algebraic is VariableExpressible || algebraic is ExponentiationExpressible {
//            return exponentiations.map { $0.contains(algebraic) }.filter { $0 == true }.isEmpty
//        } else if let term = algebraic as? TermStruct<ExponentiationStruct<NumberType>> {
//            // SELF.contains(term)
//            // 4x²y².contains(3x²y²) -> TRUE
//            // 4x²y².contains(3x²y) -> TRUE
//            // 4x²y².contains(3xy) -> TRUE
//            // 3x²y².contains(4x²y²) -> FALSE
//            // 3x²y².contains(4x²y) -> FALSE
//            // 3x²y².contains(4xy) -> FALSE
//            // 3x²y².contains(z) -> FALSE
//
//            // NEGATIVE COEFFICENTS
//            // 4x²y².contains(3xy) -> TRUE
//            for exp in term.exponentiations {
//                guard self.contains(exp) else { return false }
//            }
//            switch (coefficient.isPositive, term.coefficient.isPositive) {
//            case (true, true), (false, false):
//                let a = coefficient.absolute()
//                let b = term.coefficient.absolute()
//                return a >= b && a.gcd(other: b) != .one // TODO DIVISION replace gcd when division is supported.
//            default: return false // any combination of NEG-POS and POS-NEG coefficents is not supported right now
//            }
//        } else {
//            return false
//        }
//    }
//}
//
//public extension ExponentiationProtocol {
//    func contains<A>(_ algebraic: A) -> Bool where A: Algebraic {
//        if algebraic is VariableExpressible {
//            return variable.contains(algebraic)
//        } else if let exponentiation = algebraic as? ExponentiationStruct<NumberType>  {
//            // x².contains(x²) -> TRUE
//            // x³.contains(x²) -> TRUE
//            // x².contains(x³) -> FALSE
//            guard exponentiation.variable == variable, exponent >= exponentiation.exponent else { return false }
//            return true
//        } else {
//            return false
//        }
//    }
//}
//
//public extension VariableProtocol {
//    func contains<A>(_ algebraic: A) -> Bool where A: Algebraic {
//        guard let other = algebraic as? VariableStruct<NumberType> else { return false }
//        return other.name == name
//    }
//}
