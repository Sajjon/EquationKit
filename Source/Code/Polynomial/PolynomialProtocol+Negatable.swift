//
//  PolynomialProtocol+Negatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Negatable
public extension PolynomialProtocol {
    func negated() -> Self {
        return Self(terms: terms.negated(), sorting: TermSorting<NumberType>(), constant: constant.negated())
    }
}
