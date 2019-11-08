//
//  MathematicalOperatorTests.swift
//  EquationKitBigIntTests
//
//  Created by Alexander Cyon on 2018-09-01.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation
import XCTest

@testable import EquationKit
@testable import EquationKitBigIntSupport


import BigInt

// MARK: Test cases

class MathematicalOperatorTests: XCTestCase {

    static var allTests = [
        ("testSecp256k1Parameters", testSecp256k1Parameters),
        ("testSecp256r1Parameters", testSecp256r1Parameters),
        ("testSecp521r1", testSecp521r1),
        ("testInvalidParameters", testInvalidParameters),
        ("testAssignmentOperator", testAssignmentOperator),
        ("testEvaluationOperators", testEvaluationOperators),
        ("testCongruenceOperators", testCongruenceOperators),

    ]

    func testSecp256k1Parameters() {
        let a: BigInt = 0
        let b: BigInt = 7
        let p: BigInt = 2^^256 - 2^^32 - 977
        XCTAssertEqual(p.toHex(), "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F")
        XCTAssertTrue(validityOfShortWeierstraßCurveParameters(a: a, b: b, modulus: p))
    }

    func testSecp256r1Parameters() throws {
        let a = try XCTUnwrap(BigInt("FFFFFFFF00000001000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFC", radix: 16))
        let b = try XCTUnwrap(BigInt("5AC635D8AA3A93E7B3EBBD55769886BC651D06B0CC53B0F63BCE3C3E27D2604B", radix: 16))
        let p: BigInt = 2^^224 * (2^^32 - 1) + 2^^192 + 2^^96 - 1
        XCTAssertEqual(p.toHex(), "0xFFFFFFFF00000001000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF")
        XCTAssertTrue(validityOfShortWeierstraßCurveParameters(a: a, b: b, modulus: p))
    }

    func testSecp521r1() throws {

        let bigIntAHexString = """
                01FF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
            FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
            FFFFFFFF FFFFFFFF FFFFFFFC
            """.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
        let a = try XCTUnwrap(BigInt(bigIntAHexString.trimmed(), radix: 16))

        XCTAssertEqual(a.description, "6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057148")

        let p: BigInt = 2^^521 - 1
        XCTAssertEqual(p.description, "6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057151")

        XCTAssertEqual(p.toHex(prefixWith0x: false),
            """
                    01FF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
                FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
                FFFFFFFF FFFFFFFF FFFFFFFF
            """.trimmed().removeLeadingZeros()
        )

        let bigIntBHexString = """
                0051 953EB961 8E1C9A1F 929A21A0 B68540EE A2DA725B 99B315F3
            B8B48991 8EF109E1 56193951 EC7E937B 1652C0BD 3BB1BF07 3573DF88
            3D2C34F1 EF451FD4 6B503F00
        """.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)

        let b = try XCTUnwrap(BigInt(bigIntBHexString.trimmed(), radix: 16))

        XCTAssertEqual(b.description, "1093849038073734274511112390766805569936207598951683748994586394495953116150735016013708737573759623248592132296706313309438452531591012912142327488478985984")

