//
//  Sorting.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Sorting: Equatable {
    associatedtype TypeToSort //: NumberTypeSpecifying
    typealias AreInIncreasingOrder = (TypeToSort, TypeToSort) -> (Bool)
    func areInIncreasingOrder(tieBreakers: [Self]?) -> AreInIncreasingOrder
    var comparing: (TypeToSort, TypeToSort) -> (ComparisonResult) { get }
    var targetComparisonResult: ComparisonResult { get }
}

public extension Sorting {

    func areInIncreasingOrder(tieBreakers: [Self]?) -> AreInIncreasingOrder {
        return {
            let comparison = self.comparing($0, $1)
            guard comparison != .orderedSame else {
                if let tieBreakers = tieBreakers, let tieBreaker = tieBreakers.removed(element: self).first {
                    return tieBreaker.areInIncreasingOrder(tieBreakers: tieBreakers.droppingFirst())($0, $1)
                } else {
                    return false
                }
            }
            return comparison == self.targetComparisonResult
        }
    }
}
