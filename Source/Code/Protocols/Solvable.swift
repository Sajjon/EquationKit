//
//  Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// ***************************************************************
/// ONLY IMPLEMENTED FOR SQUARES AND POLYNOMIALS WITH TWO VARIABLES
/// ***************************************************************

public enum Solution<Number: NumberExpressible>: NumberTypeSpecifying {
    public typealias NumberType = Number

    case roots(Set<ConstantStruct<NumberType>>)
    case number(NumberType)
}

public protocol Solvable: Evaluatable {
    var highestExponent: NumberType? { get }
    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Solution<NumberType>?

    /// Might have a look at Sympys solver: https://github.com/sympy/sympy/blob/master/sympy/solvers/solvers.py#L450-L1349
    func findRoots(constants: Set<ConstantStruct<NumberType>>) -> Set<ConstantStruct<NumberType>>?
    func findModularRoots(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType, modulusMode: ModulusMode) -> Set<ConstantStruct<NumberType>>
}

public extension Solvable {

    var variableCount: Int { return uniqueVariables.count }

    var highestExponent: NumberType? { return nil }

    func solve(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Solution<NumberType>? {

        guard let highestExponent = highestExponent, highestExponent <= 2, variableCount <= 2 else { return nil }

        let variablesPassed = Set<VariableStruct<NumberType>>(constants.map { $0.toVariable() })

        if variablesPassed.isSuperset(of: uniqueVariables) {
            return .number(evaluate(constants: constants, modulus: modulus, modulusMode: modulusMode)!)
        } else {
            if let modulus = modulus {
                return .roots(findModularRoots(constants: constants, modulus: modulus, modulusMode: modulusMode))
            } else {
                guard let roots = findRoots(constants: constants) else { return nil }
                return .roots(roots)
            }

        }
    }


    func findModularRoots(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType, modulusMode: ModulusMode) -> Set<ConstantStruct<NumberType>> {
        fatalError("use cipolla?")
    }
}

public extension Set where Element: ConstantProtocol {
    func toValues() -> [VariableStruct<Element.NumberType>: Element.NumberType] {
        let array: [(VariableStruct<Element.NumberType>, Element.NumberType)] = self.map { ($0.toVariable(), $0.value) }
        let dictionary: [VariableStruct<Element.NumberType>: Element.NumberType] = array.reduce(into: [:]) { $0[$1.0] = $1.1 }
        return dictionary
    }
}

//public enum Substitution<NumberType: NumberExpressible> {
//    case variable()
//}

//public struct Substitution<Number: NumberExpressible> {
//
//    public enum Replacement {
//        case constant(Number)
//        case algebraic(Atom)
//    }
//
//    public let original: SubstituationableAtom
//    public let replacement: Replacement
//
//    public init(replace original: SubstituationableAtom, with replacement: Replacement) {
//        self.original = original
//        self.replacement = replacement
//    }
//}

//public enum Substitution<Number: NumberExpressible> {
//
//    public enum Replacement {
//        case constant(Number)
//        case algebraic(Atom)
//    }
//
//    case single(Replacement)
//    case plural([Replacement])
//
//}
//
//public protocol SubstituationableAtom {}



public protocol Substituationable: NumberTypeSpecifying {
    associatedtype Substitution
    func substitute(_ substitution: Substitution) -> PolynomialType<NumberType>?
}

public extension Substituationable {

    func substitute(_ substitution: Atom) -> PolynomialType<NumberType>? {
        fatalError()
    }
}

public enum ExpOrVar<Number: NumberExpressible> {
    case exponentiation(ExponentiationStruct<Number>)
    case variable(VariableStruct<Number>)
}

public extension TermProtocol {
//    typealias Substitution =
    func substitute(_ substitution: [(ExpOrVar<NumberType>) -> PolynomialType<NumberType>]) -> PolynomialType<NumberType>? {
        // self==`2xy` sub==`3z`
        fatalError()
    }
}

public extension ExponentiationProtocol {
    func substitute(_ substitution: Atom) -> PolynomialType<NumberType>? {
//        guard let exponentAsInt = Int(exponent) else { fatalError() }
        let exponentAsInt: Int = { fatalError() }()
        return PolynomialType(substitution).raised(to: exponentAsInt)
    }
}



public extension VariableProtocol {
    func substitute(_ substitution: Atom) -> PolynomialType<NumberType>? {
       return PolynomialType(substitution)
    }
}

// MARK: - Solvable
public extension PolynomialProtocol {

