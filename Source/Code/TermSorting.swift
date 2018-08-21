//
//  TermSorting.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

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
