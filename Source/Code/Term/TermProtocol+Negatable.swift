//
//  TermProtocol+Negatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Negatable
public extension TermProtocol {
    func negated() -> Self {
        return Self(exponentiations: exponentiations, coefficient: coefficient.negated())
    }
}
