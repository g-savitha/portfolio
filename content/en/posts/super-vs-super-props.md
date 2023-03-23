---
title: "super() vs super(props)"
date: 2021-01-29T17:52:28+05:30
draft: false
description: "If you want to use `this.props` inside constructor of derived class, use super(props)...."
tags: [react]
categories: [react]
hideToc: false
enableToc: true
enableTocContent: true
image: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1200px-React-icon.svg.png"
---

<!--  Start Typing... -->

## TL;DR :rocket:

> If you want to use `this.props` inside constructor of derived class, use super(props).

---

While checking react code, you might have come across a line `super(props)`, sometimes `super()`. Ever wondered what's the difference between two?
Why do we need to pass `props` ? Do we always need to pass `props` ?

Consider the example below.

```jsx {hl_lines=[2]}
import React, { Component } from "react";
class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      player: "Robin",
      score: 25,
    };
  }
  render() {
    return (
      <div>
        <h1>Cricket</h1>
        <p>Current Player :{this.state.player}</p>
        <p>Current Score : {this.state.score}</p>
      </div>
    );
  }
}
export default Game;
```

Every time we are writing a component, we are extending it from React component (The base component class) and that's really important if we don't do that we would be missing a ton of react functionality.

Let's step out of react world for just a moment and let's mimic our own component class

```js
class Component {
  constructor() {
    console.log("INSIDE COMPONENT CONSTRUCTOR");
  }
}
class Game extends Component {
  constructor() {
    console.log("INSIDE GAME CONSTRUCTOR");
  }
}
```

Lets make a new game

```js
let cricket = new Game();
```

So you might think, when we initialized a new game, a constructor is called and that should be printed out, unfortunately we get an error
says : _Must call super constructor before accessing 'this'_ . Loosely translated, call a super constructor in derived class before basically doing anything.

Problem is we are extending the base class but we never actually called its **constructor** and that's super important to do in the derived class's constructor (Inside Game's constructor here), we need to make sure that we're calling the class (it's constructor) we are extending, especially in React because that's how we call all the magic setup stuff that React does and takes care of out of the box for us. so we call `super()`

```js {hl_lines=[3]}
class Game extends Component {
  constructor() {
    super();
    console.log("INSIDE GAME CONSTRUCTOR");
  }
}
```

Now try to instantiate again.

```js
let cricket = new Game();
//output:
//INSIDE COMPONENT CONSTRUCTOR
//INSIDE GAME CONSTRUCTOR
```

## What does super(props) do then?

Lets look at this example:

```jsx
import React, { Component } from "react";

export default class Food extends Component {
  render() {
    return (
      <div>
        <h1>HI I AM FOOD COMPONENT</h1>
      </div>
    );
  }
}
```

```jsx
import React, { Component } from "react";
import Food from "./Food";
class App extends Component {
  render() {
    return (
      <div>
        <Food item="PineApple" nutrition="10" />
      </div>
    );
  }
}

export default App;
```

We are passing two props to Food component. You can think of it like we are creating two objects for Food class `new Food({item : "pineapple", nutrition: "10"})`

```jsx {hl_lines=[6]}
import React, { Component } from "react";

export default class Food extends Component {
  constructor() {
    super();
    console.log(this.props); // undefined.
  }
  render() {
    return (
      <div>
        <h1>HI I AM FOOD COMPONENT</h1>
      </div>
    );
  }
}
```

We get output as _Undefined_ even though we have props. OK, what's happening here is if we want to **access `this.props` in the constructor, we have to pass props in super (`super(props)`)**. This is kind of bizzare, lets consider this example.

```jsx {hl_lines=[6,11]}
import React, { Component } from "react";

export default class Food extends Component {
  constructor() {
    super();
    console.log(this.props); // undefined.
    console.log(props); // {item:"pineapple", nutrition:10}
  }
  render() {
    return (
      <div>
        <h1>{this.props.item}</h1> /*Prints out pineapple*/
      </div>
    );
  }
}
```

However if you do

```jsx {hl_lines=[5]}
import React, { Component } from "react";

export default class Food extends Component {
  constructor() {
    super(props);
    console.log(this.props); // {item:"pineapple", nutrition:10}
  }
  render() {
    return (
      <div>
        <h1>{this.props.item}</h1> /*Prints out pineapple*/
      </div>
    );
  }
}
```

To conclude, If you want to use `this.props` inside constructor, you need to pass props in `super()`, otherwise it’s okay to not pass props to super() as we see that irrespective of passing it to super(), `this.props` is available inside `render()` function.

Hopefully that was not convoluted and crazy, until next time. Happy Coding! :tada: :computer:

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.
