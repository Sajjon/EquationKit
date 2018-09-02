//
//  TermProtocol+Substitionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Substitionable
public extension TermProtocol {

    static var zero: PolynomialStruct<Self> { return PolynomialStruct<Self>(constant: .zero) }
    static var one: PolynomialStruct<Self> { return PolynomialStruct<Self>(constant: .one) }

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return Set(exponentiations.map { $0.variable })
    }

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Substitution<NumberType> {

        let nextPartialResult = { (accumulatingValue: Atom, nextElement: Substitution<NumberType>) -> Atom in
            return PolynomialType<NumberType>(accumulatingValue).multipliedBy(other: PolynomialType<NumberType>(nextElement.asAtom)) as Atom
        }


        return parseMany(
            substitutionables: exponentiations,
            constants: constants,
            modulus: modulus,
            modulusMode: modulusMode,
            manyHandleAllNumbers: { values in
                return values.reduce(NumberType.one, { $0 * $1 }) * coefficient
            },
            manyHandleMixedReduce: (initialResult: Self.one as Atom, combine: nextPartialResult)
        )
    }

//    func substitute(constants: Set<ConstantStruct<NumberType>>) -> PolynomialType<NumberType> {
//        let unionConstants = uniqueVariables.unionTo(other: constants) { $0.toVariable() }
//        guard !unionConstants.isEmpty else {
//            print("term: \(self)")
//            return PolynomialType(term: self as! PolynomialType<NumberType>.TermType)
//
//        }
//
//        var constant = self.coefficient
//        var unchangedExponentiations = [PolynomialType<NumberType>.ExponentiationType]()
//
//        for exponentiation in exponentiations {
//            let substitution = exponentiation.substitute(constants: unionConstants)
//            guard !substitution.constant.isZero else { return PolynomialType(constant: 0) }
//            constant = constant * substitution.constant
//            if !substitution.terms.isEmpty {
//                guard
//                    substitution.terms.count == 1,
//                    let term = substitution.terms.first,
//                    term.coefficient == .one,
//                    term.exponentiations.count == 1,
//                    let _exponentiation = term.exponentiations.first
//                    else {
//                        fatalError("incorrect implementation, or incorrect assumptions in this guard.")
//                }
//                unchangedExponentiations.append(_exponentiation)
//            }
//        }
//
//        if exponentiations.isEmpty {
//            return PolynomialType(constant: constant)
//        } else {
//            return PolynomialType(
//                term: PolynomialType<NumberType>.TermType(
//                    exponentiations: unchangedExponentiations, coefficient: constant
//                    )!
//            )
//        }
//    }
}
