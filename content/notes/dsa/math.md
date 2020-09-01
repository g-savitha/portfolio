---
title: "Basic Math required for problem solving"
date: 2020-08-23T21:53:06+05:30
draft: false
tags: ["math", "ds-algo", "programming", "competitive-programming"]
categories: [dsa, math]
sources: [geeksforgeeks]
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

## Find number of digits in a number

> Given an integral number N. The task is to find the count of digits present in this number. Lets say n = 2020, number of digits in 2020 = 4 and digits are 2,0,2,0

_A simple solution is.._

- Check if number n != 0
- increment count of digits by 1 if n !=0
- reduce number by dividing it with 10
- repeat above steps, until n is reduced to 0

```cpp
//iterative
int countDigits(long n){
    int count = 0;
    while(n > 0){
        n = n/10;
        ++count;
    }
    return count;
} // TC: O(digitsCount), SC: O(1)
//recursive
int countDigits(long n){
    if(n==0) return 1;
    return 1+ countDigits(n/10);
} // TC: O(digitsCount), SC: O(digitsCount)
```

_Another approach_ :

Convert number to string and find string length

```java
    public static int countDigits(long n) {
        String num = Long.toString(n);
        return num.length();
    }//TC: O(1), SC:O(1)
```

_A better solution.._

Use Math to solve this problem. This can be easily obtained by using a formula

> number of digits in N = log10(N) + 1.

```java
    public static long countDigits(long n) {
        if (n == 0)
            return 0;
        return (int) Math.floor(Math.log10(n) + 1);
    } //TC: O(1), SC:O(1)
```

---

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

---

## Prime Numbers

Numbers > 0 which are divisible by 1 and itself. Example: 2,3,5,7,11..

### Facts about prime numbers:

- Every prime number can be represented in form of _(6n+1) and (6n-1) except 2 and 3_, when n > 0.
  - 5 : (6 \* 1 ) -1, 29: (6 \* 5) - 1
- 2 and 3 are only two consecutive natural numbers, which are prime too.
- 1 is neither prime nor composite.

> check if a number is prime or not

_Naive approach:_

- If, N < 2. It is not prime, return False.
- Else: Iterate from 2 to N-1 and check if any of the numbers between 2 and N-1 (both inclusive) divides N or not. If yes, then N is not prime, return False. Otherwise, return True.

```cpp
bool isPrime(n){
    if(n<2) return false;
    for(i = 2 i<= n; i++){
        if(n%i==0) return false;
        return true;
    }
} //TC : O(n-2) SC: O(1)
```

_A better approach:_

- _Divisors always appear in pairs_.
  - _30_: (1,30),(2,15), (3,10),(5,6)
  - if x,y is a pair then (x \* y) = n
    - if x < =y , x^2 = n, x = sqrt(n).
- we dont need to traverse numbers from 1 to n, just traverse from 2 to sqrt(n)

```cpp
bool isPrime(n){
    if(n<2) return false;
    for(i = 2 i * i<= n; i++){
        if(n%i==0) return false;
        return true;
    }
} //TC : O(sqrt(n)) SC: O(1)
```

_Max efficient method (for large values of 'n')_ :

We can save many iterations for large 'n' by checking if n % 2==0 and n%3 ==0. If we check for these two we dont need to check for multiples of 2 and 3.

```cpp
bool isPrime(n){
    if(n<2) return false;
    if(n==2 || n==3) return true;
    if(n%2==0 || n%3==0) return false;
    for(i = 5 i * i<= n; i += 6){
        if(n%i==0 || n%(i+2) ==0) return false;
    return true;
    }
}
```

### Prime Factors

> print all prime factors of n.
> If n =12 -> 2,2,3. n =13 -> 13. n = 315 -> 3,3,5,7

_Naive approach:_

```cpp
void primefactors(int n){
    for(i = 2; i <=n ;i++){
        if(isPrime(i)){ //TC: O(sqrt(n))
            int x = i;
            while(n%x==0){
                cout << i << endl;
                x = x*i;
            }
        }
    }
} //total TC ::O(n*sqrt(n) logn)
```

_Efficient solution:_

- Divisors always appear in pairs. (If we traverse from 2 to sqrt(n) we get a prime divisor)
- A number 'n' can be written as multiplication of power of prime factors
  - 12 = 2^2 \* 3
  - 450 = 2 \* 3^2 \* 5^2

```cpp
void primefactors(int n)
{
    if (n <= 1)
        return;
    for (i = 2; i * i <= n; i++)
    {
        while (n % i == 0)
        {
            printf(i);
            n = n / i;
        }
    }
    if (n > 1)
        printf(n) //cornercase : if our last(largest prime factor is of power 1 -> specify it explicitly )
}
```

_Further optimisation:_

