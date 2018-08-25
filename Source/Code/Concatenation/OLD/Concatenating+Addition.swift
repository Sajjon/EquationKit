//
//  Concatenating+Addition.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-22.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

//public typealias Polynomial = PolynomialStruct<Double>

///// Concatenate `lhs` and `rhs` using addition
public func +<N>(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(lhs).appending(polynomial: PolynomialStruct<N>(rhs))
}

public func +(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).appending(polynomial: PolynomialStruct<Double>(rhs))
}











// MARK: - Numberic Support
public func +<N>(lhs: Concatenating, rhs: N) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(lhs).appending(constant: rhs)
}
public func +(lhs: Concatenating, rhs: Double) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).appending(constant: rhs)
}
public func +(lhs: Double, rhs: Concatenating) -> PolynomialStruct<Double> {
    return rhs + lhs
}
public func +(lhs: Concatenating, rhs: Int) -> PolynomialStruct<Double> {
    return lhs + Double(rhs)
}
public func +(lhs: Int, rhs: Concatenating) -> PolynomialStruct<Double> {
    return Double(lhs) + rhs
}

// Addition is commutative
public func +<N>(lhs: N, rhs: Concatenating) -> PolynomialStruct<N> {
    return rhs + lhs

}

//// Double and Int support
//public func +(lhs: Concatenating, rhs: Double) -> PolynomialStruct<Double> {
//    return PolynomialStruct<Double>(lhs).appending(constant: rhs)
//}
//
//public func +(lhs: Int, rhs: Concatenating) -> PolynomialStruct<Double> {
//    return Double(lhs) + lhs
//}

/////// Concatenate `lhs` and `rhs` using addition
//public func +<N>(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<N> {
//    return PolynomialStruct<N>(lhs) + PolynomialStruct<N>(rhs)
//}
//
//// MARK: - Numberic Support
//public func +<N>(lhs: Concatenating, rhs: Int) -> PolynomialStruct<N> {
//    return PolynomialStruct<N>(lhs) + rhs
//}
//
//public func +<N>(lhs: Concatenating, rhs: Double) -> PolynomialStruct<N> {
//    return PolynomialStruct<N>(lhs) + rhs
//}
//public func +<N>(lhs: Double, rhs: Concatenating) -> PolynomialStruct<N> {
//    return lhs + PolynomialStruct<N>(rhs)
//}
//public func +<N>(lhs: Int, rhs: Concatenating) -> PolynomialStruct<N> {
//    return lhs + PolynomialStruct<N>(rhs)
//}


// MARK - Polynomial Extension




/// Concatenate `lhs` and `rhs` using addition
public func -<N>(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(lhs).subtracting(other: PolynomialStruct<N>(rhs))
}

public func -(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(lhs).subtracting(other: PolynomialStruct<Double>(rhs))
}

//public func -(lhs: Concatenating, rhs: Concatenating) -> PolynomialStruct<Int> {
//    return PolynomialStruct<Int>(lhs).subtracting(other: PolynomialStruct<Int>(rhs))
//}

private func -<N>(lhs: Concatenating, rhs: PolynomialStruct<N>) -> PolynomialStruct<N> {
    return lhs - (rhs as Concatenating)
}

// MARK: - Numberic Support
public func -<N>(lhs: Concatenating, rhs: N) -> PolynomialStruct<N> {
    return lhs - PolynomialStruct<N>(constant: rhs)
}
public func -(lhs: Concatenating, rhs: Double) -> PolynomialStruct<Double> {
    return lhs - PolynomialStruct<Double>(constant: rhs)
}
public func -(lhs: Concatenating, rhs: Int) -> PolynomialStruct<Double> {
    return lhs - Double(rhs)
}

public func -<N>(lhs: N, rhs: Concatenating) -> PolynomialStruct<N> {
    return PolynomialStruct<N>(constant: lhs) - rhs
}

public func -(lhs: Double, rhs: Concatenating) -> PolynomialStruct<Double> {
    return PolynomialStruct<Double>(constant: lhs) - rhs
}
public func -(lhs: Int, rhs: Concatenating) -> PolynomialStruct<Double> {
    return Double(lhs) - rhs
}





//public func -(lhs: Concatenating, rhs: Int) -> Polynomial {
//    return lhs - Polynomial(constant: rhs)
//}
//
//public func -(lhs: Int, rhs: Concatenating) -> Polynomial {
//    return Polynomial(constant:lhs) - rhs
//}
//
//public func -(lhs: Concatenating, rhs: Double) -> Polynomial {
//    return lhs - Polynomial(constant: rhs)
//}
//
//public func -(lhs: Double, rhs: Concatenating) -> Polynomial {
//    return Polynomial(constant:lhs) - rhs
//}

// MARK - Private Polynomial Extension

