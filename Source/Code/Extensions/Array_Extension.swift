//
//  Array_Extension.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    public func containsDuplicates() -> Bool {
        return Set<Element>(self).count != count
    }
}

extension Array {
    static func +(array: Array, element: Element) -> Array {
        return array + [element]
    }
}
extension Array where Element: Equatable {
    func removed(element: Element) -> [Element] {
        guard contains(element) else { return self }
        var elements = self
        elements.removeAll { $0 == element }
        return elements
    }
}

public extension Array {
    func droppingFirst() -> [Element] {
        guard count > 1 else { return [] }
        return Array<Element>(dropFirst())
    }

    func droppingFirstNilIfEmpty() -> [Element]? {
        guard count > 1 else { return nil }
        return Array<Element>(dropFirst())
    }
}
