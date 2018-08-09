//
//  Precedence.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum Precedence: Int {
    case function = 0
    case addition = 1
    case multiplication = 5
    case power = 10
    case unary = 100
}

extension Precedence: Comparable {}
public extension Precedence {
    static func < (lhs: Precedence, rhs: Precedence) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    static func == (lhs: Precedence, rhs: Precedence) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
