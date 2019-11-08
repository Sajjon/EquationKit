//
//  PolynomialProtocol+CustomStringConvertible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - CustomStringConvertible
public extension PolynomialProtocol {

    func sortingTerms(sorting: TermSorting<NumberType>) -> Self {
        return Self(terms: terms, sorting: sorting, constant: constant)
    }

    func asString(sorting betweenTerms: SortingBetweenTerms<NumberType>) -> String {
        return asString(sorting: TermSorting(betweenTerms: betweenTerms))
    }

    func asString(sorting: TermSorting<NumberType>) -> String {
        let sortedPolynomial = sortingTerms(sorting: sorting)
        return sortedPolynomial.description
    }

    var description: String {
        var constantString: String {
            guard constant != .zero else { return "" }
            let constantSignString = constant.isPositive ? "+" : "-"
            return " \(constantSignString) \(constant.absolute().shortFormat)"
        }

        var termsString: String {
            func termString(index: Int, term: TermType) -> String {
                let signStringIfNegative = term.isNegative ? term.signString : ""
                let signString = (index == 0 || index == terms.endIndex) ? "\(signStringIfNegative)" : " \(term.signString) "
                return "\(signString)\(term.description)"

            }
            return terms.enumerated().map { termString(index: $0, term: $1) }.joined()
        }

        return "\(termsString)\(constantString)"
    }
}
