//
//  Extension_Array.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-09.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Array {
    mutating func pop(_ n: Int) -> [Element] {
        guard count >= n else { return [] }
        var popped = [Element]()
        for _ in 0..<n {
            popped.append(removeLast())
        }
        return popped.reversed()
    }
}

extension RangeReplaceableCollection {
    static func + (lhs: Element, rhs: Self) -> Self {
        return [lhs] + rhs
    }

    static func + (lhs: Self, rhs: Element) -> Self {
        return lhs + [rhs]
    }
}
