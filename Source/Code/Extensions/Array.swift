//
//  Array.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    public func containsDuplicates() -> Bool {
        return Set(self).count != count
    }
}

extension Array {
    static func +(array: Array, element: Element) -> Array {
        return array + [element]
    }
}
