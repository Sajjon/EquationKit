//
//  Variable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public struct Variable: NamedVariable {

    public let name: String

    init(_ name: String) {
        self.name = name
    }
}
