---
title: "Asynchronous Code in Javascript"
url: "/posts/async-js"
date: 2021-05-12T12:09:58+05:30
draft: false
description: "Explains how asynchronous code works in javascript"
hideToc: false
enableToc: true
enableTocContent: true
tags:
  - javascript
  - async
categories:
  - javascript
---

Hey there :wave:,

Before diving into the world of asynchronous events, lets first understand what happens when you execute a function? where do they get stored in memory? How does the interpreter knows the order of the functions to be executed? Can we run multiple functions at a time?

Without making any further delay, lets get started...

## The call stack

> The mechanism JS interpreter uses to keep track of its place in a script that calls multiple functions.

Ever wondered how JS "knows" what function is currently being executed and what functions need to be called next? with the help of call stack.

## How does it work?

- When a script calls a function, _interpreter adds it to the call stack_ and then starts carrying out the function.
- Any _functions that are called by that function are added to the call stack further up_, and run where their calls are reached.
- When the current function is finished, _interpreter takes it off the stack and resumes execution_ where it left off in the last code listing.

## JS is single threaded

At any given point in time, a single JS thread is running atmost one line of JS code. Its not multi tasking, it does one thing at a time.

User may not be able to do another task until one is completed.

```js
console.log("first");
alert("hi");
console.log("second");
```

You _wont get output_ of 2nd console.log _until alert hi is closed_.When we try to access data from a database or an api or trying to save something or to set timer, we cant let user to keep on waiting until we get the data. Don't we have any workaround for this? We do **Asynchronous callbacks**.

## How Asynchronous callbacks work?

**Pass a callback function for the processes that take time** and those functions will be executed at the appropriate time.

Set timer for 3 seconds.

```js
console.log("first");
setTimeout(() => {
  console.log("I print after 3 sec");
}, 3000);
console.log("second");
```

But how does JS know to set a timer for 3 seconds if it can only do 1 thing at a time? how does it remember to wait for 3 seconds and call that function after 3 sec?

The trick here is **The browser does the work**. JS is not same as our browser, it is a language that is implemented in our browser. Generally browsers like chrome, safari and IE _**are written in a different programming language**_ (C++ here for those 3).

Browser itself is capable of doing certain tasks, where JS sucks at or things that take time are handed off to the browser.

> Note: JS is not keeping track of timer , it is not sending an API request. **The browser handles that**

## But how does browser do that?

Browsers come with _web API_ that are able to handle certain tasks in the background(like making requests or setTimeOut). The **JS call stack recognizes these web API functions and passes them off to the browser** to take care. Once the browser finishes those tasks they return and are pushed onto the stack as callback.

```js
console.log("first"); // ran by javascript
//js passes entire setTimeOut to be run by C++ or the language in which browser is implemented in.
//and continues executing next line of code
setTimeout(function () {
  console.log("I print after 3 sec");
}, 3000);
console.log("second"); // ran by javascript
```

Once the browser finishes of setTimeOut it asks JS to run that callback . It places that callback on the call stack so that JS knows to run that function. JS doesnt keep the time. Same thing with making request, JS doesnt make the request itself the browser and the web api do.

### Concurrency and the event loop

The reason why we can do things concurrently is that browser is more than just runtime.

