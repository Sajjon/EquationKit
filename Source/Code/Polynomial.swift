//
//  Polynomial.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Polynomial: Algebraic {

    public let constant: Double
    public let terms: [Term]


    init(terms: [Term], sorting: TermSorting = .default, constant: Double = 0) {
        self.terms = terms.merged().sorted(by: sorting)
        self.constant = constant
    }
}

// MARK: - Convenience Initializers
public extension Polynomial {
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
}

// MARK: - ExpressibleByFloatLiteral
extension Polynomial: ExpressibleByFloatLiteral {}
public extension Polynomial {
    init(floatLiteral value: Float) {
        self.init(Double(value))
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension Polynomial: ExpressibleByIntegerLiteral {}
public extension Polynomial {
    init(integerLiteral value: Int) {
        self.init(Double(value))
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Polynomial: ExpressibleByArrayLiteral {}
public extension Polynomial {
    init(arrayLiteral terms: Term...) {
        self.init(terms: terms)
    }
}

public protocol Sorting: Equatable {
    associatedtype TypeToSort
    typealias AreInIncreasingOrder = (TypeToSort, TypeToSort) -> (Bool)
    func areInIncreasingOrder(tieBreakers: [Self]?) -> AreInIncreasingOrder
    var comparing: (TypeToSort, TypeToSort) -> (ComparisonResult) { get }
    var targetComparisonResult: ComparisonResult { get }
//    var defaultTieBreakers: [Self] { get }
}

public extension Array {
    func droppingFirst() -> [Element] {
        guard count > 1 else { return [] }
        return Array<Element>(dropFirst())
    }

    func droppingFirstNilIfEmpty() -> [Element]? {
        guard count > 1 else { return nil }
        return Array<Element>(dropFirst())
    }
}

public extension Sorting {

    func areInIncreasingOrder(tieBreakers: [Self]?) -> AreInIncreasingOrder {
        return {
            let comparison = self.comparing($0, $1)
            guard comparison != .orderedSame else {

                if let tieBreakers = tieBreakers, let tieBreaker = tieBreakers.removed(element: self).first {
                    return tieBreaker.areInIncreasingOrder(tieBreakers: tieBreakers.droppingFirst())($0, $1)
                } else {
                    return false
                }

//                for tieBreaker in tieBreakers {
//                    print("Using tiebreaker: `\(tieBreaker)`")
//                    guard tieBreaker.areInIncreasingOrder(tieBreakers:[])($0, $1) else { continue }
//                    print("Tiebreaker: `\(tieBreaker)` broke the tie")
//                    return true
//                }

            }
            let areInIncreasingOrder = comparison == self.targetComparisonResult
            let typeString = "\(type(of: self))"
//            print("Sorting: \($0) and \($1), using \(typeString).\(self)` had no ties, areInIncreasingOrder: `\(areInIncreasingOrder)`")
            return areInIncreasingOrder
        }

    }
}

public extension Array where Element == SortingBetweenTerms {
    static var `default`: [SortingBetweenTerms] {
        return SortingBetweenTerms.all
    }
}

public enum SortingBetweenTerms: Sorting {
    case descendingExponent
    case coefficient // positive higher than negative naturally
    case termsWithMostVariables
    case termsAlphabetically
}

public extension SortingBetweenTerms {
    static var all: [SortingBetweenTerms] {
        return [.descendingExponent, .termsWithMostVariables, .termsAlphabetically, .coefficient]
    }
}

public extension SortingBetweenTerms {

    var comparing: (Term, Term) -> (ComparisonResult) {
        switch self {
        case .descendingExponent: return { $0.highestExponent.compare(to: $1.highestExponent) }
        case .coefficient: return { $0.coefficient.compare(to: $1.coefficient) }
        case .termsWithMostVariables: return { $0.exponentiations.count.compare(to: $1.exponentiations.count) }
        case .termsAlphabetically: return { $0.variableNames.compare(to: $1.variableNames) }
        }
    }

    var targetComparisonResult: ComparisonResult {
        switch self {
        case .descendingExponent: return .orderedDescending
        case .coefficient: return .orderedDescending
        case .termsWithMostVariables: return .orderedDescending
        case .termsAlphabetically: return .orderedAscending
        }
    }

//    var defaultTieBreakers: [SortingBetweenTerms] {
//        return SortingBetweenTerms.all.removed(element: self)
//    }
}

public enum SortingWithinTerm: Sorting {
    case descendingExponent
    case variablesAlphabetically
}

public extension SortingWithinTerm {


    var comparing: (Exponentiation, Exponentiation) -> (ComparisonResult) {
        switch self {
        case .descendingExponent: return { $0.exponent.compare(to: $1.exponent) }
        case .variablesAlphabetically: return { $0.variable.name.compare(to: $1.variable.name) }
        }
    }

    var targetComparisonResult: ComparisonResult {
        switch self {
        case .variablesAlphabetically: return .orderedAscending
        case .descendingExponent: return .orderedDescending
        }
    }

//    var defaultTieBreakers: [SortingWithinTerm] {
//        switch self {
//        case .descendingExponent: return [.variablesAlphabetically]
//        case .variablesAlphabetically: return [.descendingExponent]
//        }
//    }
}

public struct TermSorting {
    public let betweenTerms: [SortingBetweenTerms]
    public let withinTerm: [SortingWithinTerm]
    public init(betweenTerms: [SortingBetweenTerms] = .default, withinTerm: [SortingWithinTerm] = .default) {
        self.betweenTerms = betweenTerms
        self.withinTerm = withinTerm
    }

    public static var `default`: TermSorting { return TermSorting() }
}

public extension TermSorting {

    init(betweenTerms: SortingBetweenTerms) {
        self.init(betweenTerms: [betweenTerms])
    }
}

extension SortingBetweenTerms: CustomStringConvertible {}
public extension SortingBetweenTerms {
    var description: String {
        switch self {
        case .descendingExponent: return "descendingExponent"
        case .coefficient: return "coefficient"
        case .termsWithMostVariables: return "termsWithMostVariables"
        case .termsAlphabetically: return "termsAlphabetically"
        }
    }
}



public extension Array where Element == SortingWithinTerm {
    static var `default`: [SortingWithinTerm] {
        return [.descendingExponent, .variablesAlphabetically]
    }
}

public extension Array where Element == Exponentiation {

    func sorted(by sorting: SortingWithinTerm) -> [Exponentiation] {
        return sorted(by: [sorting])
    }

    func sorted(by sorting: [SortingWithinTerm] = .default) -> [Exponentiation] {
        guard let first = sorting.first else { return self }
        return sorted(by: first.areInIncreasingOrder(tieBreakers: sorting.droppingFirstNilIfEmpty()))
    }

    func merged() -> [Exponentiation] {
        var count: [Variable: Double] = [:]
        for exponentiation in self {
            count[exponentiation.variable] += exponentiation.exponent
        }
        return count.map { Exponentiation($0.key, exponent: $0.value) }
    }
}

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

public extension Array where Element == Term {

    func merged() -> [Term] {
        var count: [[Exponentiation]: Double] = [:]
        for term in self {
            count[term.exponentiations] += term.coefficient
        }
        return count.map { Term(exponentiations: $0.key, coefficient: $0.value) }
    }

//    func merged() -> [Term] {
//        var count: [Term: Double] = [:]
//        for term in self {
//            guard let currentCount = count[term] else { count[term] = term.coefficient; continue }
//            count[term] = currentCount + term.coefficient
//        }
//        // removing e.g. `x-x` resulting in a 0 coefficient
//        count = count.filter {
//            $1 != 0
//        }
//        return count.map { Term(exponentiations: $0.key.exponentiations, coefficient: $0.value) }
//    }

    func sorting(betweenTerms: SortingBetweenTerms) -> [Term] {
        return sorting(betweenTerms: [betweenTerms])
    }

    func sorting(betweenTerms: [SortingBetweenTerms]) -> [Term] {
        return sorted(by: TermSorting(betweenTerms: betweenTerms))
    }

    func sorted(by sorting: TermSorting = .default) -> [Term] {
//        var terms = self
//
//        sorting.betweenTerms.forEach {
//           terms = terms.map { $0.sortingExponentiations(by: sorting.withinTerm) }.sorted(by: $0.sort)
//        }
//
//        return terms

        guard let first = sorting.betweenTerms.first else { return self }
        return sorted(by: first.areInIncreasingOrder(tieBreakers: sorting.betweenTerms.droppingFirstNilIfEmpty()))
    }

}


// MARK: - CustomStringConvertible
extension Polynomial: CustomStringConvertible {}
public extension Polynomial {

    func sortingTerms(sorting: TermSorting = .default) -> Polynomial {
        return Polynomial(terms: terms, sorting: sorting, constant: constant)
    }

    func asString(sorting betweenTerms: SortingBetweenTerms) -> String {
        return asString(sorting: TermSorting(betweenTerms: betweenTerms))
    }

    func asString(sorting: TermSorting = .default) -> String {
        let sortedPolynomial = sortingTerms(sorting: sorting)
        return sortedPolynomial.description
    }

    var description: String {
        var constantString: String {
            guard constant != 0 else { return "" }
            let constantSignString = constant > 0 ? "+" : "-"
            return " \(constantSignString) \(abs(constant).shortFormat)"
        }

        var termsString: String {
            func termString(index: Int, term: Term) -> String {
                let signStringIfNegative = term.isNegative ? term.signString : ""
                let signString = (index == 0 || index == terms.endIndex) ? "\(signStringIfNegative)" : " \(term.signString) "
                return "\(signString)\(term.description)"

            }
            return terms.enumerated().map { termString(index: $0, term: $1) }.joined()
        }

        return "\(termsString)\(constantString)"
    }
}

// MARK: - Equatable
extension Polynomial: Equatable {}
public extension Polynomial {
    static func == (lhs: Polynomial, rhs: Polynomial) -> Bool {
        return lhs.constant == rhs.constant
            && lhs.terms.sorted() == rhs.terms.sorted()
    }
}

// MARK: - Negatable
extension Polynomial: Negatable {}
public extension Polynomial {
    func negated() -> Polynomial {
        return Polynomial(terms: terms.negated(), constant: -constant)
    }
}

// MARK: - Solvable
extension Polynomial: Solvable {}
public extension Polynomial {
    func solve(constants: Set<Constant>, modulus: Double? = nil, modulusMode: ModulusMode = .alwaysPositive) -> Double? {
        guard uniqueVariables.isSubset(of: constants.map { $0.toVariable() }) else { return nil }
        let solution = terms.reduce(constant, {
            guard let solution = $1.solve(constants: constants, modulus: modulus, modulusMode: modulusMode) else { return $0 }
            return $0 + solution
        })
        guard let modulus = modulus else { return solution }
        return mod(solution, modulus: modulus, modulusMode: modulusMode)
    }
}

// MARK: - Differentiatable
extension Polynomial: Differentiatable {}
public extension Polynomial {

    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> Polynomial? {
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
}


// MARK: - Public
public extension Polynomial {

    func contains(variable: Variable) -> Bool {
        for term in terms {
            guard term.contains(variable: variable) else { continue }
            return true
        }
        return false
    }

    var uniqueVariables: Set<Variable> {
        return Set(terms.flatMap { Array($0.uniqueVariables) })
    }
}

// MARK - Appending
public extension Polynomial {

    func appending(term: Term) -> Polynomial {
        return Polynomial(terms: terms + term, constant: constant)
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

    func appending(polynomial other: Polynomial) -> Polynomial {
        return Polynomial(terms: terms + other.terms, constant: constant + other.constant)
    }
}

// MARK: Subtracting
public extension Polynomial {
    func subtracting(_ number: Double) -> Polynomial {
        return Polynomial(terms: terms, constant: constant - number)
    }

    func adding(_ number: Double) -> Polynomial {
        return Polynomial(terms: terms, constant: constant + number)
    }
}

// MARK: Multiplying
public extension Polynomial {

    func multiplied(by number: Double) -> Polynomial {
        guard let firstTerm = terms.first else { return Polynomial(terms: [], constant: constant * number) }
        let termMultiplied = Term(exponentiations: firstTerm.exponentiations, coefficient: firstTerm.coefficient * number)
        guard terms.count > 1 else { return Polynomial(termMultiplied, constant: constant) }
        let rest = terms.dropFirst()
        return Polynomial(terms: [termMultiplied] + rest, constant: constant)
    }

    func multiplied(by number: Int) -> Polynomial {
        return multiplied(by: Double(number))
    }
}

