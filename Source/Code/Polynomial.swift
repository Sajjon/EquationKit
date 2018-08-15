//
//  Polynomial.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    var shortFormat: String{
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}

///////////////////

//infix operator <==
//func <== (variable: Variable, value: Double) -> Constant {
//    return Constant(variable, value: value)
//}
func ==(variable: Variable, value: Double) -> Constant {
    return Constant(variable, value: value)
}
precedencegroup ExponentiationPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left
}
infix operator ^^: ExponentiationPrecedence

enum ModulusMode {
    /// Swift style
    case allowNegative

    /// Python Style
    case alwaysPositive
}


struct Constant: Equatable, CustomStringConvertible, Hashable {
    let name: String
    let value: Double
    init(_ name: String, value: Double) {
        self.name = name
        self.value = value
    }

    init(_ variable: Variable, value: Double) {
        self.init(variable.name, value: value)
    }

    static func == (lhs: Constant, rhs: Constant) -> Bool {
        return lhs.name == rhs.name && lhs.value == rhs.value
    }

    var description: String {
        return "<\(name)=\(value.shortFormat)>"
    }

    func toVariable() -> Variable {
        return Variable(name)
    }

    var hashValue: Int {
        return name.hashValue
    }

}

func ==(constant: Constant, variable: Variable) -> Bool {
    return constant.name == variable.name
}

func ==(variable: Variable, constant: Constant) -> Bool {
    return constant == variable
}

struct Variable: Equatable, CustomStringConvertible, Hashable {
    let name: String
    init(_ name: String) {
        self.name = name
    }

    static func == (lhs: Variable, rhs: Variable) -> Bool {
        return lhs.name == rhs.name
    }

    var hashValue: Int {
        return name.hashValue
    }

    var description: String {
        return name
    }
}

func mod<T>(_ number: T, modulus: T, modulusMode: ModulusMode = .alwaysPositive) -> T where T: BinaryInteger {
    var mod = number % modulus
    guard modulusMode == .alwaysPositive else { return mod }
    if mod < 0 {
        mod = mod + modulus
    }
    guard mod >= 0 else { fatalError("NEGATIVE VALUE") }
    return mod
}

func mod<F>(_ number: F, modulus: F, modulusMode: ModulusMode = .alwaysPositive) -> F where F: BinaryFloatingPoint {
    var mod = number.truncatingRemainder(dividingBy: modulus)
    guard modulusMode == .alwaysPositive else { return mod }
    if mod < 0 {
        mod = mod + modulus
    }
    guard mod >= 0 else { fatalError("NEGATIVE VALUE") }
    return mod
}

struct Exponentiation: Equatable, CustomStringConvertible, Hashable {
    let variable: Variable
    let exponent: Double
    init(_ variable: Variable, exponent: Double = 1) {
        self.variable = variable
        self.exponent = exponent
    }

    func solve(constants: Set<Constant>, modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard let constant = constants.first(where: { $0.toVariable() == variable }) else { return nil }
        let value = pow(constant.value, exponent)
        guard let modulus = modulus else { return value }
        return mod(value, modulus: modulus, modulusMode: modulusMode)
    }

    init(_ name: String, exponent: Double = 1) {
        self.init(Variable(name), exponent: exponent)
    }


    static func == (lhs: Exponentiation, rhs: Exponentiation) -> Bool {
        return lhs.variable == rhs.variable && lhs.exponent == rhs.exponent
    }


    var description: String {
        guard exponent != 1 else { return variable.description }
        if exponent > 1 && exponent < 10 {
            let superscript: String
            if exponent == 2 {
                superscript = "²"
            } else if exponent == 3 {
                superscript = "³"
            } else if exponent == 4 {
                superscript = "⁴"
            } else if exponent == 5 {
                superscript = "⁵"
            } else if exponent == 6 {
                superscript = "⁶"
            } else if exponent == 7 {
                superscript = "⁷"
            } else if exponent == 8 {
                superscript = "⁸"
            } else if exponent == 9 {
                superscript = "⁹"
            } else { fatalError("forgot number") }
            return "\(variable)\(superscript)"
        } else {
            return "\(variable)^\(exponent.shortFormat)"
        }
    }

    enum DifferentiationResult {
        case constant(Double)
        case exponentiation(coefficient: Double?, exponentiation: Exponentiation)
    }

    /// Returns the differentiated variable and its coefficient with respect to the input variable, if this variable does not equal said variable, then this method returns `nil`
    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> DifferentiationResult? {
        guard variableToDifferentiate == variable else { return .exponentiation(coefficient: nil, exponentiation: self) }
        let exponentPriorToDifferentiation = self.exponent
        let exponent = exponentPriorToDifferentiation - 1
        guard exponent > 0 else {
            return .constant(1)
        }
        return .exponentiation(coefficient: exponentPriorToDifferentiation, exponentiation: Exponentiation(variable, exponent: exponent))
    }
}


