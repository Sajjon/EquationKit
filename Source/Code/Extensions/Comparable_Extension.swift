//
//  Comparable_Extension.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public extension Comparable {
    func compare(to other: Self) -> ComparisonResult {
        if self > other {
            return .orderedDescending
        } else if self < other {
            return .orderedAscending
        } else if self == other {
            return .orderedSame
        } else {
            fatalError("should not happen.")
        }
    }
}
