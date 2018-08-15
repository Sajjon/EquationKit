//
//  Polynomial.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import UIKit







struct Polynomial: Equatable, CustomStringConvertible {
    let constant: Double
    let terms: [Term]

    static func mergingAndSortingTerms(_ terms: [Term]) -> [Term] {
        return mergingTerms(terms: terms).sorted(by: { $0.highestExponent > $1.highestExponent }).sorted(by: { $0.lowestVariableNameInAlpabeticOrder < $1.lowestVariableNameInAlpabeticOrder })
    }

    init(terms: [Term], constant: Double = 0) {
        self.terms = Polynomial.mergingAndSortingTerms(terms)
        self.constant = constant
    }

    init(_ constant: Double) {
        self.init(terms: [], constant: constant)
    }


    init(_ term: Term, constant: Double = 0) {
        self.init(terms: [term], constant: constant)
    }

    init(exponentiation: Exponentiation, constant: Double = 0) {
        self.init(Term(exponentiation: exponentiation), constant: constant)
    }

    init(variable: Variable, constant: Double = 0) {
        self.init(exponentiation: Exponentiation(variable), constant: constant)
    }

    static func == (lhs: Polynomial, rhs: Polynomial) -> Bool {
        return lhs.constant == rhs.constant
            && lhs.terms == rhs.terms
    }

    private var constantString: String {
        guard constant != 0 else { return "" }
        let constantSignString = constant > 0 ? "+" : "-"
        return " \(constantSignString) \(abs(constant).shortFormat)"
    }

    private var termsString: String {
        func foo(index: Int, term: Term) -> String {
            let signString = (index == 0 || index == terms.endIndex) ? "" : " \(term.signString) "
            return "\(signString)\(term.description)"
        }
        return terms.enumerated().map { foo(index: $0, term: $1) }.joined()
    }

    var description: String {
        return "\(termsString)\(constantString)"
    }

    func contains(variable: Variable) -> Bool {
        for term in terms {
            guard term.contains(variable: variable) else { continue }
            return true
        }
        return false
    }

    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> Polynomial {
        guard contains(variable: variableToDifferentiate) else { return Polynomial(terms: [], constant: 0) }
        var terms = [Term]()
        var constant: Double = 0
        for term in self.terms {
            guard let differentiatedTerm = term.differentiateWithRespectTo(variableToDifferentiate) else { continue }
            switch differentiatedTerm {
            case .constant(let differentiatedConstant): constant += differentiatedConstant
            case .term(let differentiatedTerm): terms.append(differentiatedTerm)
            }
        }
        return Polynomial(terms: terms, constant: constant)
    }

    var uniqueVariables: Set<Variable> {
        return Set(terms.flatMap { Array($0.uniqueVariables) })
    }

    func solve(constants: Set<Constant>, modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard uniqueVariables.isSubset(of: constants.map { $0.toVariable() }) else { return nil }
        return terms.reduce(constant, {
            guard let solution = $1.solve(constants: constants, modulus: modulus, modulusMode: modulusMode) else { return $0 }
            return $0 + solution
        })
    }
}

extension Polynomial {

    func appending(term: Term) -> Polynomial {
        return Polynomial(terms: Polynomial.mergingAndSortingTerms(terms + term), constant: constant)
    }

    func appending(exponentiation: Exponentiation) -> Polynomial {
        return appending(term: Term(exponentiation: exponentiation))
    }

    func appending(variable: Variable) -> Polynomial {
        return appending(exponentiation: Exponentiation(variable))
    }

    func appending(constant: Double) -> Polynomial {
        return Polynomial(terms: terms, constant: self.constant + constant)
    }
    func appending(constant: Int) -> Polynomial {
        return appending(constant: Double(constant))
    }

