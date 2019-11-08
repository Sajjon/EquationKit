//
//  Modulus.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-03.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Modulus<Number: NumberExpressible> {
    public let number: Number
    public let mode: ModulusMode
    public init(_ number: Number, mode: ModulusMode = .alwaysPositive) {
        self.number = number
        self.mode = mode
    }
}

extension Modulus: ExpressibleByIntegerLiteral where Number: InitializableByInteger {//where Number: IntegerNumberExpressible {
    public typealias IntegerLiteralType = Int

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Number(value))
    }
}

extension Modulus: ExpressibleByFloatLiteral where Number: InitializableByFloat {//where Number: FloatingPointNumberExpressible {
    public typealias FloatLiteralType = Float

    public init(floatLiteral value: FloatLiteralType) {
        self.init(Number(value))
    }
}

public protocol InitializableByInteger {
    init(_ int: Int)
}
public protocol InitializableByFloat {
    init(_ float: Float)
}
extension Int: InitializableByInteger {}
extension Double: InitializableByInteger {}
extension Int: InitializableByFloat {}
extension Double: InitializableByFloat {}
