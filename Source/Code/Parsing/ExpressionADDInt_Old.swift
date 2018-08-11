//
//  ParseExpression.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

//enum AdditionOrSubtraction {
//    case add(Add)
//    case sub(Sub)
//}
//
//
//extension Expression {
//    func asAddition() -> Add? {
//        guard let `operator` = asOperator() else { return nil }
//        return `operator` as? Add
//    }
//    func asSubtraction() -> Sub? {
//        guard let `operator` = asOperator() else { return nil }
//        return `operator` as? Sub
//    }
//    func asAdditionOrSubtraction() -> AdditionOrSubtraction? {
//        if let addition = asAddition() {
//            return .add(addition)
//        } else if let subtraction = asSubtraction() {
//            return .sub(subtraction)
//        } else { return nil }
//    }
//}


//func merge(lhs: AdditionOrSubtraction, rhs: Int, function: Operator.Function) -> Expression {
//    fatalError()
////    switch lhs {
////    case .add(let addition):
////        return Expression.add(lhs, rhs)
////    default:
////        fatalError()
////    }
//}
//
//// MARK: - Expression ADD Int
//func +(lhs: Expression, rhs: Int) -> Expression {
//    // (x + 3) + 5  <==>  (x + 8)
//    // (x - 3) + 5  <==>  (x + 8)
//    // (x * 3) + 5  UNCHANGED
//    // (x / 3) + 5  UNCHANGED
//    guard let addOrSub = lhs.asAdditionOrSubtraction() else { return Expression.add(lhs, rhs) }
//    return merge(lhs: addOrSub, rhs: rhs, function: Add.function)
//}
//
///// Addition is Commutative, lets set the standard to always be `Expression + 1`
//func +(lhs: Int, rhs: Expression) -> Expression {
//    return rhs + lhs // flipping because of Commutative and setting a `Expression + 1` convention
//}


// MARK: - Expression SUB Int
//func -(lhs: Expression, rhs: Int) -> Expression {
//    // (x + 3) - 1  <==>  (x + 2)
//    // (x - 3) - 1  <==>  (x - 4)
//    // (x * 3) - 1  UNCHANGED
//    // (x / 3) - 1  UNCHANGED
//    guard let addOrSub = lhs.asAdditionOrSubtraction() else { return Expression.sub(lhs, rhs) }
//    return merge(lhs: addOrSub, rhs: rhs, function: Sub.function)
//}
//
//func -(lhs: Int, rhs: Expression) -> Expression {
//    // 1 - (x + 3)  <==>  (x - 2)
//    // 1 - (x * 3)  <==>  (x - 2)
//    // 1 - (x + 3)  <==>  (x - 2)
//    // 1 - (x + 3)  <==>  (x - 2)
//    guard let addOrSub = rhs.asAdditionOrSubtraction() else { return Expression.sub(lhs, rhs) }
//    return merge(lhs: lhs, rhs: rhs, function: Sub.function)
//}
