//
//  TermProtocol+AbsoluteConvertible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-31.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - AbsoluteConvertible
public extension TermProtocol {
    func absolute() -> Self {
        return Self(exponentiations: exponentiations, coefficient: coefficient.absolute())!
    }
}
