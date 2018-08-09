//
//  TokenRepresentation.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol TokenRepresentation: CustomStringConvertible {
    var isUnsetVariable: Bool { get }
}