        XCTAssertTrue(validityOfShortWeierstraßCurveParameters(a: a, b: b, modulus: p))
    }

    func testInvalidParameters() {
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: -3, b: 2, modulus: 5))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: -3, b: -2, modulus: 5))

        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 16, modulus: 62))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 15, modulus: 47))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 12, modulus: 82))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 8, modulus: 92))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 8, modulus: 46))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 6, modulus: 67))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 6, modulus: 53))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 3, modulus: 89))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 19, b: 2, modulus: 88))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 18, b: 16, modulus: 96))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 16, b: -16, modulus: 64))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 16, b: -17, modulus: 67))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 12, b: 11, modulus: 39))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 12, b: -20, modulus: 82))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 11, b: -2, modulus: 97))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 9, b: 4, modulus: 93))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 9, b: -3, modulus: 81))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: 9, b: -13, modulus: 27))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: -15, b: -7, modulus: 99))
        XCTAssertFalse(validityOfShortWeierstraßCurveParameters(a: -15, b: 18, modulus: 99))
    }

    func testAssignmentOperator() {
        XCTAssertEqual(x ≔ 2, x <- 2)
    }

    func testEvaluationOperators() {
        let poly = x² + y

        XCTAssertTrue(poly == 5 ↤ [x ≔ 2, y ≔ 1 ])
        XCTAssertFalse(poly == 1337 ↤ [x ≔ 2, y ≔ 1 ])

        XCTAssertTrue(poly != 1337 ↤ [x ≔ 2, y ≔ 1 ])
        XCTAssertFalse(poly != 5 ↤ [x ≔ 2, y ≔ 1 ])
        XCTAssertTrue(poly ≠ 1337 ↤ [x ≔ 2, y ≔ 1 ])
        XCTAssertFalse(poly ≠ 5 ↤ [x ≔ 2, y ≔ 1 ])

        let constants = [x ≔ 123, y ≔ 987 ]
        let value: BigInt = 1 << 65
        XCTAssertEqual(
            poly != value ↤ constants,
            poly ≠ value ↤ constants
        )
    }

    func testCongruenceOperators() {

        let poly = x² + y
        let op1 = 7 <-- [x <- 2, y <- 3]
        let op2 = 7 ↤ [x <- 2, y <- 3]
        XCTAssertTrue(type(of: op1) == NumberAndConstants<BigInt>.self)
        XCTAssertTrue(type(of: op2) == NumberAndConstants<BigInt>.self)

        let congruentEq = 0 % op1
        XCTAssertTrue(type(of: congruentEq) == CongruentEqualityOperand<BigInt>.self)


        XCTAssertEqual(poly =%= congruentEq, true)
        XCTAssertEqual(poly ≡≡ congruentEq, true)
        XCTAssertEqual(poly =%= congruentEq, poly ≡≡ congruentEq)
        let congruentNeq = 0 % 6 <-- [x <- 2, y <- 3]

        XCTAssertEqual(poly =%= congruentNeq, false)
        XCTAssertEqual(poly ≡≡ congruentNeq, false)
        XCTAssertEqual(poly =%= congruentNeq, poly ≡≡ congruentNeq)


        XCTAssertEqual(poly =!%= congruentEq, false)
        XCTAssertEqual(poly !≡ congruentEq, false)
        XCTAssertEqual(poly ≢ congruentEq, false)
        XCTAssertEqual(poly =!%= congruentEq, poly !≡ congruentEq)
        XCTAssertEqual(poly =!%= congruentEq, poly ≢ congruentEq)
        XCTAssertEqual(poly !≡ congruentEq, poly ≢ congruentEq)

        XCTAssertEqual(poly =!%= congruentNeq, true)
        XCTAssertEqual(poly !≡ congruentNeq, true)
        XCTAssertEqual(poly ≢ congruentNeq, true)
        XCTAssertEqual(poly =!%= congruentNeq, poly !≡ congruentNeq)
        XCTAssertEqual(poly =!%= congruentNeq, poly ≢ congruentNeq)
        XCTAssertEqual(poly !≡ congruentNeq, poly ≢ congruentNeq)
    }

}

// MARK: Private Extension
private extension MathematicalOperatorTests {

    ///      𝑆: 𝑦² = 𝑥³ + 𝐴𝑥 + 𝐵
    /// - Requires: `𝟜𝑎³ + 𝟚𝟟𝑏² ≠ 𝟘 in 𝔽_𝑝 (mod 𝑝)`
    private func validityOfShortWeierstraßCurveParameters(a: BigInt, b: BigInt, modulus 𝑝: BigInt) -> Bool {
        let 𝟜𝑎³ = 4*𝑎³
        let 𝟚𝟟𝑏² = 27*𝑏²
        let 𝟘: BigInt = 0

        return 𝟜𝑎³ + 𝟚𝟟𝑏² ≢ 𝟘 % 𝑝 ↤ [ 𝑎 ≔ a, 𝑏 ≔ b ]
    }
}


// MARK: Helpers
private let 𝑎 = Variable("𝑎")
private let 𝑏 = Variable("𝑏")
private let 𝑎³ = Exponentiation(variable: 𝑎, exponent: 3)
private let 𝑏² = Exponentiation(variable: 𝑏, exponent: 2)

extension BigInt {
    func toString(uppercased: Bool = true, radix: Int) -> String {
        let stringRepresentation = String(self, radix: radix)
        guard uppercased else { return stringRepresentation }
        return stringRepresentation.uppercased()
    }

    func toHex(prefixWith0x: Bool = true) -> String {
        let prefix = prefixWith0x ? "0x" : ""
        return prefix + toString(radix: 16)
    }
}

extension String {
    var containsWhitespace: Bool {
        return(rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}

extension BigInt {
    public init(stringLiteral value: StringLiteralType) {
        var hexString = value.trimmed()
        if hexString.starts(with: "0x") {
            hexString = String(hexString.dropFirst(2))
        }
        self.init(hexString, radix: 16)!
    }
}

extension String {

    func trimmed() -> String {
        // As of Xcode 10 Beta 6 there is a bug (or strange feature?) using multiline strings (```) and `trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)`, which does not remove whitespace or newlines. Luckily, good old `replacingOccurrences` works however.
        return replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
    }

    func removeLeadingZeros() -> String {
        var string = self
        while string.first == "0" {
            string = String(string.dropFirst())
        }
        return string
    }
}
