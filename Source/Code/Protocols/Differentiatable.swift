//
//  Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

//public protocol Differentiatable {
//    associatedtype PolynomialType: PolynomialProtocol
//    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> PolynomialType?
//
//}

// MARK: - Differentiatable
//extension Polynomial: Differentiatable {}
public extension PolynomialProtocol {


    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> Void {
        fatalError()
        //        guard contains(variable: variableToDifferentiate) else { return Polynomial(terms: [], constant: 0) }
        //        var terms = [Term]()
        //        var constant: Double = 0
        //        for term in self.terms {
        //            guard let differentiatedTerm = term.differentiateWithRespectTo(variableToDifferentiate) else { continue }
        //            switch differentiatedTerm {
        //            case .constant(let differentiatedConstant): constant += differentiatedConstant
        //            case .term(let differentiatedTerm): terms.append(differentiatedTerm)
        //            }
        //        }
        //        return Polynomial(terms: terms, constant: constant)
    }
}
// MARK: - Differentiatable
//extension Term: Differentiatable {}
public extension TermProtocol {

    //    public enum DifferentiationResult {
    //        case constant(Double)
    //        case term(Term)
    //    }

    //    public typealias PolynomialType =

    /// Returns the differentiated term with respect to the input variable, if this term does not contain said variable, then this method returns `nil`
    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> Void {
        fatalError()
        //
        //        guard contains(variable: variableToDifferentiate) else { return nil }
        //
        //        var exponentiations = [ExponentiationType]()
        //        var coefficient = self.coefficient
        //        var coefficientFromConstants: NumberType = 1
        //        for exponentiation in self.exponentiations {
        //            guard let differentiationResult = exponentiation.differentiateWithRespectTo(variableToDifferentiate) else { exponentiations.append(exponentiation); continue }
        //            switch differentiationResult {
        //            case .constant(let differentiationConstant):
        //                coefficientFromConstants *= differentiationConstant
        //            case .exponentiation(let differentiationCoefficient, let differentiationExponentiation):
        //                if let differentiationCoefficient = differentiationCoefficient {
        //                    coefficient *= differentiationCoefficient
        //                }
        //                exponentiations.append(differentiationExponentiation)
        //            }
        //        }
        //
        //        let multiplied = coefficient * coefficientFromConstants
        //
        //        if exponentiations.count == 0 {
        //            return PolynomialStruct<NumberType>(constant: multiplied)
        ////            return .constant(coefficient * coefficientFromConstants) // ORIGINAL
        //        } else {
        //            let term = Self(exponentiations: exponentiations, coefficient: multiplied)
        //            let termCasted: PolynomialStruct<NumberType>.TermType = term as! PolynomialStruct<NumberType>.TermType
        ////            return .term(term)
        //            return PolynomialStruct<NumberType>(terms: [termCasted], sorting: TermSorting.default, constant: .zero)
        //        }

    }

}

// MARK: - Differentiatable
//extension Exponentiation: Differentiatable {}
public extension ExponentiationProtocol {

    //    public typealias DifferentiationResult =

    /// Returns the differentiated variable and its coefficient with respect to the input variable, if this variable does not equal said variable, then this method returns `nil`
    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> Void {
        fatalError()
        //        guard variableToDifferentiate == variable else { return Polynomial(self) }
        //        let exponentPriorToDifferentiation = self.exponent
        //        let exponent = exponentPriorToDifferentiation - 1
        //        guard exponent > 0 else {
        //            return Polynomial(constant: .one)
        ////            return .constant(1)
        //        }
        //
        ////        return .exponentiation(coefficient: exponentPriorToDifferentiation, exponentiation: Exponentiation(variable, exponent: exponent))
        //        let term: Term = Term(exponentiation: Exponentiation(variable, exponent: exponent), coefficient: exponentPriorToDifferentiation)
        //        return Polynomial(term)
    }

}