![img](https://i.imgur.com/0ezmrxc.png)

This diagram basically looks identical to Node's architecture, instead of Web apis we have c++ apis(because browser is implemented in c++) and the threading being hidden from us is done by c++.

![conc1](https://i.imgur.com/fqgTJSW.png)

The setTimeOut api is provided by browser. It doesnt live in V8 source, its the extra we are getting in the environment we are running the javascript

![con2](https://i.imgur.com/9t3s16V.png)

Now that setTimeOut is out of call stack we can execute other lines of code.

![con3](https://i.imgur.com/M7419eD.png)
The timer in web api cant just start modifying our code, it cant chuck stuff on to the stack when its ready if it did, it would randomly appear in middle of the queue. So any of the `webapis pushes the callbacks onto task queue` when its done.

### Event loop

Event loop has the one simple job. Its job is to look at the stack and look at the task queue. **If the stack is empty**,it takes the first thing on the queue and pushes it onto the stack which effectively runs it.

> Note:  
> Event loop pushes the callback onto stack, only when its empty.

![e1](https://i.imgur.com/P7R16zR.png)
![e2](https://i.imgur.com/CiGP5JA.png)

- _The above used images above are taken from [this video](https://www.youtube.com/watch?v=8aGhZQkoFbQ&feature=youtu.be)_

> Note:  
> AJAX requests, DOM, Event Listeners, setTimeOut etc are handled by Web APIs. [Here are the list of web apis](https://developer.mozilla.org/en-US/docs/Web/API)

> Also check out video on [event loops](https://www.youtube.com/watch?v=8aGhZQkoFbQ&feature=youtu.be) for more info.

> To visualize how things work in the background check this [tool](http://latentflip.com/loupe/?code=JC5vbignYnV0dG9uJywgJ2NsaWNrJywgZnVuY3Rpb24gb25DbGljaygpIHsKICAgIHNldFRpbWVvdXQoZnVuY3Rpb24gdGltZXIoKSB7CiAgICAgICAgY29uc29sZS5sb2coJ1lvdSBjbGlja2VkIHRoZSBidXR0b24hJyk7ICAgIAogICAgfSwgMjAwMCk7Cn0pOwoKY29uc29sZS5sb2coIkhpISIpOwoKc2V0VGltZW91dChmdW5jdGlvbiB0aW1lb3V0KCkgewogICAgY29uc29sZS5sb2coIkNsaWNrIHRoZSBidXR0b24hIik7Cn0sIDUwMDApOwoKY29uc29sZS5sb2coIldlbGNvbWUgdG8gbG91cGUuIik7!!!PGJ1dHRvbj5DbGljayBtZSE8L2J1dHRvbj4%3D)

---

Now we know why callbacks are so important in javascript. We pass a callback in to certain functions that the browser takes over.

But callbacks are not perfect, they can get messy very quickly.

_In the below example, you dont need to worry what `transform` and `translate` are. Just imagine there is a button on the page, every time the below function executes, it moves right by 100px_

{{< codes html js>}}
{{< code >}}

```html
<body>
  <button>Move me</button>
  <script src="app.js"></script>
</body>
```

{{< /code >}}
{{< code >}}

```js
const btn = document.querySelector("button");
setTimeout(() => {
  btn.style.transform = `translateX(100px)`; //moves the button to the right by 100px
}, 1000);
```

{{< /code >}}
{{< /codes >}}

Now lets say i want to move this button 5 levels deeper for every 1 sec. We need to nest this function .(_move 5 times towards right_)

```js
setTimeout(() => {
  btn.style.transform = `translateX(100px)`;
  setTimeout(() => {
    btn.style.transform = `translateX(200px)`;
    setTimeout(() => {
      btn.style.transform = `translateX(300px)`;
      setTimeout(() => {
        btn.style.transform = `translateX(400px)`;
        setTimeout(() => {
          btn.style.transform = `translateX(500px)`;
        }, 1000);
      }, 1000);
    }, 1000);
  }, 1000);
}, 1000);
```

Let's refactor this

```js
const moveX = (element, amount, delay, callback) => {
  setTimeout(() => {
    element.style.tranform = `translateX(${amount}px)`;
    if (callback) callback();
  }, delay);
};

moveX(btn, 100, 1000, () => {
  moveX(btn, 200, 1000, () => {
    moveX(btn, 300, 1000, () => {
      moveX(btn, 400, 1000, () => {
        moveX(btn, 500, 1000);
      });
    });
  });
});
```

Even this doesnt look much scarier. Lets throw another callback if we move off the screen. previously we had only one branch going down(moveX-> moveX -> moveX ...).

Now we have two call backs for one function. Often this pattern is used we send a http request, if it is success then run one callback, if its a failure run another.

it would look like this..

```js
request(
  () => {
    //onSuccess
  },
  () => {
    //on failure
  }
);
```

## The callback hell

```js
const btn = document.querySelector("button");

//This function moves an element "amount" number of pixels after a delay.
//If the element will stay on screen, we move the element and call the onSuccess callback function
//If the element will move off screen, we do not move the element and instead call the onFailure callback
const moveX = (element, amount, delay, onSuccess, onFailure) => {
  setTimeout(() => {
    const bodyBoundary = document.body.clientWidth;
    const elRight = element.getBoundingClientRect().right;
    const currLeft = element.getBoundingClientRect().left;
    if (elRight + amount > bodyBoundary) {
      onFailure();
    } else {
      element.style.transform = `translateX(${currLeft + amount}px)`;
      onSuccess();
    }
  }, delay);
};

// LOOK AT THIS UGLY MESS!
moveX(
  btn,
  300,
  1000,
  () => {
    //success callback
    moveX(
      btn,
      300,
      1000,
      () => {
        //success callback
        moveX(
          btn,
          300,
          1000,
          () => {
            //success callback
            moveX(
              btn,
              300,
              1000,
              () => {
                //success callback
                moveX(
                  btn,
                  300,
                  1000,
                  () => {
                    //success callback
                    alert("YOU HAVE A WIDE SCREEN!");
                  },
                  () => {
                    //failure callback
                    alert("CANNOT MOVE FURTHER!");
                  }
                );
              },
              () => {
                //failure callback
                alert("CANNOT MOVE FURTHER!");
              }
            );
          },
          () => {
            //failure callback
            alert("CANNOT MOVE FURTHER!");
          }
        );
      },
      () => {
        //failure callback
        alert("CANNOT MOVE FURTHER!");
      }
    );
  },
  () => {
    //failure callback
    alert("CANNOT MOVE FURTHER!");
  }
);
```

This is where promises come in. Promises allow us to rewrite a function like this without doing all of this crazy nesting. It makes the code more easier to read

If you want to know more about promises, refer [Promises Explained]({{< ref "/posts/14-promises-explained.md">}}).

Hope that was not convoluted and crazy. Until next time, Happy learning :tada: :computer:

