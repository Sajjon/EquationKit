//
//  PolynomialProtocol+Concrete.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct PolynomialStruct<Term: TermProtocol>: PolynomialProtocol {

    public typealias NumberType = Term.NumberType
    public typealias TermType = Term//TermStruct<Number>

    public let constant: NumberType
    public let terms: [TermType]

    public init(terms: [TermType], sorting: TermSorting<NumberType>, constant: NumberType) {
        self.terms = terms.merged().sorted(by: sorting)
        self.constant = constant
    }
    
}

// MARK: - ExpressibleByFloatLiteral
extension PolynomialStruct: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    public init(floatLiteral value: Float) {
        self.init(constant: NumberType(value))
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension PolynomialStruct: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Int) {
        self.init(constant: NumberType(value))
    }
}
