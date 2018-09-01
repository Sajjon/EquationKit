## Write equations in pure Swift, differentiate and/or evaluate them.

```swift
let polynomial = (3*x + 5*y - 17) * (7*x - 9*y + 23)
print(polynomial) // 21x² + 8xy - 50x - 45y² + 268y - 391)
let number = polynomial.evaluate() {[ x <- 4, y <- 1 ]}
print(number) // 0

let y＇ = equation.differentiateWithRespectTo(x)
print(y＇) // 42x + 8y - 50
y＇.evaluate() {[ x <- 1, y <- 1 ]} // 0

let x＇ = equation.differentiateWithRespectTo(y)
print(x＇) // 8x - 90y + 268
 x＇.evaluate() {[ x <- 11.5,  y <- 4 ]} // 0
```

## Generics
EquationKit is fully generic and supports any number type conforming to the protocol [`NumberExpressible`](Source/Code/NumberExpressible/NumberExpressible.swift), Swift Foundation's `Int` and `Double` both conforms to said protocol. By conforming to `NumberExpressible` you can use EquationKit with e.g. excellent [attaswift/BigInt](https://github.com/attaswift/BigInt). You need only to copy the code from [`BigInt+IntegerNumberExpressible`](Support/BigInt/BigInt+IntegerNumberExpressible.swift)

We would like to use operator overloading, making it possible to write `x + y`, `x - 2`, `x*z² - y³` etc. Supporting operator overloading using generic `func + <N: NumberExpressible>(lhs: Variable, rhs: N) -> PolynomialStruct<N>` results in Swift compiler taking too long time to compile polynomials having over 3 terms (using Xcode 10 beta 6 at least). Thus EquationKit does not come bundled with any operator support at all. Instead, you chose your Number type yourself. If you don't need `BigInt` then `Double` is probably what you want. Just copy the file [`Double_Operators`](Support/Double/Double_Operators.swift) into your project and you are good to go! It contains around 10 operators which are all 3 lines of code each.

If you need `BigInt` support, just copy the file [`BigInt_Operators`](Support/BigInt/BigInt_Operators.swift) instead.

