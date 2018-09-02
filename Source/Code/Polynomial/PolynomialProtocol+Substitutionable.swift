//
//  PolynomialProtocol+Substitutionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Substitutionable
public extension PolynomialProtocol {

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return Set(terms.flatMap { Array($0.uniqueVariables) })
    }

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Substitution<NumberType> {
        let nextPartialResult = { (accumulatingValue: Atom, nextElement: Substitution<NumberType>) -> Atom in
            return PolynomialType<NumberType>(accumulatingValue).adding(other: PolynomialType<NumberType>(nextElement.asAtom)) as Atom
        }

        return parseMany(
            substitutionables: terms,
            constants: constants,
            modulus: modulus,
            modulusMode: modulusMode,
            manyHandleAllNumbers: { values in
                values.reduce(self.constant, { $0 + $1 })
        },
            manyHandleMixedReduce: (initialResult: (Self.zero as Atom), combine: nextPartialResult)
        )
    }
}



// MARK: - ConstantSubstitutionable
//public extension PolynomialProtocol {
//    func substitute(constants: Set<ConstantStruct<NumberType>>) -> PolynomialType<NumberType> {
//        let unionConstants = uniqueVariables.unionTo(other: constants) { $0.toVariable() }
//        guard !unionConstants.isEmpty else { return PolynomialType(polynomial: self as! PolynomialType) }
//
//        var constant = self.constant
//
//        var unchangedTerms = [PolynomialType<NumberType>.TermType]()
//
//        for term in terms {
//            let substitution = term.substitute(constants: unionConstants)
//            guard !(substitution.constant.isZero && substitution.terms.isEmpty) else { continue }
//
//
//            constant = constant + substitution.constant
//
//            if !substitution.terms.isEmpty {
//                guard
//                    substitution.terms.count == 1,
//                    let _term = substitution.terms.first
//                    else {
//                        fatalError("incorrect implementation, or incorrect assumptions in this guard.")
//                }
//                unchangedTerms.append(_term)
//            }
//        }
//
//        if unchangedTerms.isEmpty {
//            return PolynomialType(constant: constant)
//        } else {
//            return PolynomialType(terms: unchangedTerms, constant: constant)
//        }
//    }
//
//    // MARK: - ConstantSubstitutionable Convenience
//    func substitute(makeConstants: () -> ([ConstantStruct<NumberType>])) -> PolynomialType<NumberType> {
//        let constants = makeConstants()
//        guard !constants.containsDuplicates() else { fatalError("Cannot contain duplicates") }
//        return substitute(constants: Set(constants))
//    }
//}


