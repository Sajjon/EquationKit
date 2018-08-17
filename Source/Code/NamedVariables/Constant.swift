//
//  Constant.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Constant: NamedVariable {
    public let name: String
    public let value: Double
    public init(_ name: String, value: Double) {
        self.name = name
        self.value = value
    }
}

// MARK: - Convenience Initializers
public extension Constant {
    init(_ variable: Variable, value: Double) {
        self.init(variable.name, value: value)
    }

    init(_ variable: Variable, value: Int) {
        self.init(variable, value: Double(value))
    }
}

// MARK: - Public
public extension Constant {
    func toVariable() -> Variable {
        return Variable(name)
    }
}

// MARK: - CustomStringConvertible
public extension Constant {
    var description: String {
        return "<\(name)=\(value.shortFormat)>"
    }
}
