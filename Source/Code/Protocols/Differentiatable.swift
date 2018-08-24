//
//  Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NumberTypeSpecifying {
    associatedtype NumberType: NumberExpressible
}

public protocol VariableTypeSpecifying {
    associatedtype VariableType: VariableProtocol
}
public protocol Differentiatable: VariableTypeSpecifying {//where PolynomialType.TermType.ExponentiationType.VariableType == Self.VariableType {
    associatedtype PolynomialType: PolynomialProtocol
    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> PolynomialType?

}

// MARK: - Differentiatable
//extension Polynomial: Differentiatable {}
public extension PolynomialProtocol {


    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> Self? {
        fatalError()
//        guard contains(variable: variableToDifferentiate) else { return Self(constant: NumberType.zero) }
//        var terms = [TermType]()
//        var constant: NumberType = .zero
//        for term in self.terms {
//            let differentiatedTerm = term.differentiateWithRespectTo(variableToDifferentiate)
//            if differentiatedTerm.terms.isEmpty && differentiatedTerm.constant != 0 {
//                constant += differentiatedTerm.constant
//            } else if !differentiatedTerm.terms.isEmpty && differentiatedTerm.constant == 0 {
//                terms.append(contentsOf: differentiatedTerm.terms)
//            } else {
//                fatalError("should not happen")
//            }
//        }
//        return Self(terms: terms, constant: constant)
    }
}

public extension NumberExpressible {
    var isZero: Bool {
        return self == .zero
    }
}

// MARK: - Differentiatable
//extension Term: Differentiatable {}
public extension TermProtocol {

    //    public enum DifferentiationResult {
    //        case constant(Double)
    //        case term(Term)
    //    }

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> PolynomialType? {
        fatalError()
//        guard contains(variable: variableToDifferentiate) else { return PolynomialType(constant: 0) }
//
//                var exponentiations = [ExponentiationType]()
//                var coefficient = self.coefficient
//                var coefficientFromConstants: NumberType = 1
//                for exponentiation in self.exponentiations {
//                    guard let differentiationResult = exponentiation.differentiateWithRespectTo(variableToDifferentiate) else { exponentiations.append(exponentiation); continue }
////                    switch differentiationResult {
////                    case .constant(let differentiationConstant):
////                        coefficientFromConstants *= differentiationConstant
////                    case .exponentiation(let differentiationCoefficient, let differentiationExponentiation):
////                        if let differentiationCoefficient = differentiationCoefficient {
////                            coefficient *= differentiationCoefficient
////                        }
////                        exponentiations.append(differentiationExponentiation)
////                    }
//
//                    if differentiationResult.terms.isEmpty && differentiationResult.constant.isZero {
//                        exponentiations.append(exponentiation)
//                    } else if differentiationResult.terms.isEmpty && !differentiationResult.constant.isZero {
//                         coefficientFromConstants *= differentiationResult.constant
//                    } else if !differentiationResult.terms.isEmpty && !differentiationResult.constant.isZero {
//                        if !differentiationResult.constant.isZero {
//
//                        }
//                    }
//                }
//
//                let multiplied = coefficient * coefficientFromConstants
//
//                if exponentiations.count == 0 {
//                    return PolynomialType(constant: multiplied)
//        //            return .constant(coefficient * coefficientFromConstants) // ORIGINAL
//                } else {
//                    let term = Self(exponentiations: exponentiations, coefficient: multiplied)
////                    let termCasted:  term as! PolynomialStruct<NumberType>.TermType
//        //            return .term(term)
//                    return PolynomialType(terms: [term], sorting: TermSorting.default, constant: .zero)
//                }

    }

}

// MARK: - Differentiatable
//extension Exponentiation: Differentiatable {}
public extension ExponentiationProtocol {

    func differentiateWithRespectTo(_ variableToDifferentiate: VariableType) -> PolynomialType? {
        fatalError()
//        guard variableToDifferentiate == variable else { return PolynomialType(exponentiation: self) }
//        let exponentPriorToDifferentiation = self.exponent
//        let exponent = exponentPriorToDifferentiation - 1
//        guard exponent > 0 else {
//            return PolynomialType(constant: NumberType.one)
//            //            return .constant(1)
//        }
//
//        //        return .exponentiation(coefficient: exponentPriorToDifferentiation, exponentiation: Exponentiation(variable, exponent: exponent))
//
//        let exponentiation = Self(variable, exponent: exponent)
//
//        let term = PolynomialType.TermType(exponentiation: exponentiation, coefficient: exponentPriorToDifferentiation)
//
//        return PolynomialType(term: term)
    }

}
