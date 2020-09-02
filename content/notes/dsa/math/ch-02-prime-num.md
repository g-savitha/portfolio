---
title: "Prime Numbers"
date: 2020-09-02T16:04:56+05:30
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
