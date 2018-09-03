//
//  PolynomialProtocol+Concrete.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct PolynomialStruct<Term: TermProtocol>: PolynomialProtocol {

    public typealias NumberType = Term.NumberType
    public typealias TermType = Term

    public let constant: NumberType
    public let terms: [TermType]

    public init(terms: [TermType], sorting: TermSorting<NumberType>, constant: NumberType) {
        self.terms = terms.merged().sorted(by: sorting)
        self.constant = constant
    }
}

//// MARK: - ExpressibleByIntegerLiteral
//extension PolynomialStruct: ExpressibleByIntegerLiteral where Term.NumberType: InitializableByInteger {
//    public typealias IntegerLiteralType = Int
//    public init(integerLiteral value: Int) {
//        self.init(constant: NumberType(value))
//    }
//}
//
//extension PolynomialStruct: ExpressibleByFloatLiteral where Term.NumberType: InitializableByFloat {
////    public typealias IntegerLiteralType = Int
////    public init(integerLiteral value: Int) {
////        self.init(constant: NumberType(value))
////    }
//
//    public typealias FloatLiteralType = Float
//
//    public init(floatLiteral value: FloatLiteralType) {
//        self.init(constant: NumberType(value))
//    }
//}
