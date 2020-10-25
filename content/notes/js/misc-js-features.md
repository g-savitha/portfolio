---
title: "Misc. Js Features"
date: 2020-08-24T11:26:25+05:30
draft: true
tags: ["javascript", "es6"]
categories: ["javascript", "es6"]
sources: ["https://www.udemy.com/course/modern-javascript/"]
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

In this article, new JS features are covered.

- Rest and Spread Operators
- Destructuring
- Default function parameters.

## Default function parameters

Before default params..

```js
function add(x, y) {
  return x + y;
}

function add(x, y) {
  y = typeof y === "undefined" ? 1 : y;
}
```

Default params:

```js
function add(x, y = 1) {
  return x + y;
}
add(4); //1
add(2, 4); //6

const hi = (person, greet = "hi") => {
  return `${greet}, ${person}`;
};

hi("anya"); // hi, anya!

const test = (x, y = [1, 2, 3]) => {
  return `${x} ${y}`;
};

test(1); //1, [1,2,3]
test(1, 3); //1,3
```

_Ordering absolutely matters in default params._

```js
const hi = (person, greet = "hi", punctuation = "!") => {
  return `${greet}, ${person} ${punctuation}`;
};
hi("anya", "?"); // ?, anya !
```

_All default params must come at the end of the list_

```js
function add(x = 1, y) {
  return x + y;
}
add(2); //NaN -> x =2, y = undefined
```

## Spread Operator

_~~IE support~~_

_**SPREAD -> EXPANDED**_

**Spread in** :

- Function calls
- Object literals
- Array literals

_Spread for function calls_:

Expands an iterable(arr,string,etc) into list of args

```js
const nums = [9, 3, 2, 8];
Math.max(nums); //NaN
//use spread
Math.max(...nums); //9
//same as calling
Math.max(9, 3, 2, 8);
```

_Spread in array literals_:

**Creates a new array using existing array**, spreads element from one array into new array.

```js
const nums1 = [9, 3, 2, 8];
const nums2 = [1, 5, 7];
[...nums1, ...nums2]; //[9,3,2,8,1,5,7]
["a", "b", ...nums2]; //[a,b,1,5,7]

const num1Clone = [...nums1]; //New array in memory with new unique ref
```

_Spread in Object Literals:_

**Copies properties of one object into another object literal.**

```js
const cat = { legs: 4, type: "cat" };
const dog = { type: "dog", furr: true };

const pup = { ...dog, isPet: true }; //{type:'dog',furr:true,isPet:true}
```

When we have _2 properties_ in different objects with _same name_, they _*override*_ each other.

```js
const pup = { ...dog, legs: 2 }; //{type:'dog',furr:true, legs:2}
const pup = { legs: 4, ...dog }; //{type:'dog',furr:true, legs:4}
```

Since _objects are not iterables_, **we cant spread objects**
