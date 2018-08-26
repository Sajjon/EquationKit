//
//  FloatingPointNumberExpressible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-26.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol FloatingPointNumberExpressible: NumberExpressible, BinaryFloatingPoint {
    init(_ float: Float)
}

public extension FloatingPointNumberExpressible {
    func mod(_ modulus: Self, modulusMode: ModulusMode) -> Self {
        return EquationKit.mod(self, modulus: modulus, modulusMode: modulusMode)
    }
}
