//
//  Token_Shorthand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// U+FF0B
public let ＋: Token = .add

/// U+FF0D
public let －: Token = .sub

/// U+0B75
public let ୵: Token = .div

/// U+00B7
public let ·: Token = .mul

/// U+FF05
public let ％: Token = .mod

/// U+FE59 "Small Left Par"
public let ﹙: Token = .parenthesis(.left)

/// U+FE5A
public let ﹚: Token = .parenthesis(.right)

public let ²: Term = [.pow, 2]
public let ³: Term = [.pow, 3]
public let ⁴: Term = [.pow, 4]
public let ⁵: Term = [.pow, 5]
public let ⁶: Term = [.pow, 6]
public let ⁷: Term = [.pow, 7]
public let ⁸: Term = [.pow, 8]
public let ⁹: Term = [.pow, 9]

func variable(_ name: String, value: Int? = nil) -> Token {
    let variable = Variable(name, value: value)
    return Token.operand(.variable(variable))
}

public let 𝑦: Token = variable("𝑦")
