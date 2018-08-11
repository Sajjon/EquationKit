//
//  ReversePolishToken.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum ReversePolishToken {
    case operand(Operand)
    case `operator`(Operator)
}

public extension ReversePolishToken {
    init?(infix: InfixToken) {
        if let `operator` = infix.asOperator() {
            self = .operator(`operator`)
        } else if let operand = infix.asOperand() {
            self = .operand(operand)
        } else {
            return nil
        }
    }
}

// MARK: - CustomStringConvertible
extension ReversePolishToken: CustomStringConvertible {}
public extension ReversePolishToken {
    public var description: String {
        switch self {
        case .operand(let value): return value.description
        case .operator(let `operator`): return `operator`.description
        }
    }
}

// MARK: - TokenRepresentation
extension ReversePolishToken: TokenRepresentation {}
public extension ReversePolishToken {
    var isUnsetVariable: Bool {
        return false
    }
}
