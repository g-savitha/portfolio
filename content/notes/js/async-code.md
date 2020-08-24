---
title: "Asynchronous Code in Javascript"
date: 2020-08-23T22:01:45+05:30
draft: true
tags: []
categories: []
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

## The Call Stack

> The mechanism JS interpreter uses to keep track of its place in a script that calls multiple functions. How JS "knows" what function is currently being run and what functions are called within a function, etc.

## How it works?

- When a script calls a function, _interpreter adds it to the call stack_ and then starts carrying out the function.
- Any _functions that are called by that function are added to the call stack further up_, and run where their calls are reached.
- When the current function is finished, _interpreter takes it off the stack and resumes execution_ where it left off in the last code listing.

## JS is single threaded

At any given point in time, that single JS thread is running atmost one line of JS code. Its not multi tasking, it does one thing at a time.

User may not be able to do another task until one is completed.

```js
console.log("first");
alert("hi");
console.log("second");
```

You _wont get output_ of 2nd console.log _until alert hi is closed_.When we try to access data from a database or an api or trying to save something or to set timer, we cant let user to keep on waiting until we get the data. We have a work around for this **Asynchronous callbacks**.

## How Asynchronous callbacks work?

**Pass a callback function fot the processes that take time** and those functions will be executed at the appropriate time.

Set timer for 3 seconds.

```js
console.log("first");
setTimeout(() => {
  console.log("I print after 3 sec");
}, 3000);
console.log("second");
```

But how does JS know to set a timer for 3 seconds if it can only do 1 thing at a time? how does it remember to wait for 3 seconds and call that fn after 3 sec?

The trick here is **The browser does the work**. JS is not same as our browser, it is a language that is implemented in our browser. Generally _*browsers*_ like chrome, safari and IE _**are written in a different programming language**_ (C++ here for those 3).

Browser itself is capable of doing certain tasks, where JS sucks at or things that take time are handed off to the browser.

> Note: JS is not keeping track of timer , it is not sending an API request. **The browser actually handles it**

## But how does browser do that?

Browsers come with _web API_ that are able to handle certain tasks in the background(like making requests or setTimeOut). The J**S call stack recognizes these web API functions and passes themoff to the browser** to take care of. Once the browser finishes those tasks they return and are pushed onto the stack as callback.

```js
console.log("first"); // ran by javascript
//js passes entire setTimeOut to be run by C++ or the language in which browser is implemented in.
//and continues executing next line of code
setTimeout(function () {
  console.log("I print after 3 sec");
}, 3000);
console.log("second"); // ran by javascript
```

### Concurrency and the event loop

The reason why we can do things concurrently is that browser is more than just runtime.
