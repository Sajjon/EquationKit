//
//  Vector.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Vector {}
extension Int: Vector {}
extension Int32: Vector {}
extension Double: Vector {}
extension Array: Vector where Element: Vector {
    func asTuple(choseTwo: (([Element]) -> (Element, Element)) = { ($0[0], $0[1]) }) -> (Element, Element)? {
        guard count >= 2 else { return nil }
        return choseTwo(self)
    }

    func asTripple(choseThree: (([Element]) -> (Element, Element, Element)) = { ($0[0], $0[1], $0[2]) }) -> (Element, Element, Element)? {
        guard count >= 3 else { return nil }
        return choseThree(self)
    }
}

