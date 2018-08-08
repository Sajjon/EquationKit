//
//  Parenthesis.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

enum Parenthesis: String {
    case left = "("
    case right = ")"

    var isLeft: Bool {
        return self == .left
    }

    var isRight: Bool {
        return !isLeft
    }
}
