//
//  SortingWithinTerm.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum SortingWithinTerm<Number: NumberExpressible>: Sorting {
    public typealias TypeToSort = ExponentiationStruct<Number>
    case descendingExponent
    case variablesAlphabetically

    public static var defaultArray: [SortingWithinTerm] {
        return [.descendingExponent, .variablesAlphabetically]
    }
}

public extension SortingWithinTerm {


    var comparing: (TypeToSort, TypeToSort) -> (ComparisonResult) {
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
}
//public extension Array where Element == SortingWithinTerm {
//    static var `default`: [SortingWithinTerm] {
//        return [.descendingExponent, .variablesAlphabetically]
//    }
//}

public extension Array where Element: ExponentiationProtocol {

    func sorted(by sorting: SortingWithinTerm<Element.NumberType>) -> [Element] {
        return sorted(by: [sorting])
    }

    func sorted(by sorting: [SortingWithinTerm<Element.NumberType>] = SortingWithinTerm<Element.NumberType>.defaultArray) -> [Element] {
        guard let first = sorting.first else { return self }

        let areInIncreasingOrderClosure: (Element, Element) -> Bool = {
            guard
                let lhs = $0 as? ExponentiationStruct<Element.NumberType>,
                let rhs = $1 as? ExponentiationStruct<Element.NumberType>
                else {
                    fatalError("what to do")
            }

            return first.areInIncreasingOrder(tieBreakers: sorting.droppingFirstNilIfEmpty())(lhs, rhs)
        }

        return sorted(by: areInIncreasingOrderClosure)
    }

    func merged() -> [Element] {
        var count: [VariableStruct<Element.NumberType>: Element.NumberType] = [:]
        for exponentiation in self {
            count[exponentiation.variable] += exponentiation.exponent
        }
        return count.map { Element.init(variable: $0.key, exponent: $0.value) }
    }
}
