//
//  IntegerNumberExpressible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol IntegerNumberExpressible: NumberExpressible, BinaryInteger {
    init(_ int: Int)
}

public extension IntegerNumberExpressible {
    func mod(_ modulus: Self, mode: ModulusMode) -> Self {
        return EquationKit.mod(self, modulus: Modulus(modulus, mode: mode))
    }
}
