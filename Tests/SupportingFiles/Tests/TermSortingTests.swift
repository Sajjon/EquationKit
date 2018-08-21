//
//  TermSortingTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-18.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest
@testable import EquationKit

let tx = Term(x)
let －tx = tx.negated()

let ty = Term(y)
let －ty = ty.negated()

let tz = Term(z)
let －tz = tz.negated()

let tx² = Term(exponentiation: x²)
let －tx² = tx².negated()

let ty² = Term(exponentiation: y²)
let －ty² = ty².negated()

let tz² = Term(exponentiation: z²)
let －tz² = tz².negated()

let tx³ = Term(exponentiation: x³)
let －tx³ = tx³.negated()

let ty³ = Term(exponentiation: y³)
let －ty³ = ty³.negated()

let tz³ = Term(exponentiation: z³)
let －tz³ = tz³.negated()

let tx⁴ = Term(x⁴)

let txyz = Term(x, y, z)
let －txyz = txyz.negated()

let txy = Term(x, y)
let －txy = txy.negated()
let txz = Term(x, z)
let －txz = txz
let tx²z³ = Term(x², z³)
let －tx²z³ = tx²z³.negated()
let tx²y²z² = Term(x², y², z²)
let －tx²y²z² = tx²y²z².negated()
let tx²y²z³ = Term(x²,y²,z³)
let －tx²y²z³ = tx²y²z³.negated()

class TermSortingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testTrivial() {

