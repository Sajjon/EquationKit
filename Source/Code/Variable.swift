//
//  Variable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Variable {
    let name: String
    let value: Int?

    public init(_ name: String, value: Int? = nil) {
        self.name = name
        self.value = value
    }
}

// MARK: - CustomStringConvertible
extension Variable: CustomStringConvertible {}
public extension Variable {
    var description: String {
        let valueString = value != nil ? " value: \(value!)" : ""
        return "\(name)\(valueString)"
    }
}
