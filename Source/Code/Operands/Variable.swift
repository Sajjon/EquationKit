//
//  Variable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Negatable {
    func negated() -> Self
}

extension Int: Negatable {
    public func negated() -> Int {
        return -self
    }
}

extension Expression: Negatable {
    func negated() -> Expression {
        switch self {
        case .operand(let operand): return .operand(operand.negated())
        case .operator: return self // do nothing
        }
    }
}

struct Variable: Equatable {
    let name: String
    let isNegative: Bool
    init(_ name: String, isNegative: Bool = false) {
        self.name = name
        self.isNegative = isNegative
    }

    static func == (lhs: Variable, rhs: Variable) -> Bool {
        let sameName = lhs.name == rhs.name
        if sameName && (lhs.isNegative != rhs.isNegative) { fatalError("How to handle this? Probably return `false`?") }
        return sameName
    }
}

extension Variable: Negatable {
    public func negated() -> Variable {
        return Variable(name, isNegative: !isNegative)
    }
}

extension Variable: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        return "\(sign)\(name)"
    }

    private var sign: String {
        guard isNegative else { return "" }
        return "-"
    }

    var debugDescription: String {
        return "\(printName(self))(\(sign)\(name))"
    }
}
