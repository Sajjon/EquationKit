##### Write equations in pure Swift as expressions (not as a String) thus getting help from compiler and evaluate them.

```swift
/// https://en.wikipedia.org/wiki/Reverse_Polish_notation#Example
Equation(infix: ﹙,﹙,15, ୵,﹙,7,－,﹙,1, ＋, 1,﹚,﹚,﹚, ·, 3,﹚,－,﹙,2, ＋,﹙,1, ＋, 1,﹚,﹚).evaluate() // 5

Equation(infix: 2,⁹).evaluate() // 512

Equation(infix: 61, ％, 60).evaluate() // 1
```