//
//  TermProtocol+Concatenation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Private Extension Term
public extension TermProtocol {
    func multipliedBy(other: Self) -> Self {
        return Self(exponentiations: exponentiations + other.exponentiations, coefficient: coefficient*other.coefficient)!
    }

    func multiplyingCoefficientBy(constant: NumberType) -> Self? {
        return Self(exponentiations: exponentiations, coefficient: coefficient * constant)
    }
}
