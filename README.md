## Write equations in pure Swift, differentiate and/or solve them.

```swift
let equation = (3*x + 5*y - 17) * (7*x - 9*y + 23)
print(equation) // 21x² + 8xy - 50x - 45y² + 268y - 391)
let solution = equation.solve() {[ x <- 4, y <- 1 ]}
print(solution) // 0

let y＇ = equation.differentiateWithRespectTo(x)
print(y＇) // 42x + 8y - 50
y＇.solve() {[ x <- 1, y <- 1 ]} // 0

let x＇ = equation.differentiateWithRespectTo(y)
print(x＇) // 8x - 90y + 268
 x＇.solve() {[ x <- 11.5,  y <- 4 ]} // 0
```

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

## Supported
- Single and multivariate equations (no limitation to how many variables, go crazy!)
- Differentiate any single or multivariate equation with respect to some of its variables
- Multiply equations with equations
- Modulus

## Limitations

### Not supported, but on roadmap
- [ ] Substitution `(3*(4*x + 5)^^2 - 2*(4x+5) - 1).substitute() { z <~ (4*x + 5) }` // `3*z²-2*z-1`  
- [ ] Division  
- [ ] Big number support  


### Not supported and not on roadmap
- Variables in exponents, such as `2^x`
- `log`/`ln` functions
- Trigonometric functions (`sin`, `cos`, `tan` etc.)
- Complex numbers 
