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

    init(exponentiation: Exponentiation, constant: Double = 0) {
        self.init(Term(exponentiation: exponentiation), constant: constant)
    }

    init(variable: Variable, constant: Double = 0) {
        self.init(exponentiation: Exponentiation(variable), constant: constant)
    }




    // delete either of these two, recently added the one directly below, having the label `term` during refactoring
    init(term: Term, constant: Double = 0) {
        self.init(terms: [term], constant: constant)
    }

    init(_ term: Term, constant: Double = 0) {
        self.init(terms: [term], constant: constant)
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

    func appending<F>(constant: F) -> Polynomial where F: BinaryFloatingPoint {
        return Polynomial(terms: terms, constant: self.constant + Double(constant))
    }
    
    func appending<I>(constant: I) -> Polynomial where I: BinaryInteger {
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

