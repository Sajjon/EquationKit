//
//  Parenthesis.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-08.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum Parenthesis {
    case left
    case right
}

// MARK: - CustomStringConvertible
extension Parenthesis: CustomStringConvertible {}
public extension Parenthesis {
    var description: String {
        switch self {
        case .left: return "﹙"
        case .right: return "﹚"
        }
    }
}

public extension Parenthesis {
    var isLeft: Bool {
        return self == .left
    }

    var isRight: Bool {
        return !isLeft
    }
}
