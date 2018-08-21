//
//  Double_Extension.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public extension Double {
    var shortFormat: String{
        let decimalsEqualToZero = truncatingRemainder(dividingBy: 1) == 0
        let format = decimalsEqualToZero ? "%.0f" : "%.2f"
        return String(format: format, self)
    }
}
