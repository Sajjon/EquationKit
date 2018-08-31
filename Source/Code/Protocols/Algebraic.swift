//
//  Algebraic.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// Shared protocol by all algebraic types.
public protocol Atom {}

public protocol Algebraic: Atom, Evaluatable, Differentiatable, Hashable, CustomStringConvertible {}

public extension PolynomialProtocol {

    init(_ atom: Atom) {
        if let variable = atom as? VariableStruct<NumberType> {
            self.init(variable: variable)
        } else if let exponentiation = atom as? ExponentiationType {
            self.init(exponentiation: exponentiation)
        } else if let term = atom as? TermType {
            self.init(term: term)
        } else if let polynomial = atom as? Self {
            self.init(polynomial: polynomial)
        } else {
            fatalError("incorrect implementation")
        }
    }
}
