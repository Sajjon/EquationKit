//
//  ModulusFunction.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func mod<T>(_ number: T, modulus: T, modulusMode: ModulusMode = .alwaysPositive) -> T where T: BinaryInteger {
    var mod = number % modulus
    guard modulusMode == .alwaysPositive else { return mod }
    if mod < 0 {
        mod = mod + modulus
    }
    guard mod >= 0 else { fatalError("NEGATIVE VALUE") }
    return mod
}

public func mod<F>(_ number: F, modulus: F, modulusMode: ModulusMode = .alwaysPositive) -> F where F: BinaryFloatingPoint {
    var mod = number.truncatingRemainder(dividingBy: modulus)
    guard modulusMode == .alwaysPositive else { return mod }
    if mod < 0 {
        mod = mod + modulus
    }
    guard mod >= 0 else { fatalError("NEGATIVE VALUE") }
    return mod
}
