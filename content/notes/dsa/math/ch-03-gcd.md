---
title: "GCD"
date: 2020-09-02T16:05:07+05:30
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

## LCM and HCF

#### Factors and multiples:

- All numbers that _divide a number completely_, i.e., _without leaving any remainder_, are called factors of that number.
- For example, 24 is completely divisible by 1, 2, 3, 4, 6, 8, 12, 24. Each of these numbers is called a factor of 24 and 24 is called a multiple of each of these numbers.

#### HCF or GCD :

- _The largest number that divides two or more numbers is the highest common factor (HCF)_ for those numbers.
- For example, consider the numbers 30 (2 x 3 x 5), 36 (2 x 2 x 3 x 3), 42 (2 x 3 x 7), 45 (3 x 3 x 5). 3 is the largest number that divides each of these numbers, and hence, is the HCF for these numbers.

- To **find the HCF of two or more numbers**, express each number as their prime factorization. The _**product of the minimum powers**_ _of common prime terms in both of the prime factorization_ gives the HCF. This is the method we illustrated in the above step.

- Also, for finding the HCF of two numbers, we can also proceed by long division method. We divide the larger number by the smaller number (divisor). Now, we divide the divisor by the remainder obtained in the previous stage. We repeat the same procedure until we get zero as the remainder. At that stage, the last divisor would be the required HCF.

![hcf image](https://media.geeksforgeeks.org/wp-content/cdn-uploads/gq/2016/03/hcf-long-division.png)

[GCD Application : Tiling a rectangle with squares](https://www.youtube.com/watch?v=AVrtH6m2wcU)

_Naive approach:_

```js
const GCD = (a, b) => {
  //WKT., Max GCD can be min of two given numbers, so begin with min of a & b.
  let res = Math.min(a, b);
  while (res > 0) {
    if (a % res == 0 && b % res == 0) break;
    res--;
  }
  return res;
}; //TC : O(min(a,b))
```

#### Euclidian Algorithm

The Euclidean algorithm is based on the below facts:

- GCD doesn't change, if we _subtract the smaller number from larger_ (we reduce larger number). So if we _keep subtracting repeatedly the larger of two, we end up with GCD_.


- If b is smaller than a. gcd(a,b) = gcd(a-b)
  - Let g be the gcd of a,b . where a = gx, b = gy & gcd(x,y) = 1 
  - (a-b) = gcd(x-y)
    We need to show that b and (a-b) also have gcd = 1

_Approach 2 (Euclidian algorithm):_

```js
const GCD = (a, b) => {
  //stop when a & b are equal and return either of them
  while (a != b) {
    if (a > b) a = a - b;
    else b = b - a;
  }
  return a; // or return b;
};
```
- Now _instead of doing subtraction_, if we _divide the smaller number_, the algorithm stops when the remainder is found to be 0

_Optimized euclidian algorithm:_

```js {hl_lines=[2,3]}
const GCD = (a, b) => {
  if (b == 0) return a;
  else return GCD(b, a % b); //TC :O(log(min(a,b)))
};
```

#### LCM :

- LCM is a smallest number other than 0 & 1 that is a multiple of each number.
- LCM of 4 & 6
  - Multiples of 4: 4,8,12,16,20,24,28,32...
  - Multiples of 6: 6,12,18,24,30,36,...
  - common multiples: 12,24,36,48 => Least common multiple = 12
- The lowest number which is exactly divisible by each of the given numbers is called the least common multiple of those numbers. For example, consider the numbers 3, 31 and 62 (2 x 31). The LCM of these numbers would be 2 x 3 x 31 = 186.

- To **find LCM of given numbers**: _express each number as their prime factorization_. The _**product of highest power**_ _of the prime numbers that appear in the prime factorization_ of any of the numbers gives us the LCM.
- consider the numbers 2, 3, 4 (2 x 2), 5, 6 (2 x 3). The LCM of these numbers is 2 x 2 x 3 x 5 = 60. The highest power of 2 comes from prime factorization of 4, the highest power of 3 comes from prime factorization of 3 and prime factorization of 6 and the highest power of 5 comes from prime factorization of 5.

_Naive approach:_

```js
const lcm = (a, b) => {
  //LCM would >= larger of 2 numbers 
  let res = Math.max(a, b);
  while (res) {
    if (res % a == 0 && res % b == 0) return res;
    res++;
  }
  return res;
}; // TC: O(ab-max(a,b))
```

_Efficient soln:_

> a\* b = gcd(a,b) \* lcm(a,b)
>
> - lcm(a,b) = (a\*b) / gcd(a\*b)

```js {hl_lines=[2]}
const lcm = (a, b) => {
  return (a * b) / GCD(a, b);
}; //TC: O(log(min(a,b)))
```

##### Important properties of LCM and HCF:

- For two numbers say, 'a' and 'b', _**LCM x HCF = a x b.**_
- HCF of co-primes = 1.
- For two fractions,
  - HCF = HCF (Numerators) / LCM (Denominators)
  - LCM = LCM (Numerators) / HCF (Denominators)
