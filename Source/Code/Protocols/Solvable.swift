//
//  Solvable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Solvable {
    func solve(constants: Set<Constant>, modulus: Double?, modulusMode: ModulusMode) -> Double?
}
