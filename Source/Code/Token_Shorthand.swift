//
//  InfixToken_Shorthand.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

/// U+FF0B
public let ＋: InfixToken = .add

/// U+FF0D
public let －: InfixToken = .sub

/// U+00B7
public let ·: InfixToken = .mul

/// U+0B75
public let ୵: InfixToken = .div

/// U+FF05
public let ％: InfixToken = .mod

/// U+FF3E
public let ＾: InfixToken = .pow

/// U+FE59 "Small Left Par"
public let ﹙: InfixToken = .parenthesis(.left)

/// U+FE5A
public let ﹚: InfixToken = .parenthesis(.right)

public let ²: Term = [.pow, 2]
public let ³: Term = [.pow, 3]
public let ⁴: Term = [.pow, 4]
public let ⁵: Term = [.pow, 5]
public let ⁶: Term = [.pow, 6]
public let ⁷: Term = [.pow, 7]
public let ⁸: Term = [.pow, 8]
public let ⁹: Term = [.pow, 9]

func variable(_ name: String, value: Int? = nil) -> InfixToken {
    let variable = Variable(name, value: value)
    return InfixToken.operand(.variable(variable))
}

public let 𝑦: InfixToken = variable("𝑦")
