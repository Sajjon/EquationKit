//
//  SortingBetweenTerms.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum SortingBetweenTerms<Number: NumberExpressible>: Sorting {
      public typealias TypeToSort = TermStruct<Number>
    case descendingExponent
    case coefficient // positive higher than negative naturally
    case termsWithMostVariables
    case termsAlphabetically
}

public extension SortingBetweenTerms {

    static var defaultArray: [SortingBetweenTerms] {
        return [.descendingExponent, .termsWithMostVariables, .termsAlphabetically, .coefficient]
    }
}

public extension SortingBetweenTerms {

    var comparing: (TypeToSort, TypeToSort) -> (ComparisonResult) {
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

//public extension Array where Element == SortingBetweenTerms {
//    static var `default`: [SortingBetweenTerms] {
//        return SortingBetweenTerms.all
//    }
//}

public extension Array where Element: TermProtocol {

    func merged() -> [Element] {
        var count: [[Element.ExponentiationType]: Element.NumberType] = [:]
        for term in self {
            count[term.exponentiations] += term.coefficient
        }
        return count.map { Element.init(exponentiations: $0.key, coefficient: $0.value) }
    }

    func sorting(betweenTerms: SortingBetweenTerms<Element.NumberType>) -> [Element] {
        return sorting(betweenTerms: [betweenTerms])
    }

    func sorting(betweenTerms: [SortingBetweenTerms<Element.NumberType>] = SortingBetweenTerms<Element.NumberType>.defaultArray) -> [Element] {
        return sorted(by: TermSorting<Element.NumberType>(betweenTerms: betweenTerms))
    }

    func sorted(by sorting: TermSorting<Element.NumberType> = .default) -> [Element] {
        guard let first = sorting.betweenTerms.first else { return self }

        let areInIncreasingOrderClosure: (Element, Element) -> Bool = {
            guard
                let lhs = $0 as? TermStruct<Element.NumberType>,
                let rhs = $1 as? TermStruct<Element.NumberType>
                else {
                    fatalError("what to do")
            }

            return first.areInIncreasingOrder(tieBreakers: sorting.betweenTerms.droppingFirstNilIfEmpty())(lhs, rhs)
        }

        return sorted(by: areInIncreasingOrderClosure)
    }

}
