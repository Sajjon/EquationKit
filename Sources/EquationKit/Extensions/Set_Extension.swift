//
//  Set_Extension.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-09-02.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Set {
    /// Returns the union between this and `other` but `Element` being that of `other`.
    /// 1. Maps the set `other` to the same elements as this set:
    /// 2. Performs the union between these to sets
    /// 3. Returns the elements in the original set `other`, that exists in the union.
    public func unionTo<O>(other: Set<O>, transform: (O) -> (Element)) -> Set<O> {
        return Set<O>(union(Set<Element>(other.map(transform))).compactMap { element in other.first(where: { element == transform($0) }) })
    }
}
