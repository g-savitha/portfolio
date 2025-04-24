---
title: "Async and Await"
url: "/posts/async-await"
date: 2021-05-12T12:58:09+05:30
draft: false
description: "A syntactical sugar to promises"
hideToc: false
enableToc: true
enableTocContent: true
tags:
  - javascript
  - async
categories:
  - frontend
  - backend
---

Before getting started you need to know..

1. [How Asynchronous code works in JS]({{<ref "/posts/15-async-code-in-js.md">}})
2. [What are promises and how they work]({{<ref "/posts/14-promises-explained.md">}})

## Introduction

To work with async functions, we need to use callbacks or promises. Async and await makes our work easier and cleaner with promises and create synchronous looking asynchronous code

The `async` and `await` keywords enable asynchronous, promise-based behavior to be written in a cleaner style, avoiding the need to explicitly configure promise chains.

```js
function resolveAfter2Seconds() {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve("resolved");
    }, 2000);
  });
}

async function asyncCall() {
  console.log("calling");
  const result = await resolveAfter2Seconds();
  console.log(result);
  // expected output: 'resolved'
}

asyncCall();
```

### async

- Async functions always return a promise
- If the function returns a value, the promise will be resolved with that value.
- If the function throws an exception, the promise will be rejected

Lets look at few examples..

```js
async function hello() {
  return "hello world";
}
hello(); // Promise {resolved :'hello world'}

async function ohNo() {
  throw new Error("oh no!");
  ohNo(); //Promise {rejected : Error:  'oh no!'}
}
```

```js
async function greet() {
  return "Hello!!";
}

greet().then((val) => {
  console.log("Promise is resolved with :", val);
});
```

```js
//throw an exception  or an error to reject a promise
async function add(x, y) {
  if (typeof x !== "number" || typeof y !== "number")
    throw "X and Y must be numbers";
  return x + y;
}

add("e", "r")
  .then((val) => {
    console.log("Promise resolved with", val);
  })
  .catch((err) => {
    console.log("Promise rejected with", err);
  });
```

If we had to write the above code with promises, it would look like..

```js
function add(x, y) {
  return new Promise((resolve, reject) => {
    if (typeof x !== "number" || typeof y !== "number")
      reject("X and Y must be numbers");
  });
  resolve(x + y);
}
```

### await

- We can only use the `await` keyword inside of function declared as `async`.
- `await` will pause the execution of the function, waiting for the promise to be resolved. Without having to use `.next()` we can run code after an `async` operation

Before await was introduced, we had to manually resolve a promise

```js
//get the list of planets

function getPlanets() {
  return axios.get("https://swapi.dev/api/planets/");
}

getPlanets.then((res) => {
  console.log("Planets data", res.data);
});
```

With await:

```js
async function getPlanets() {
  const res = await axios.get("https://swapi.dev/api/planets/"); //await returns a promise capture it
  console.log(res.data);
}
```

> By putting await infront of a request, js will wait until the promise is resolved, it will not move on.

## Error handling in async Functions

Lets say we had a network failure or if the URL is invalid, promise gets rejected, and we are not catching it.

We have a couple of options to resolve this

1. chain `.catch()` to our method
2. Nest our logic which you think might throw an error in `try and catch` block.

```js
//1st way
async function getPlanets() {
  const res = await axios.get("https://swapi.dev/api/planets/jknkl"); //await returns a promise capture it
  console.log(res.data);
}

getPlanets().catch((err) => {
  console.log("In catch!", err);
});

//2nd way
async function getPlanets() {
  try {
    const res = await axios.get("https://swapi.dev/api/planets/jknkl");
    console.log(res.data);
  } catch (error) {
    console.log("In catch!", error);
  }
}
```

We get the same behaviour, but these two are technically different.

- Using 1st way, we can catch multiple functions that are returning promises and `.catch()` will run for any of the reason when promise gets rejected .
- Using 2nd way, catches errors only within that async function.

Using `.catch()` is more like a backup to catch multiple potential errors. try and catch is more specific to what we're trying to do and we can be more detailed how we handle it.

## Multiple awaits

Without using `.then()` 's from our previous code from promises section. lets refactor the code using await.

```js
const moveX = (element, amount, delay) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const bodyBoundary = document.body.clientWidth;
      const elRight = element.getBoundingClientRect().right;
      const currLeft = element.getBoundingClientRect().left;
      if (elRight + amount > bodyBoundary) {
        reject(bodyBoundary, elRight, amount);
      } else {
        element.style.transform = `translateX(${currLeft + amount}px)`;
        resolve();
      }
    }, delay);
  });
};
const btn = document.querySelector("button");

async function animateRight(el) {
  await moveX(el, 100, 1000); //we can await this function since it returns a promise
  moveX(el, 100, 1000);
}
```

