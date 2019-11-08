//
//  TermProtocol+CustomStringConvertible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - CustomStringConvertible
public extension TermProtocol {

    func asString(sorting: SortingWithinTerm<NumberType>) -> String {
        return asString(sorting: [sorting])
    }

    func asString(sorting: [SortingWithinTerm<NumberType>] = SortingWithinTerm<NumberType>.defaultArray) -> String {
        let sorted = sortingExponentiations(by: sorting)
        return sorted.description
    }

    var description: String {
        var exponentiationsString: String {
            return exponentiations.map { $0.description }.joined()
        }

        var coefficientString: String {
            let absoluteCoefficient = coefficient.absolute()
            guard absoluteCoefficient != .one else { return "" }
            return "\(absoluteCoefficient.shortFormat)"
        }

        return "\(coefficientString)\(exponentiationsString)"
    }
}

// MARK: - CustomDebugStringConvertible
public extension TermProtocol {
    var debugDescription: String {
        return "\(signString)\(description)"
    }
}
