//
//  Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public typealias PolynomialType<N: NumberExpressible> = PolynomialStruct<TermStruct<ExponentiationStruct<N>>>

public protocol NumberTypeSpecifying {
    associatedtype NumberType: NumberExpressible
}

public protocol Differentiatable: NumberTypeSpecifying {
    func differentiateWithRespectTo(_ variableToDifferentiate: VariableStruct<NumberType>) -> PolynomialType<NumberType>?
}

