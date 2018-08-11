//
//  Variable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

struct Variable: Equatable {
    let name: String
    init(_ name: String) {
        self.name = name
    }

    static func == (lhs: Variable, rhs: Variable) -> Bool {
        return lhs.name == rhs.name
    }
}
extension Variable: CustomStringConvertible {
    var description: String {
        return name
    }
}
