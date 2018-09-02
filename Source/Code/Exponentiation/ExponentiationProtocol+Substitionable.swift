//
//  ExponentiationProtocol+Substitionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation





// MARK: - Substitionable
public extension ExponentiationProtocol {

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return variable.uniqueVariables
    }

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: NumberType?, modulusMode: ModulusMode) -> Substitution<NumberType> {

        return parse(
            substitutionable: variable,
            constants: constants,
            modulus: modulus,
            modulusMode: modulusMode,
            handleNumber: { base in
                base.raised(to: exponent)
            },
            handleAlgebraic: { atom in
                return PolynomialType<NumberType>(atom).raised(to: self.exponent.asInteger)
            }
        )
    }


    //    func substitute(constants: Set<ConstantStruct<NumberType>>) -> Substitution<NumberType> {
    //        guard let constant = constants.first(where: { $0 == self.variable }) else {
    //            return .algebraic(self)
    //        }
    //        let base = constant.value
    //
    //        return .number(constant: base.raised(to: exponent))
    //    }

}