Once we hit the end lets animate back to left

```js
//move a little more right
async function animateRight(el, amt) {
  await moveX(el, amt, 1000); //we can await this function since it returns a promise
  await moveX(el, amt, 1000);
  await moveX(el, amt, 1000);
  await moveX(el, amt, 1000);
  await moveX(el, amt, 1000);
  await moveX(el, amt, 1000);
  await moveX(el, amt, 1000);
}

animateRight(btn, 100).catch((err) => {
  console.log("All done");
  animateRight(btn, -100);
});
```

## Parallel vs Sequential requests

**Sequential Requests** :

```js
async function get3Pokemon() {
  const poke1 = await axios.get("https://pokeapi.co/api/v2/pokemon/1");
  const poke2 = await axios.get("https://pokeapi.co/api/v2/pokemon/2");
  const poke3 = await axios.get("https://pokeapi.co/api/v2/pokemon/3");
  console.log(poke1.data);
  console.log(poke2.data);
  console.log(poke3.data);
}
get3Pokemon();
```

Here poke1 is a response from promise.

Its important to know all these functions are happening in sequence. poke1 executes and returns first then poke2 and next poke3. (We dont need these to be in sequence, because these aint depending on each other.)

**Parallel Requests**: We are not going to await while sending off these requests

```js
async function get3Pokemon() {
  // all requests are sent at same time
  const prom1 = axios.get("https://pokeapi.co/api/v2/pokemon/1");
  const prom2 = axios.get("https://pokeapi.co/api/v2/pokemon/2");
  const prom3 = axios.get("https://pokeapi.co/api/v2/pokemon/3");
  console.log(prom1); //pending -> probably all 3 are pending infact
  const poke1 = await prom1; //await the response that comes back
  const poke2 = await prom2;
  const poke3 = await prom3;
  console.log(prom1); //resolved
  console.log(poke1.data);
  console.log(poke2.data);
  console.log(poke3.data);
}
get3Pokemon();
```

Here poke1 is a promise. All promises are ran first, initially they all are in pending state and all requests are sent at once over here. We are not waiting for one to complete and get resolved. first we request all at once, then we reolve them later.

To get a clear understanding try the below code in your console for a visual representation

```js
//SEQUENTIAL REQUESTS
function changeBodyColor(color, delay) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      document.body.style.backgroundColor = color;
      resolve();
    }, delay);
  });
}
async function lightShow() {
  await changeBodyColor("teal", 1000);
  await changeBodyColor("pink", 1000);
  await changeBodyColor("indigo", 1000);
  await changeBodyColor("violet", 1000);
}

lightShow();
//teal, pink, indigo, violet colors are shown one after the other with 1 sec gap -> total 4+ sec

//PARALLEL REQUESTS
async function lightShow() {
  const p1 = changeBodyColor("teal", 1000);
  const p2 = changeBodyColor("pink", 1000);
  const p3 = changeBodyColor("indigo", 1000);
  const p4 = changeBodyColor("violet", 1000);
  await p1;
  await p2;
  await p3;
  await p4;
}
//1sec.. we go straight to violet, we dont see those pauses along the way -> total 1 sec
```

> Tip:
> If you dont need your requests in sequence, do it in parallel

## Promise.all

Refactoring with promise.all.

> The Promise.all() method takes an iterable of promises as an input, and returns a single Promise that resolves to an array of the results of the input promises. This returned promise will resolve when all of the input's promises have resolved, or if the input iterable contains no promises. It rejects immediately upon any of the input promises rejecting or non-promises throwing an error, and will reject with this first rejection message / error. - MDN

```js
async function get3Pokemon() {
  const prom1 = axios.get("https://pokeapi.co/api/v2/pokemon/1");
  const prom2 = axios.get("https://pokeapi.co/api/v2/pokemon/2");
  const prom3 = axios.get("https://pokeapi.co/api/v2/pokemon/3");
  const results = await Promise.all([prom1, prom2, prom3]);
  //this line will only run when all of the promises are resolved
  printPokemon(results);
}
function printPokemon(results) {
  for (let pokemon of results) {
    console.log(pokemon.data.name);
  }
}
get3Pokemon();
```

Checkout [MDN: Promise.all](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/all)

That's all folks. Until next time :wave: , Happy learning :tada: :computer:

