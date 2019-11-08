//
//  PolynomialProtocol+Equatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Equatable
public extension PolynomialProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.constant == rhs.constant
            && lhs.terms.sorted() == rhs.terms.sorted()
    }
}
