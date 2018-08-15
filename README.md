##### Write equations in pure Swift, differentiate and solve them.

```swift
let equation = (3*x + 5*y - 17) * (7*x - 9*y + 23)
print(equation) // 21x² + 8xy - 50x - 45y² + 268y - 391)

let y＇ = equation.differentiateWithRespectTo(x)
print(y＇) // 42x + 8y - 50
y＇.solve() {[ x == 1, y == 1 ]} // 0

let x＇ = equation.differentiateWithRespectTo(y)
print(x＇) // 8x - 90y + 268
 x＇.solve() {[ x == 11.5,  y == 4 ]} // 0
```