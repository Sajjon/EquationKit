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
EquationKit is fully generic and supports any number type conforming to the protocol [`NumberExpressible`](Source/Code/Protocols/NumberExpressible.swift), Swift Foundation's `Int` and `Double` both conforms to said protocol. By conforming to `NumberExpressible` you can use EquationKit with e.g. excellent [attaswift/BigInt](https://github.com/attaswift/BigInt). You need only to copy the code from [`BigInt+IntegerNumberExpressible`](Support/BigInt/BigInt+IntegerNumberExpressible.swift)

We would like to use operator overloading, making it possible to write `x + y`, `x - 2`, `x*z² - y³` etc. Supporting operator overloading using generic `func + <N: NumberExpressible>(lhs: Variable, rhs: N) -> PolynomialStruct<N>` results in Swift compiler taking too long time to compile polynomials having over 3 terms (using Xcode 10 beta 6 at least). Thus EquationKit does not come bundled with any operator support at all. Instead, you chose your Number type yourself. If you don't need `BigInt` then `Double` is probably what you want. Just copy the file [`Double_Operators.swift`](Support/Double/Double_Operators.swift) into your project and you are good to go! It contains around 10 operators which are all 3 lines of code each.

If you need `BigInt` support, just copy the file [`BigInt_Operators.swift`](Support/BigInt/BigInt_Operators.swift) instead.

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

You can copy the contents of the file [`Double_Variables.swift`](Support/Double/Double_Variables.swift) or for BigInt support: [`BigInt_Variables.swift`](Support/BigInt/BigInt_Variables.swift) and of course extended with more variables of your choice.


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