## Variables
You write powers using the custom operator `x^^2`, but for powers between `2` and `9` you can use the [unicode superscript symbols](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts#Superscripts_and_subscripts_block) instead, like so:
```swift
let x = Variable("x")
let y = Variable("y")
let x² = Exponentiation(x, exponent: 2)
let x³ = Exponentiation(x, exponent: 3)
let x⁴ = Exponentiation(x, exponent: 4)
let x⁵ = Exponentiation(x, exponent: 5)
let x⁶ = Exponentiation(x, exponent: 6)
let x⁷ = Exponentiation(x, exponent: 7)
let x⁸ = Exponentiation(x, exponent: 8)
let x⁹ = Exponentiation(x, exponent: 9)

let y² = Exponentiation(y, exponent: 2)
```

You can copy the contents of the file [`Double_Variables`](Support/Double/Double_Variables.swift) or for BigInt support: [`BigInt_Variables`](Support/BigInt/BigInt_Variables.swift) and of course extended with more variables of your choice.

## Advanced operators
You can use some of the advanced mathematical operators provided in the folder [MathematicalOperators](Source/Code/MathematicalOperators) to precisely express the mathematical constraints you might have.

### Variable to Constant (evaluation)
Let's have a look at one of the simplest scenario:

Using the special Unicode char `≔` (single character for `:=` often used in literature for `assignment` of value.) we can write evaluations as:
```swift
𝑦² - 𝑥³.evaluate() {[ x ≔ 1, y ≔ 2 ]} 
```

Instead of:
```swift
𝑦² - 𝑥³.evaluate() {[ x <- 1, y <- 2 ]} 
```

### Complex examples

 Below is the example of how [`EllipticCurveKit`](https://github.com/Sajjon/EllipticCurveKit) uses `EquationKit` to express requirements on the elliptic curve parameters. Elliptic curves on the Weierstraß form requires this congruence inequality to hold:

```math
𝟜𝑎³ + 𝟚𝟟𝑏² ≢ 𝟘 mod 𝑝
```

Thanks to `EquationKit` we can express said inequality almost identically to pure math in Swift:
```swift
𝟜𝑎³ + 𝟚𝟟𝑏² ≢ 0 % 𝑝 
```

But that is not enough since we also need to evaluate said inequality (polynomial) using the arguments passed in the initializer. We can of course write
```swift
(𝟜𝑎³ + 𝟚𝟟𝑏²).evaluate(modulus: 𝑝) {[ 𝑎 ≔ a, 𝑏 ≔ b ]} != 0
```

But a slightly more "mathy" syntax would be:
```swift
𝟜𝑎³ + 𝟚𝟟𝑏² ≢ 𝟘 % 𝑝 ↤ [ 𝑎 ≔ a, 𝑏 ≔ b ]
```


Which evaluates the polynomial `𝟜𝑎³ + 𝟚𝟟𝑏²` given `a` and `b` and performs modulo `𝑝` and compares it to `0`. We could of co, of course, support for this syntax as well:
```swift
// This syntax is not yet supported, but can easily be added
[a→𝑎, b→𝑏] ⟼ 𝟜𝑎³ + 𝟚𝟟𝑏² ≢ 𝟘 % 𝑝
```

We can of course also write this without using any special unicode char, like so:
```swift
4*a^^3 + 27*b^^2 =!%= 0 % p <-- [ a ≔ constA, b ≔ constB ]
```
where `=!%=` replaces `≢`.

Please give feedback on the choice of operators, by [submitting an issue](https://github.com/Sajjon/EquationKit/issues/new).

```swift
let 𝑎 = Variable("𝑎")
let 𝑏 = Variable("𝑏")
let 𝑎³ = Exponentiation(𝑎, exponent: 3)
let 𝑏² = Exponentiation(𝑏, exponent: 2)

let 𝟜𝑎³ = 4*𝑎³
let 𝟚𝟟𝑏² = 27*𝑏²
let 𝟘: BigInt = 0

///
/// Elliptic Curve on Short Weierstraß form (`𝑆`)
/// - Covers all elliptic curves char≠𝟚,𝟛
/// - Mixed Jacobian coordinates have been the speed leader for a long time.
///
///
/// # Equation
///      𝑆: 𝑦² = 𝑥³ + 𝑎𝑥 + 𝑏
/// - Requires: `𝟜𝑎³ + 𝟚𝟟𝑏² ≠ 𝟘 in 𝔽_𝑝 (mod 𝑝)`
///
struct ShortWeierstraßCurve {
    /// Try to initialize an elliptic curve on the ShortWeierstraß form using parameters for `a`, `b` in the given Galois field (mod 𝑝).
    public init(a: BigInt, b: BigInt, field 𝑝: BigInt) throws {
        guard 
            𝟜𝑎³ + 𝟚𝟟𝑏² ≢ 𝟘 % 𝑝 ↤ [ 𝑎 ≔ a, 𝑏 ≔ b ]
        else { throw EllipticCurveError.invalidCurveParameters }
        self.a = a
        self.b = b
        self.field = 𝑝
    }
}
```


## Supported
- Single and multivariate equations (no limitation to how many variables, go crazy!)
- Differentiate any single or multivariate equation with respect to some of its variables
- Multiply equations with equations
- Modulus
- BigInt support

## Limitations

### Not supported, but on roadmap
- Substitution `(3*(4*x + 5)^^2 - 2*(4x+5) - 1).substitute() { z <~ (4*x + 5) }` // `3*z²-2*z-1`  
- Division
- Finding roots (solving)


### Not supported and not on the roadmap
- Variables in exponents, such as `2^x`
- `log`/`ln` functions
- Trigonometric functions (`sin`, `cos`, `tan` etc.)
- Complex numbers 
