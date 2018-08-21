//
//  NamedVariable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol NamedVariable: CustomStringConvertible, Hashable, Comparable {
    var name: String { get }
}

// MARK: - Equatable
public extension NamedVariable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - Comparable
public extension NamedVariable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.name < rhs.name
    }
}

// MARK: - Hashable
public extension NamedVariable {
    var hashValue: Int {
        return name.hashValue
    }
}

// MARK: - CustomStringConvertible
public extension NamedVariable {
    var description: String {
        return name
    }
}
