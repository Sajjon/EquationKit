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
public extension Term {
    static var ＋: Term { return .token(EquationKit.＋) }
}

/// U+FF0D
public let －: InfixToken = .sub
public extension Term {
    static var －: Term { return .token(EquationKit.－) }
}

/// U+00B7
public let ·: InfixToken = .mul
public extension Term {
    static var ·: Term { return .token(EquationKit.·) }
}

/// U+0B75
public let ୵: InfixToken = .div
public extension Term {
    static var ୵: Term { return .token(EquationKit.୵) }
}

/// U+FF05
public let ％: InfixToken = .mod
public extension Term {
    static var ％: Term { return .token(EquationKit.％) }
}

/// U+FF3E
public let ＾: InfixToken = .pow
public extension Term {
    static var ＾: Term { return .token(EquationKit.＾) }
}

/// U+FE59 "Small Left Par"
public let ﹙: InfixToken = .parenthesis(.left)
public extension Term {
    static var ﹙: Term { return .token(EquationKit.﹙) }
}

/// U+FE5A
public let ﹚: InfixToken = .parenthesis(.right)
public extension Term {
    static var ﹚: Term { return .token(EquationKit.﹚) }
}

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
    return .operand(.variable(variable))
}

//extension Term {
//    static func variable(_ name: String, value: Int? = nil) -> Term {
//        return .token(EquationKit.variable(name, value: value))
//    }
//}

public let 𝑦: InfixToken = variable("𝑦")
extension Term {
    static var 𝑦: Term = .token(EquationKit.𝑦)
}

public let 𝑥: InfixToken = variable("𝑥")
extension Term {
    static var 𝑥: Term = .token(EquationKit.𝑥)
}

public let 𝑎: InfixToken = variable("𝑎")
extension Term {
    static var 𝑎: Term = .token(EquationKit.𝑎)
}

public let 𝑏: InfixToken = variable("𝑏")
extension Term {
    static var 𝑏: Term = .token(EquationKit.𝑏)
}

// MARK: Binary Operators
public extension Term {
    static var add: Term {
        return .token(.add)
    }

    static var sub: Term {
        return .token(.sub)
    }

    static var mul: Term {
        return .token(.mul)
    }

    static var div: Term {
        return .token(.div)
    }

    static var mod: Term {
        return .token(.mod)
    }

    static var pow: Term {
        return .token(.pow)
    }
}
