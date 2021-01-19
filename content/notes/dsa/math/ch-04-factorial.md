---
title: "Factorial"
date: 2020-09-02T16:05:24+05:30
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

## Factorial
- Factorial of a positive integer n, denoted by `n!` is the _product of all positive integers <= n_

>Find factorial of a given number, where n>=0
```example
Ip: n = 4
Op: 24, 
Ip: n= 6
Op:720
Ip: n=0
Op: 1
```

*Iterative solution:*

```java
int fact(int n){
    int res = 1;
    for(int i = 2; i<=n;i++){
        res=res*i;
    }
    return res;
} //TC: O(n), SC: O(1)
```

*Recursive solution:*

```java
int fact(int n){
    if(n==0 || n==1) return 1;
    return n * fact(n-1);
} // TC: O(n), SC:O(n)
```

>Find trailing zeroes in a factorial.
```example
Input: n = 5
Output: 1 
Factorial of 5 is 120 which has one trailing 0.

Input: n = 20
Output: 4
Factorial of 20 is 2432902008176640000 which has
4 trailing zeroes.

Input: n = 100
Output: 24
```

*Naive solution:*

```js
const fact = (n) => {
    if(n===0||n===1) return 1;
    let fact = 1;
    for(let i = 2; i <= n; i++){
        fact *=i;
    }
    return fact;
}
const trailingZeroes = (n) =>{
   let res = fact(n);
   let count = 0;
   while(res%10===0){
       count++;
       res/=10;
   }
   return count;
}
console.log(trailingZeroes(5)); // 2
//TC: O(n);
```
Major issue with the above solution is it causes overflow even if the n is slightly higher. 

*Efficient solution:*

Count number of 2s and 5s in the prime factorization of given factorial. 
- One interesting fact about factorials is number of 5s are < number of 2s. So we simply need to _**find number of 5s**_ in the given number. 
- 1x2x3x4x5x6x7x8x9x10....n -> Notice that every 5th number is going to have 5 as a prime factor. If we have a n as a number, then we have atleast _floor(n/5)_ prime factors.
  - Why atleast? consider the case of 25. We have two 5s as prime factors. We have to consider these as well.
  - > General formula: Trailing zero count = floor(n/5) + floor(n/25) + floor(n/125) + ......

```js {hl_lines=[4]}
const efficientTrailZeroes = (n) =>{
    let res = 0;
    //first ompute n/5, then compute n/25, then compute n /125 ...
    for(let i = 5; i <=n; i *=5){
        res += n/i;
    }
    return Math.floor(res);
}
console.log(efficientTrailZeroes(251));
// 5^k <=n , k <= log5(n); TC: O(log5(n)) 
```

This solution solves the major issue of overflow because we are not calculating factorial here , we are dividing the given number based on number of 5s