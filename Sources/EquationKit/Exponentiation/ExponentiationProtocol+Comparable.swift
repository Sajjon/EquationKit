//
//  ExponentiationProtocol+Comparable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Equatable
public extension ExponentiationProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.variable == rhs.variable && lhs.exponent == rhs.exponent
    }
}

// MARK: - Comparable
extension ExponentiationProtocol {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return [rhs, lhs].sorted() == [lhs, rhs]
    }
}
