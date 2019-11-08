//
//  ModularEvaluationOperand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func % <N>(scalar: N, modulusConstants: ModularEvaluationOperand<N>) -> CongruentEqualityOperand<N> {
    return CongruentEqualityOperand(scalar: scalar, modulusConstants: modulusConstants)
}
