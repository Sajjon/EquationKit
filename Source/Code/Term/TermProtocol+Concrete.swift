//
//  TermProtocol+Concrete.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct TermStruct<Exponentiation: ExponentiationProtocol>: TermProtocol {

    public typealias NumberType = Exponentiation.NumberType
    public typealias ExponentiationType = Exponentiation
    public let coefficient: NumberType
    public let exponentiations: [ExponentiationType]

    public init?(exponentiations: [ExponentiationType], sorting: [SortingWithinTerm<NumberType>], coefficient: NumberType) {
        guard coefficient != 0 else { return nil }
        self.exponentiations = exponentiations.merged().sorted(by: sorting)
        self.coefficient = coefficient
    }
}
