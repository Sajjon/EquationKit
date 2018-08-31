//
//  AbsoluteConvertible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-31.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol AbsoluteConvertible {

    /// Turns `3y - 2x - 5` => `3y + 2x + 5`
    func absolute() -> Self

}

extension Array: AbsoluteConvertible where Element: AbsoluteConvertible {
    public func absolute() -> [Element] {
        return map { $0.absolute() }
    }
}
