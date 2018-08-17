//
//  Algebraic.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Algebraic: Solvable, Differentiatable, Equatable, CustomStringConvertible {
    //    func appending(_ other: Self) -> Polynomial
    //    func appending<A>(_ other: A) -> Polynomial where A: Algebraic
}

public protocol Concatenating {
    func concatenate(_ other: Self) -> Self

}

public protocol PolynomialConstructing {
    func concatenate(_ other: Self) -> Polynomial
}