struct Term: Equatable, CustomStringConvertible, Hashable {

    /// Returns the differentiated term with respect to the input variable, if this term does not contain said variable, then this method returns `nil`
    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> (constant: Double?, term: Term?)? {
        guard contains(variable: variableToDifferentiate) else { return nil }
        var exponentiations = [Exponentiation]()
        var coefficient = self.coefficient
        var coefficientFromConstants: Double = 1
        for exponentiation in self.exponentiations {
            if let differentiationResult = exponentiation.differentiateWithRespectTo(variableToDifferentiate) {
                switch differentiationResult {
                case .constant(let differentiationConstant):
                    coefficientFromConstants *= differentiationConstant
                case .exponentiation(let differentiationCoefficient, let differentiationExponentiation):
                    if let differentiationCoefficient = differentiationCoefficient {
                        coefficient *= differentiationCoefficient
                    }
                    exponentiations.append(differentiationExponentiation)
                }

            } else {
                exponentiations.append(exponentiation)
            }
        }

        if exponentiations.count == 0 {
            return (constant: coefficient * coefficientFromConstants, term: nil)
        } else {
            let term = Term(exponentiations: exponentiations, coefficient: coefficient * coefficientFromConstants)
            return (constant: nil, term: term)
        }

    }

    /// -1 if negative
    let coefficient: Double
    let exponentiations: [Exponentiation]

    var highestExponent: Double {
        precondition(Term.sortingExponentiation(exponentiations) == exponentiations) // TODO remove this when tested
        return exponentiations[0].exponent
    }

    func solve(constants: Set<Constant>, modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard uniqueVariables.isSubset(of: constants.map { $0.toVariable() }) else { return nil }
        let values = exponentiations.compactMap { $0.solve(constants: constants, modulus: modulus, modulusMode: modulusMode) }
        return values.reduce(1, { $0*$1 }) * coefficient
    }

    var uniqueVariables: Set<Variable> {
        return Set(exponentiations.map { $0.variable })
    }

    static func sortingExponentiation(_ exponentiations: [Exponentiation]) -> [Exponentiation] {
        return exponentiations.sorted(by: { $0.exponent > $1.exponent }).sorted(by: { $0.variable.name < $1.variable.name })
    }

    init(exponentiations: [Exponentiation], coefficient: Double = 1) {
        guard coefficient != 0 else { fatalError("You probably don't want a Zero coefficient") }
        self.exponentiations = Term.sortingExponentiation(exponentiations)
        self.coefficient = coefficient
    }

    init(exponentiation: Exponentiation, coefficient: Double = 1) {
        self.init(exponentiations: [exponentiation], coefficient: coefficient)
    }

    init(_ variable: Variable) {
        self.init(exponentiation: Exponentiation(variable))
    }

    static func == (lhs: Term, rhs: Term) -> Bool {
//        return lhs.coefficient == rhs.coefficient &&
        return lhs.exponentiations == rhs.exponentiations
    }

    var hashValue: Int {
        return exponentiations.hashValue
    }

    private var exponentiationsString: String {
        return exponentiations.map { $0.description }.joined()
    }

    var isNegative: Bool {
        return coefficient < 0
    }

    var signString: String {
        return isNegative ? "-" : "+"
    }

    private var coefficientString: String {
        let absoluteCoefficient = abs(coefficient)
        guard absoluteCoefficient != 1 else { return "" }
        return "\(absoluteCoefficient.shortFormat)"
    }

    var description: String {
        return "\(coefficientString)\(exponentiationsString)"
    }

    func contains(variable: Variable) -> Bool {
        return exponentiations.map { $0.variable }.contains(variable)
    }

    func negated() -> Term {
        return Term(exponentiations: exponentiations, coefficient: -coefficient)
    }
}


extension Array where Element == Term {
    func negated() -> [Term] {
        return map { $0.negated() }
    }
}

struct Polynomial: Equatable, CustomStringConvertible {
    let constant: Double
    let terms: [Term]

    static func mergingAndSortingTerms(_ terms: [Term]) -> [Term] {
        return mergingTerms(terms: terms).sorted(by: { $0.highestExponent > $1.highestExponent })
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
            if let (differentiatedConstant, differentiatedTerm) = term.differentiateWithRespectTo(variableToDifferentiate) {
                if let differentiatedConstant = differentiatedConstant {
                    constant += differentiatedConstant
                }
                if let differentiatedTerm = differentiatedTerm {
                    terms.append(differentiatedTerm)
                }
            } else {
                // unchanged
//                terms.append(term)
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
