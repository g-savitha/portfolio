---
title: "Basic Math Theory"
date: 2020-09-02T16:04:36+05:30
draft: false
tags: ["math", "ds-algo", "programming", "competitive-programming"]
categories: [dsa, math]
sources: []
---

<!--

::Annotation Guide::
~~~~~~~~~~~~~~~~~~~~

* `em` is the modifier

1. em (_text_) - blue underline
2. strong (**text**) - yelow highlight
3. del (~~text~~) - red strike-through

4. em > em (_*text*_) - blue circle
5. em > strong (_**text**_) - lawngreen box
6. em > del (_~~text~~_) - red cross-off
-->

## Progressions

### Arithmetic Progression :

A sequence of numbers is said to be in an Arithmetic progression if the _difference between any two consecutive terms is always the same._ 2, 4, 6, 8, 10 is an AP series because they have a _common difference_ (4-2=6-4=8-6=10-8)

#### Few facts about AP

- _Initial Term (a)_: first number in the series
- _Common difference (d):_ The value by which consecutive terms increase or decrease
- The behavior of the AP depends on the common difference `d`. If d > 0, then the members (terms) will grow towards positive infinity. If d < 0, then the members (terms) will grow towards negative infinity.
- _nth term of AP_ : _a + (n-1)\*d_
- _Arithmetic Mean_ : Sum of all terms in the AP / Number of terms in the AP. AM of 2 terms: _(a+b) / 2_
- _sum of 'n' terms_ : 0.5 n (first term + last term) = _0.5 n [ 2a + (n-1) d ]._

### Geometric Progression.

A sequence of numbers is said to be in a Geometric progression if the _ratio of any two consecutive terms is always same_. 2, 4, 8, 16 is a GP because they have common ratio. (4 / 2 = 8 / 4 = 16 / 8 = 2).

#### Few facts about GP

- _Initial Term (a)_: first number in the series
- _Common ratio (r):_ The ratio between a term in the sequence and the term before it
- The behaviour of a geometric sequence depends on the value of the common ratio.
  - `r > 0` -> the terms will all be the same sign as the initial term.
  - `r < 0` -> the terms will alternate between positive and negative.
  - `r > 1` -> exponential growth towards positive or negative infinity (depending on the sign of the initial term).
  - ` r = 1` -> progression is a constant sequence
  - `-1<=r<=1, (but not zero)` -> exponential decay towards zero.
  - ` r = -1` -> progression is an alternating sequence.
  - `r < -1` -> for the absolute values there is exponential growth towards (unsigned) infinity, due to the alternating sign.
- _nth term of GP :_ _a\*r ^ (n-1)_.
- _Geometric Mean (GM)_ : nth root of product of n terms in the GP. GM of 2 terms : _sqrt(a\*b)_
- _Sum of ‘n’ terms of a GP_ `(r < 1)` : _[a (1 – r^n)] / [1 – r]._
- _Sum of ‘n’ terms of a GP_ `(r > 1)` : _[a ((r^n) – 1)] / [r – 1]_.
- _Sum of infinite terms of a GP_ `(r < 1)`: _(a) / (1 – r)._

### Harmonic Progression

A harmonic progression is a sequence of real numbers formed by taking the _reciprocals of an arithmetic progression._ If a,b,c,d are in an arithmetic progression, so its reciprocals 1/a, 1/b, 1/c, 1/d are in harmonic progression.

#### Few facts about HP

- _Harmonic Mean(HM) of 2 terms:_ 2ab/(a+b)
- If A,G,H are AM, GM, HM where A>=G>=H : _AH= G^2_ . A,G,H are in GP.

---

## Mean and Median

### Mean

Average of given set of data. _Mean = Total sum / n_. Its a very popular measure of central tendency, which can be used with both discrete and continous data, most often with continous data.

### Median

_Middle value of set of data_ . To get median value, numbers must be in sorted order.

- _N is odd_ : Median = middle number from sorted data :_(N+1) / 2th value_
- _N is even_ : Median = average of two middle values. : _Average of (N/2)th and {(N/2) + 1}th_ value.
- If the user adds or multiplies a constant to every value, then mean and median will also be added or multiplied by the same constant.

---

## Quadratic Equations

> _ax^2 + bx + c = 0_ Where a,b and c are real known values and, a can't be zero.

#### Roots of equation :

Roots are values for which the equation satisfies the given condition. the roots of equation x^2 - 7x - 12 = 0 are 3 and 4 respectively. If we replace the value of x by 3 and 4 individually in the equation, the equation will evaluate to zero.

_We can have 2 roots for a QE:_

> r1,r2 = (-b ± √(b^2 - 4ac))/2a

- _Determinant (D)_ : (b^2 - 4ac)

There are 3 different cases while finding the roots:

- `D < 0` 0r `b^2 < 4ac` : roots are imaginary (not real)
  - for equation, x^2 + x + 1 : r1 = -0.5 + i1.73205, r2 = -0.5 - i1.73205
- `D = 0` or `b^2 = 4ac` : roots are real and equal (r1= r2)
  - for eqn, x^2 - 2x + 1 : r1 = 1 and r2 = 1
- `D > 0` or `b^2 > 4ac` : roots are real and different
  - for eqn, x^2 - 7x - 12 : r1 =3 and r2 = 4

## Permutations and Combinations

*Permutation:* Permutation is defined as **arrangement** _of 'r' things_ _that can be done out of total 'n' things_

> Denoted by nPr = n!/(n-r)!

*Combination:* Combination is defined as **Selection** _of 'r' things_ _that can be done out of total 'n' things_

> Denoted by nCr = n!/r!(n-r)!


## Modular Arithmetic

The remainder obtained after division operation on two operands is known as modulo arithmetic. 
---

