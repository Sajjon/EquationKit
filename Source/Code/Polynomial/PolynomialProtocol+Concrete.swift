//
//  PolynomialProtocol+Concrete.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct PolynomialStruct<Number: NumberExpressible>: PolynomialProtocol {

    public typealias NumberType = Number
    public typealias TermType = TermStruct<Number>

    public let constant: NumberType
    public let terms: [TermType]

    public init(terms: [TermType], sorting: TermSorting<NumberType>, constant: NumberType) {
        self.terms = terms.merged().sorted(by: sorting)
        self.constant = constant
    }
    
}
