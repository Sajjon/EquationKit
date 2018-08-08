//
//  Token_Shorthand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// U+FF0B
let ＋: Token = .add

/// U+FF0D
let －: Token = .sub

/// U+0B75
let ୵: Token = .div

/// U+00B7
let ·: Token = .mul

/// U+FF05
let ％: Token = .mod

/// U+FE59 "Small Left Par"
let ﹙: Token = .parenthesis(.left)

/// U+FE5A
let ﹚: Token = .parenthesis(.right)

let ²: Term = [.pow, 2]
let ³: Term = [.pow, 3]
let ⁴: Term = [.pow, 4]
let ⁵: Term = [.pow, 5]
let ⁶: Term = [.pow, 6]
let ⁷: Term = [.pow, 7]
let ⁸: Term = [.pow, 8]
let ⁹: Term = [.pow, 9]

func variable(_ name: String, value: Int? = nil) -> Token {
    let variable = Operand.Variable(name, value: value)
    return Token.operand(.variable(variable))
}

let 𝑦: Token = variable("𝑦")
