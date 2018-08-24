
//
//  Concatenating.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Concatenating {}

public extension NumberExpressible {
    static var typeName: String {
        let typeName = "\(type(of: self))"
        return typeName
    }
}

// MARK: - Polynomial init Concatenating
public extension PolynomialProtocol {

    static var nameOfNumberType: String {
        return NumberType.typeName
    }

    init(_ concatenating: Concatenating) {
        if let variable = concatenating as? VariableStruct<NumberType> {
            self.init(variable: variable)
        } else if let exponentiation = concatenating as? ExponentiationType {
            self.init(exponentiation: exponentiation, constant: NumberType.zero)
        } else if let term = concatenating as? TermType {
            self.init(term: term)
        } else if let polynomial = concatenating as? Self {
            self.init(terms: polynomial.terms, constant: polynomial.constant)
        } else {
            fatalError("unhandled, self.numbertype: `\(Self.nameOfNumberType)`")
        }
    }
}
