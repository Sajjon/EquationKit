//
//  SortingBetweenTerms.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

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

public extension Array where Element == SortingBetweenTerms {
    static var `default`: [SortingBetweenTerms] {
        return SortingBetweenTerms.all
    }
}