        func trivial(_ terms: [Term]) {
            XCTAssertEqual(terms, terms)
        }
        trivial([tx])
        trivial([ty])
        trivial([tz])
        trivial([tx, tx])
        trivial([ty, ty])
        trivial([tz, tz])
        trivial([tx, ty])
        trivial([tx, tz])
        trivial([ty, tx])
        trivial([ty, tz])
        trivial([tz, tx])
        trivial([tz, ty])
        trivial([tx, ty, tz])
        trivial([tx, tz, ty])
        trivial([ty, tz, tx])
        trivial([tz, tx, ty])
        trivial([tz, ty, tx])
    }

    func testSingleSortingWithOneElement() {
        let terms = [tx]
        SortingBetweenTerms.all.forEach {
            XCTAssertEqual(terms[0], terms.sorting(betweenTerms: $0)[0])
        }
    }

    func testSingleSortingWithTwoSortedElement() {
        let terms = [tx, ty]
        SortingBetweenTerms.all.forEach {
            XCTAssertEqual(terms, terms.sorting(betweenTerms: $0))
        }
    }

    func testSingleSortingWithTwoElementsUnsortedAlphabetically() {
        let terms = [ty, tx]
        XCTAssertEqual(terms.sorting(betweenTerms: .coefficient), terms)
        XCTAssertEqual(terms.sorting(betweenTerms: .descendingExponent), terms)
        XCTAssertEqual(terms.sorting(betweenTerms: .termsWithMostVariables), terms)
        XCTAssertEqual(terms.sorting(betweenTerms: .termsAlphabetically), [tx, ty])
    }

    func testSingleSortingElementsUnsortedExponent() {
        let terms = [ty², tz³, ty, tx², tx³, tx]
        XCTAssertEqual(terms.sorting(betweenTerms: .coefficient), terms)
        XCTAssertEqual(terms.sorting(betweenTerms: .termsWithMostVariables), terms)
        XCTAssertEqual(terms.sorting(betweenTerms: .termsAlphabetically), [tx², tx³, tx, ty², ty, tz³])
        XCTAssertEqual(terms.sorting(betweenTerms: .descendingExponent), [tz³, tx³, ty², tx², ty, tx])
    }

    func testSingleSortingElementsCoefficients() {
        let terms = [－tz, ty², －tz³, －ty, tx², －tx³, tx, ty³]
        XCTAssertEqual(terms.sorting(betweenTerms: .termsWithMostVariables), terms)
        XCTAssertEqual(terms.sorting(betweenTerms: .descendingExponent), [－tz³, －tx³, ty³, ty², tx², －tz, －ty, tx])
        XCTAssertEqual(terms.sorting(betweenTerms: .termsAlphabetically), [tx², －tx³, tx, ty², －ty, ty³, －tz, －tz³])
        XCTAssertEqual(terms.sorting(betweenTerms: .coefficient), [ty², tx², tx, ty³, －tz, －tz³, －ty, －tx³])
    }

    func testSortingOfTermsOfPolynomialByMostVariables() {
        let eq = 2*x*y + 3*y + 5*x
        XCTAssertEqual(eq.asString(sorting: TermSorting(betweenTerms: [.termsWithMostVariables, .termsAlphabetically])), "2xy + 5x + 3y")
    }

    func testSortingOfTermsOfPolynomialByAlphabeticOrder() {
        let eq = 2*x*y + 3*y + 5*x
        XCTAssertEqual(eq.asString(sorting: TermSorting(betweenTerms: [.termsWithMostVariables, .termsAlphabetically])), "2xy + 5x + 3y")

    }


    func testXYEqualsYX() {
        let tyx = Term(y, x)
        XCTAssertEqual(txy, tyx)
    }

    func testSortingOfExponentiationsInsideTerms() {
        XCTAssertEqual(txyz.variableNames, "xyz")
        XCTAssertEqual(tx²z³.asString(sorting: .variablesAlphabetically), "x²z³")
        XCTAssertEqual(tx²z³.asString(sorting: .descendingExponent), "z³x²")
    }

    func testSingleSortingMultiVariantAlphabetically() {

        XCTAssertEqual([tz, tx, txy].sorting(betweenTerms: .termsAlphabetically), [tx, txy, tz])
        XCTAssertEqual([tx, txy, tz].sorting(betweenTerms: .termsAlphabetically), [tx, txy, tz])

        // Alphabetical sorting is coefficient (sign) agnositc
        XCTAssertEqual([－txyz, txyz].sorting(betweenTerms: .termsAlphabetically), [－txyz, txyz])
        XCTAssertEqual([txyz, －txyz].sorting(betweenTerms: .termsAlphabetically), [txyz, －txyz])

        // Alphabetical sorting is exponent agnositc
        XCTAssertEqual([txyz, tx²y²z²].sorting(betweenTerms: .termsAlphabetically), [txyz, tx²y²z²])
        XCTAssertEqual([tx²y²z², txyz].sorting(betweenTerms: .termsAlphabetically), [tx²y²z², txyz])

        XCTAssertEqual([txyz, tx].sorting(betweenTerms: .termsAlphabetically), [tx, txyz])
    }

    func testSingleSortingExponentTwoValues() {
        let terms = [tx²z³, tx³]
        XCTAssertEqual(terms.sorting(betweenTerms: .descendingExponent), [tx²z³, tx³])
    }

    func testSortingMultiExponentiationTermsAlphabetically() {
        let terms = [tx²y²z³, ty]
        XCTAssertEqual(terms, terms.map { $0.sortingExponentiations(by: .descendingExponent) })
        XCTAssertEqual(terms.sorting(betweenTerms: .termsAlphabetically), [ty, tx²y²z³])
        XCTAssertEqual(terms.map { $0.sortingExponentiations(by: .variablesAlphabetically) } .sorting(betweenTerms: .termsAlphabetically), [tx²y²z³, ty])
    }

    func testSingleSortingElementsUnsortedByVariableCount() {
        let terms = [－txyz, tx²y²z², －tx²z³, －ty, tx², －tx³, txy, tx²y²z³, tx⁴].map { $0.sortingExponentiations(by: .variablesAlphabetically) }

        SortingBetweenTerms.all.forEach {
            XCTAssertEqual(terms.sorting(betweenTerms: $0), terms.sorting(betweenTerms: $0))
        }

        XCTAssertEqual(tx²y²z³.description, "z³x²y²")

        XCTAssertEqual(terms.sorting(betweenTerms: .coefficient), [tx²y²z², tx², txy, tx²y²z³, tx⁴, －txyz, －tx²z³, －ty, －tx³])
        XCTAssertEqual(terms.sorting(betweenTerms: .descendingExponent),  [tx⁴, －tx²z³, －tx³, tx²y²z³, tx²y²z², tx², －txyz, －ty, txy])
        XCTAssertEqual(terms.sorting(betweenTerms: .termsAlphabetically), [tx², －tx³, tx⁴, txy, －txyz, tx²y²z², tx²y²z³, －tx²z³, －ty].map { $0.sortingExponentiations(by: .variablesAlphabetically) } )
    }

    func testMultiSortingAlreadySortedComplicated() {
       let sorted = [tx⁴, ty³, tx², txz ,tx, ty]
        XCTAssertEqual(sorted, sorted.sorted())
        XCTAssertEqual(sorted, sorted.reversed().sorted())
    }

    func testComparable() {
        // We are comparing the expected inter term order
        XCTAssertLessThan(tx, ty, "we prefer `x + y` over `y + x`")
        XCTAssertLessThan(tx², tx, "we prefer `x² + x` over `x + x²`")
        XCTAssertLessThan(txz, tx, "we prefer `xz + x` over `x + xz`")
        XCTAssertLessThan(tx, －tx, "we prefer `x - x` over `-x + x`")

        // inverse of above, using `GreaterThan`
        XCTAssertGreaterThan(ty, tx, "we prefer `x + y` over `y + x`")
        XCTAssertGreaterThan(tx, tx², "we prefer `x² + x` over `x + x²`")
        XCTAssertGreaterThan(tx, txz, "we prefer `xz + x` over `x + xz`")
        XCTAssertGreaterThan(－tx, tx, "we prefer `x - x` over `-x + x`")
    }

}
