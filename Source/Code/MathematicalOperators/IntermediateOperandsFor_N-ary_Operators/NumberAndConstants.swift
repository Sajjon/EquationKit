//
//  NumberAndConstants.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct NumberAndConstants<Number: NumberExpressible> {

    public let number: Number
    public let constants: Set<ConstantStruct<Number>>
    public init(number: Number, constants: Set<ConstantStruct<Number>>) {
        self.number = number
        self.constants = constants
    }

}
public extension NumberAndConstants {
    public init(number: Number, constants: [ConstantStruct<Number>]) {
        guard !constants.containsDuplicates() else { fatalError("Constants array should not contain duplicates") }
        self.init(number: number, constants: Set(constants))
    }
}

public typealias EvaluationOperand<N: NumberExpressible> = NumberAndConstants<N>
public extension EvaluationOperand {
    var reference: Number { return number }
}

public typealias ModularEvaluationOperand<N: NumberExpressible> = NumberAndConstants<N>
public extension ModularEvaluationOperand {
    var modulus: Number { return number }
}
