//
//  Concatenating+Multiplication.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public func *<N>(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(lhs).multiply(by: PolynomialStruct<N>(rhs))
}

//public func *(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<Int> {
//    return PolynomialStruct<Int>(lhs).multiply(by: PolynomialStruct<Int>(rhs))
//}
public func *(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).multiply(by: PolynomialStruct<Double>(rhs))
}

// MARK: - Numberic Support
public func *<N>(lhs: Concatenating, rhs: N) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(lhs).multiplied(by: rhs)
}
public func *<N>(lhs: N, rhs: Concatenating) -> PolynomialStruct<N> {
    return rhs * lhs
}

public func *(lhs: Concatenating, rhs: Double) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).multiplied(by: rhs)
}
public func *(lhs: Double, rhs: Concatenating) -> PolynomialStruct<Double> {
    return rhs * lhs
}

public func *(lhs: Concatenating, rhs: Int) -> PolynomialStruct<Double> {
    return lhs * Double(rhs)
}
public func *(lhs: Int, rhs: Concatenating) -> PolynomialStruct<Double> {
    return Double(lhs) * rhs
}

//public func *(lhs: Concatenating, rhs: Int) -> Polynomial {
//    return Polynomial(lhs).multiplied(by: rhs)
//}
//public func *(lhs: Int, rhs: Concatenating) -> Polynomial {
//    return rhs * lhs
//}
//public func *(lhs: Concatenating, rhs: Double) -> Polynomial {
//  return Polynomial(lhs).multiplied(by: rhs)
//}
//public func *(lhs: Double, rhs: Concatenating) -> Polynomial {
//    return rhs * lhs
//}


// MARK: - PRIVATE LOGIC
// MARK: - Numberic Support
//private func *<F>(lhs: Concatenating, rhs: F) -> Polynomial where F: BinaryFloatingPoint {
//    return Polynomial(lhs).multiplied(by: rhs)
//}
//
//private func *<I>(lhs: Concatenating, rhs: I) -> Polynomial where I: BinaryInteger {
//    return Polynomial(lhs).multiplied(by: rhs)
//}
//
//// MARK: - Multiplication is commutative
//private func *<F>(lhs: F, rhs: Concatenating) -> Polynomial where F: BinaryFloatingPoint {
//    return rhs * lhs
//}
//
//private func *<I>(lhs: I, rhs: Concatenating) -> Polynomial where I: BinaryInteger {
//    return rhs * lhs
//}



// MARK: - Private Extension Polynomial





// MARK: - Polynomial