    var isUnivariate: Bool {
        return variableCount == 1
    }

    func findRoots(constants: Set<ConstantStruct<NumberType>>) -> Set<ConstantStruct<NumberType>>? {
        return nil
    }

    /// - Requires: This polynomial must be univarate.
    /// Return a pair (p,q) that verify that p/q is a solution of this polynomial. If no valid pair is find, return `nil`.
    func findRootCandidates(constants: Set<ConstantStruct<NumberType>>) -> (p: NumberType, q: NumberType)? {
        guard isUnivariate, let highestExponent = highestExponent, highestExponent <= 2 else { fatalError("incorrect impl") }

        let coefficentsForExponentiations = coefficientsForExponentiationsOfUnivariatePolynomial()

        guard
            let aN = coefficentsForExponentiations.first,
            aN.coefficient > 0,
            let a0 = coefficentsForExponentiations.last,
            a0.coefficient > 0
            else { return nil }

        /// Returns the list of the divider of a number by filtering the values in [1, 2, ... , |coefficient| ] that divide coefficient.
        func dividers(of coefficient: NumberType) -> [NumberType] {
            return stride(from: 1, through: coefficient.absolute() + 1, by: 1).filter { coefficient.mod($0, modulusMode: .alwaysPositive) == 0 }
        }

        //        let pValues =
        //        let qValues =

        /// Returns the list of positives and negatives combination of (p,q) pairs.
        /// Example :
        /// [1,2]
        /// -> [(1,4), (-1,4), (2,4), (-2,4), (1,5), (-1,5), (2,5), (-2,5)]
        /// [4,5]
        func positiveAndNegativeCombinations(_ pValues_: [NumberType], _ qValues_: [NumberType]) -> [(p: NumberType, q: NumberType)] {

            func combinations(_ p: NumberType, _ qValues__: [NumberType]) -> [(p: NumberType, q: NumberType)] {
                if qValues__.count == 1 {
                    return [(p: p, q: qValues__[0])]
                } else {
                    return [(p: p, q: qValues__[0])] + combinations(p, qValues__.droppingFirst())
                }
            }
            var result = [(p: NumberType, q: NumberType)]()
            for p in pValues_ {
                let pCombinations = combinations(p, qValues_)
                for combination in pCombinations {
                    result += [combination, (p: combination.p.negated(), q: combination.q)]
                }
            }
            return result
        }

        let solutionCandidates = positiveAndNegativeCombinations(dividers(of: a0.coefficient), dividers(of: aN.coefficient))

        func isSolution(_ value: NumberType) -> Bool {
            fatalError()
        }

        for candidate in solutionCandidates {
            let candidateValue = candidate.p / candidate.q
            guard isSolution(candidateValue) else { continue }
            return candidate
        }

        return nil

    }

    func coefficientsOfUnivariatePolynomial() -> [NumberType] {
        return coefficientsForExponentiationsOfUnivariatePolynomial().map { $0.coefficient }
    }

    /// Excluding the constant
    func coefficientsForExponentiationsOfUnivariatePolynomial() -> [(exponent: NumberType, coefficient: NumberType)] {
        guard isUnivariate, !terms.isEmpty, let highestExponent = highestExponent else { return [] }

        var univariateTerms = sorted(by: .descendingExponents).terms.map {
            return (exponent: $0.exponentiations[0].exponent, coefficient: $0.coefficient)
            }.reduce(into: [:], { $0[$1.0] = $1.1 })

        for e in stride(from: highestExponent, through: 1, by: -1) {
            univariateTerms[e] ?= 0
        }

        let tuples = univariateTerms.map { (exponent: $0.key, coefficient: $0.value) }
        let sortedTuples = tuples.sorted(by: { $0.exponent > $1.exponent })
        return sortedTuples.appending((exponent: .zero, coefficient: constant))
    }
}

infix operator ?=
func ?= <T>(t: inout T?, value: T) {
    guard t == nil else { return }
    t = value
}

extension Array {
    func appending(_ newElement: Element) -> [Element] {
        return self + [newElement]
    }
}