    func solve(constants: [String: Double], modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        return solve(constants: Set(constants.map { Constant($0, value: $1) }), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: [Constant], modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard !constants.containsDuplicates() else { fatalError() }
        return solve(constants: Set(constants), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(constants: Constant..., modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        return solve(constants: constants, modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [Constant]) -> Double? {
        return solve(constants: assertingValue(), modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> Constant) -> Double? {
        return solve(constants: [assertingValue()], modulus: modulus, modulusMode: modulusMode)
    }

    func solve(modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive, assertingValue: () -> [(Variable, Double)]) -> Double? {
        //        let dict = assertingValue().reduce(into: [:]) { $0[$1.0] = $1.1 }.map { Constant($0) }
        let array = assertingValue().map { Constant($0, value: $1) }
        return solve(constants: Set(array), modulus: modulus, modulusMode: modulusMode)
    }
}

extension Array where Element: Hashable {
    func containsDuplicates() -> Bool {
        return Set(self).count != count
    }
}


func +(polynomial: Polynomial, variable: Variable) -> Polynomial {
    return polynomial.appending(variable: variable)
}

func +(polynomial: Polynomial, constant: Int) -> Polynomial {
    return polynomial.appending(constant: constant)
}
func +(polynomial: Polynomial, constant: Double) -> Polynomial {
    return polynomial.appending(constant: constant)
}
func +(polynomial: Polynomial, term: Term) -> Polynomial {
    return polynomial.appending(term: term)
}
func -(polynomial: Polynomial, term: Term) -> Polynomial {
    return polynomial + term.negated()
}

func ^^(base: Variable, exponent: Double) -> Term {
    return Term(exponentiation: Exponentiation(base, exponent: exponent))
}

extension Polynomial {

    func appending(polynomial other: Polynomial) -> Polynomial {
        return Polynomial(terms: terms + other.terms, constant: constant + other.constant)
    }


    func negated() -> Polynomial {
        return Polynomial(terms: terms.negated(), constant: -constant)
    }

    func multiplied(by number: Double) -> Polynomial {
        print("a")
        guard let firstTerm = terms.first else { return Polynomial(terms: [], constant: constant * number) }
        print("b")
        let termMultiplied = Term(exponentiations: firstTerm.exponentiations, coefficient: firstTerm.coefficient * number)
        print("c")
        guard terms.count > 1 else { return Polynomial(termMultiplied, constant: constant) }
        print("d")
        let rest = terms.dropFirst()
        print("e")
        return Polynomial(terms: [termMultiplied] + rest, constant: constant)
    }

    func multiplied(by number: Int) -> Polynomial {
        return multiplied(by: Double(number))
    }

    func subtracting(_ number: Double) -> Polynomial {
        return Polynomial(terms: terms, constant: constant - number)
    }
}

func +(term: Term, constant: Double) -> Polynomial {
    return Polynomial(term).appending(constant: constant)
}
func +(term: Term, constant: Int) -> Polynomial {
    return term + Double(constant)
}

func +(term: Term, variable: Variable) -> Polynomial {
    return Polynomial(term).appending(variable: variable)
}

func -(term: Term, variable: Variable) -> Polynomial {
    return Polynomial(term) - Polynomial(variable: variable)
}

func +(term: Term, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(term).appending(exponentiation: exponentiation)
}

func -(term: Term, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(term) - Polynomial(exponentiation: exponentiation)
}


func +(term: Term, other: Term) -> Polynomial {
    return Polynomial(term).appending(term: other)
}
func -(term: Term, other: Term) -> Polynomial {
    return Polynomial(term) - Polynomial(other)
}

func +(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
    return Polynomial(exponentiation: lhs) + Polynomial(exponentiation: rhs)
}
func -(lhs: Exponentiation, rhs: Exponentiation) -> Polynomial {
    return Polynomial(exponentiation: lhs) - Polynomial(exponentiation: rhs)
}
func +(variable: Variable, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(variable: variable) + Polynomial(exponentiation: exponentiation)
}
func -(variable: Variable, exponentiation: Exponentiation) -> Polynomial {
    return Polynomial(variable: variable) - Polynomial(exponentiation: exponentiation)
}
func +(exponentiation: Exponentiation, variable: Variable) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + Polynomial(variable: variable)
}
func -(exponentiation: Exponentiation, variable: Variable) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) - Polynomial(variable: variable)
}

func +(exponentiation: Exponentiation, constant: Double) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) + constant
}
func +(exponentiation: Exponentiation, constant: Int) -> Polynomial {
    return exponentiation + Double(constant)
}
func -(polynomial: Polynomial, constant: Double) -> Polynomial {
    return polynomial.subtracting(constant)
}
func -(exponentiation: Exponentiation, constant: Double) -> Polynomial {
    return Polynomial(exponentiation: exponentiation) - constant
}
func -(exponentiation: Exponentiation, constant: Int) -> Polynomial {
    return exponentiation - Double(constant)
}
func +(variable: Variable, constant: Double) -> Polynomial {
    return Polynomial(variable: variable) + constant
}
func +(variable: Variable, constant: Int) -> Polynomial {
    return variable + Double(constant)
}
func -(variable: Variable, constant: Double) -> Polynomial {
    return Polynomial(variable: variable) - constant
}
func -(variable: Variable, constant: Int) -> Polynomial {
    return variable - Double(constant)
}

