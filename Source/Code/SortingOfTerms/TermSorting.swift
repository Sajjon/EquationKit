//
//  TermSorting.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct TermSorting<Number: NumberExpressible> {
    public let betweenTerms: [SortingBetweenTerms<Number>]
    public let withinTerm: [SortingWithinTerm<Number>]
    public init(betweenTerms: [SortingBetweenTerms<Number>] = SortingBetweenTerms<Number>.defaultArray, withinTerm: [SortingWithinTerm<Number>] = SortingWithinTerm<Number>.defaultArray) {
        self.betweenTerms = betweenTerms
        self.withinTerm = withinTerm
    }
}

public extension TermSorting {

    init(betweenTerms: SortingBetweenTerms<Number>) {
        self.init(betweenTerms: [betweenTerms])
    }
}

public extension TermSorting {
    static var `default`: TermSorting {
        return descendingExponents
    }

    static var descendingExponents: TermSorting {
        return TermSorting(betweenTerms: [.descendingExponent, .termsWithMostVariables, .termsAlphabetically, .coefficient], withinTerm: [.descendingExponent, .variablesAlphabetically])
    }
}