- Take out multiples of 2 & 3 out. If num is divisible by 2 then dont check with multiples of 2. same with 3.

```js
const primefactors = (n) => {
  if (n <= 1) return;
  while (n % 2 == 0) {
    console.log(2);
    n = Math.floor(n / 2);
  }
  while (n % 3 == 0) {
    console.log(3);
    n = Math.floor(n / 3);
  }
  for (let i = 5; i * i <= n; i += 6) {
    while (n % i == 0) {
      console.log(i);
      n = Math.floor(n / i);
    }
    while (n % (i + 2) == 0) {
      console.log(i);
      n = Math.floor(n / (i + 2));
    }
  }
  if (n > 3) console.log(n); //cornercase : if our last(largest prime factor is of power 1 -> specify it explicitly )
}; // TC: O(sqrt(n))
```

### Divisors of a number

> Print all divisors of number 'n' in increaasing order.
> Eg: n= 5 -> 1,3,5,15.
> n = 100 -> 1,2,4,5,10,20,25,50,100

_Naive approach:_

```js
function divisors(n) {
  for (let i = 0; i < n; i++) {
    if (n % i == 0) console.log(i);
  }
} //TC: O(n), SC: O(1)
```

_Efficient solution:_

- Divisors always appear in pairs.
- One of the divisors in every pair is smaller than or equal to sqrt(n)
  - if x,y is a pair then (x \* y) = n
    - if x < =y , x^2 = n, x = sqrt(n).
- If we traverse from 1 to sqrt(n) we will find atleast one divisor of sqrt(n).

This approach doesn't print output in sorted order..

```js
const divisors = (n) => {
  let i;
  for (i = 1; i * i < n; i++) {
    if (n % i == 0) console.log(i);
    // for perfect squares case
    if (i != Math.floor(n / i)) console.log(n / i);
  }
}; // TC: O(sqrt(n))
```

To get output in sorted order..

```js
const divisors = (n) => {
  let i;
  for (i = 1; i * i < n; i++) {
    if (n % i == 0) console.log(i);
  }
  for (; i >= 1; i--) {
    if (n % i == 0) console.log(n / i);
  }
}; // TC: O(sqrt(n) + sqrt(n)) => O(sqrt(n))
```

- _Outer for loop traverses_ from _1(inclusive) to sqrt(n)(exclusive)._
- _Inner for loop runs_ from _sqrt(n) (inclusive) to sqrt(n) (exclusive)_

### Sieve of Eratosthenes

> Print all primes < n.
> Eg :n = 10 => 2,3,5,7. n = 23 => 2,3,5,711,13,17,19,23

This is the most efficient way of generating prime numbers upto a given number N.

_Algorithm:_

- Create _a boolean array of size n+ 1_ wih all values filled with _true_.
- _Leave the first two cells_ 0 & 1 as (0 & 1 are not primes)
- Mark _multiples of prime numbers to be false_ in the array.
- Print out _remaining true values_

```js
const sieve = (n) => {
  if (n <= 1) return;
  let isPrime = new Array(n + 1);
  isPrime.fill(true);
  // if i is true, mark all of its multiples as false
  for (let i = 2; i * i <= n; i++) {
    if (isPrime[i]) {
      for (let j = 2 * i; j <= n; j = j + i) {
        isPrime[j] = false;
      }
    }
  }
  //print all primes from the array
  for (let i = 2; i <= n; i++) {
    if (isPrime[i]) console.log(i);
  }
}; //TC: O(nloglogn)
```

A small optimisation..

```js {hl_lines=[8]}
const sieve = (n) => {
  if (n <= 1) return;
  let isPrime = new Array(n + 1);
  isPrime.fill(true);
  // if i is true, mark all of its multiples as false
  for (let i = 2; i * i <= n; i++) {
    if (isPrime[i]) {
      for (let j = i * i; j <= n; j = j + i) {
        isPrime[j] = false;
      }
    }
  }
  //print all primes from the array
  for (let i = 2; i <= n; i++) {
    if (isPrime[i]) console.log(i);
  }
}; //TC: O(nloglogn)
```

---

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
- Now _instead of subtraction_, if we _divide the smaller number_, the algorithm stops when the remainder is found to be 0

- If b is smaller than a. gcd(a,b) = gcd(a-b)
  - Let g be the gcd of a,b . where a = gx, b = gy & gcd(x,y) = 1 - (a-b) = gcd(x-y)
    We need to show that b and (a-b) also have gcd = 1

_Approach 2 (Euclidian algorithm):_

```js
const GCD = (a, b) => {
  while (a != b) {
    if (a > b) a = a - b;
    else b = b - a;
  }
  return a; // or return b;
};
```

_Optimized euclidian algorithm:_

```js
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

```js
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

---

<!-- ## Factorials -->
