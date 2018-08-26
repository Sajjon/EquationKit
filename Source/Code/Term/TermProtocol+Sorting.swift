//
//  TermProtocol+Sorting.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public extension TermProtocol {
    
    func sortingExponentiations(by sorting: [SortingWithinTerm<NumberType>] = SortingWithinTerm<NumberType>.defaultArray) -> Self {
        return Self(exponentiations: exponentiations, sorting: sorting, coefficient: coefficient)
    }
    
    func sortingExponentiations(by sorting: SortingWithinTerm<NumberType>) -> Self {
        return sortingExponentiations(by: [sorting])
    }
}
