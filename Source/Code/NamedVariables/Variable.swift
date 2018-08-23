//
//  Variable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Variable: NamedVariable, Concatenating, Hashable, CustomStringConvertible {
    public let name: String

    init(_ name: String) {
        self.name = name
    }
}

//// MARK: - Solvable
//public extension Variable {
//    func solve(constants: Set<Constant>, modulus: Double?, modulusMode: ModulusMode) -> Double? {
//        guard let constant = constants.first(where: { $0.toVariable() == self }) else { return nil }
//        return constant.value
//    }
//}

// MARK: - Differentiatable
//public extension Variable {
//    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> Variable? {
//        guard variableToDifferentiate == self else { return nil }
//        return self
//    }
//}
