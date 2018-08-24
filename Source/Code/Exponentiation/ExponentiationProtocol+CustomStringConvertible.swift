//
//  ExponentiationProtocol+CustomStringConvertible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - CustomStringConvertible
public extension ExponentiationProtocol {
    var description: String {
        guard exponent != 1 else { return variable.description }
        if exponent > 1 && exponent < 10 {
            let superscript: String
            if exponent == 2 {
                superscript = "²"
            } else if exponent == 3 {
                superscript = "³"
            } else if exponent == 4 {
                superscript = "⁴"
            } else if exponent == 5 {
                superscript = "⁵"
            } else if exponent == 6 {
                superscript = "⁶"
            } else if exponent == 7 {
                superscript = "⁷"
            } else if exponent == 8 {
                superscript = "⁸"
            } else if exponent == 9 {
                superscript = "⁹"
            } else { fatalError("forgot number") }
            return "\(variable)\(superscript)"
        } else {
            return "\(variable)^\(exponent.shortFormat)"
        }
    }

}
