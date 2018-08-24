//
//  TermProtocol+Comparable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Equatable
public extension TermProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.exponentiations.sorted() == rhs.exponentiations.sorted() && lhs.coefficient == rhs.coefficient
    }
}

// MARK: - Comparable
extension TermProtocol {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return [rhs, lhs].sorted() == [lhs, rhs]
    }
}
