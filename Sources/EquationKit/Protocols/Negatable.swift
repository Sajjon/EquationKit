//
//  Negatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Negatable {
    func negated() -> Self
}

extension Array: Negatable where Element: Negatable {
    public func negated() -> [Element] {
        return map { $0.negated() }
    }
}
