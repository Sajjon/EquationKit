//
//  Optional_Numeric.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Numeric {
    func equals(_ other: Wrapped) -> Bool {
        guard let number = self else { return false }
        return number == other
    }
}