func +(polynomial: Polynomial, other: Polynomial) -> Polynomial {
    return polynomial.appending(polynomial: other)
}

func -(polynomial: Polynomial, other: Polynomial) -> Polynomial {
    return polynomial + other.negated()
}

func +(polynomial: Polynomial, exponentiation: Exponentiation) -> Polynomial {
    return polynomial.appending(exponentiation: exponentiation)
}

func -(polynomial: Polynomial, exponentiation: Exponentiation) -> Polynomial {
    return polynomial + Term(exponentiation: exponentiation, coefficient: -1)
}

func *(coefficient: Int, term: Term) -> Term {
    return Double(coefficient) * term
}
func *(coefficient: Double, term: Term) -> Term {
    return term.multiplyingCoefficient(by: coefficient)
}
func *(coefficient: Double, variable: Variable) -> Term {
    return Term(exponentiation: Exponentiation(variable), coefficient: coefficient)
}
func *(coefficient: Int, variable: Variable) -> Term {
    return Double(coefficient) * variable
}

func *(coefficient: Double, exponentiation: Exponentiation) -> Term {
    return Term(exponentiation: exponentiation, coefficient: coefficient)
}
func *(coefficient: Int, exponentiation: Exponentiation) -> Term {
    return Double(coefficient) * exponentiation
}

func *(lhs: Exponentiation, rhs: Exponentiation) -> Term {
    return Term(exponentiation: lhs).appending(exponentiation: rhs)
}

func mergingTerms(terms: [Term]) -> [Term] {
    var count: [Term: Double] = [:]
    for term in terms {
        guard let currentCount = count[term] else { count[term] = term.coefficient; continue }
        count[term] = currentCount + term.coefficient
    }
    return count.map { Term(exponentiations: $0.key.exponentiations, coefficient: $0.value) }
}


func *(rhs: Term, lhs: Term) -> Term {
    // (2*x*y) * (3x^2*y^2)
    var mergedExponentiations = rhs.exponentiations + lhs.exponentiations

    let coefficient = rhs.coefficient * lhs.coefficient

    if mergedExponentiations.containsDuplicates() {
        var count: [Exponentiation: Int] = [:]
        for exp in mergedExponentiations {
            guard let currentCount = count[exp] else { count[exp] = 1; continue }
            count[exp] = currentCount + 1
        }
        let duplicatesDictionary = count.filter { $0.value > 1 }

        let nonDuplicates: [Exponentiation] = Array(Set(mergedExponentiations).subtracting(Set(duplicatesDictionary.keys)))
        let exponentiationsWithExponentGreaterThanOne: [Exponentiation] = duplicatesDictionary.map { Exponentiation($0.key.variable, exponent: Double($0.value)) }

        mergedExponentiations = exponentiationsWithExponentGreaterThanOne + nonDuplicates

        return Term(exponentiations: mergedExponentiations, coefficient: coefficient)
    } else {
        return Term(exponentiations: mergedExponentiations, coefficient: coefficient)
    }
}

//func *(rhs: Term, polynomial: Polynomial) -> Polynomial {
//    // (2*x*y) * (3x^2 - 5y^2 - 13)
//    var multipliedTerms = [Term]()
//    for term in polynomial.terms {
//        multipliedTerms.append(rhs * term)
//    }
//    if polynomial.constant != 0 {
//        let constantMultipliedByTerm: Term = polynomial.constant * rhs
//         return Polynomial(terms: multipliedTerms + constantMultipliedByTerm)
//    } else {
//        return Polynomial(terms: multipliedTerms)
//    }
//}

func *(lhs: Polynomial, rhs: Polynomial) -> Polynomial {

    // ..... L H S .... * .... R H S ...
    // (x*y + 2*x + 13) * (3*y - 7*x - 9)
    var multipliedTerm = [Term]()
    //    var lhsMultipliedPolynomials = [Polynomial]()
    for lhsTerm in lhs.terms {
        for rhsTerm in rhs.terms {
            multipliedTerm.append(lhsTerm * rhsTerm)
        }
        if rhs.constant != 0 {
            multipliedTerm.append(rhs.constant * lhsTerm)
        }
//        lhsMultipliedPolynomials.append(lhsTerm * rhs)
    }
    if lhs.constant != 0 {
        for rhsTerm in rhs.terms {
            multipliedTerm.append(lhs.constant * rhsTerm)
        }
    }

    let constant = lhs.constant * rhs.constant

    return Polynomial(terms: multipliedTerm, constant: constant)

//    var rhsMultipliedPolynomials = [Polynomial]()
//    for rhsTerm in rhs.terms {
//        rhsMultipliedPolynomials.append(rhsTerm * lhs)
//        // dont forget polynomial constant
//    }

//    return Polynomial(
//        terms:
//        lhsMultipliedPolynomials.flatMap { $0.terms },
////            +
////        rhsMultipliedPolynomials.flatMap { $0.terms },
//
//        constant:
//        lhsMultipliedPolynomials.reduce(into: 0, { $0 = $0 + $1.constant} )
////            +
////        rhsMultipliedPolynomials.reduce(into: 0, { $0 = $0 + $1.constant} )
//    )


}

extension Exponentiation {
    func multiplyingExponent(by number: Double) -> Exponentiation {
        return Exponentiation(variable, exponent: exponent * number)
    }
}

extension Term {

    func multiplyingCoefficient(by number: Double) -> Term {
        return Term(exponentiations: exponentiations, coefficient: coefficient * number)
    }

    func multiplyingExponent(by number: Double) -> Term {
        guard let lastExponentiation = self.exponentiations.last else { fatalError("Terms should have at least one exponentation") }
        let modified = lastExponentiation.multiplyingExponent(by: number)
        var exponentiations = [modified]
        if exponentiations.count > 1 {
            exponentiations = self.exponentiations.dropLast() + exponentiations
        }
        return Term(exponentiations: exponentiations, coefficient: coefficient)
    }

    func appending(exponentiation: Exponentiation) -> Term {
        return Term(exponentiations: Term.sortingExponentiation(exponentiations + exponentiation), coefficient: coefficient)
    }

    func appending(variable: Variable) -> Term {
        return appending(exponentiation: Exponentiation(variable))
    }
}

extension Array {
    static func +(array: Array, element: Element) -> Array {
        return array + [element]
    }
}

func ^^(base: Term, exponent: Double) -> Term {
    return base.multiplyingExponent(by: exponent)
}
func ^^(base: Term, exponent: Int) -> Term {
    return base ^^ Double(exponent)
}

func *(term: Term, variable: Variable) -> Term {
    return term.appending(variable: variable)
}

func *(lhs: Variable, rhs: Variable) -> Term {
    return Term(lhs).appending(variable: rhs)
}

func *(term: Term, exponentiation: Exponentiation) -> Term {
    return term.appending(exponentiation: exponentiation)
}
