---
title: "React Events"
date: 2020-08-25T14:55:24+05:30
draft: false
tags: [react, javascript, es6]
categories: [react]
sources: ["https://www.udemy.com/course/modern-react-bootcamp/"]
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

## React Events Review

### React Events

You can attach event handlers to HTML elements in React via special reserved attributes. (You can do this in vanilla JS too, though the syntax is a bit different.)

### Event Attributes

Any event you can listen for in JS, you can listen for in React.

_Examples:_

- Mouse events: onClick, onMouseOver, etc
- Form events: onSubmit, etc
- Keyboard events: onKeyDown, onKeyUp, onKeyPress
- [Full list](https://reactjs.org/docs/events.html#supported-events)

#### Example:

_WiseSquare.js_:

```js
import React, { Component } from "react";
import "./WiseSquare.css";

class WiseSquare extends Component {
  dispenseWisdom() {
    let messages = [
      /* wise messages go here */
    ];
    let rIndex = Math.floor(Math.random() * messages.length);
    console.log(messages[rIndex]);
  }

  render() {
    return (
      <div className="WiseSquare" onMouseEnter={this.dispenseWisdom}>
        😃
      </div>
    );
  }
}

export default WiseSquare;
```

### Method Binding

#### The keyword `this`:

When your event handlers reference the keyword _`this`_, watch out! You will lose the _`this`_ context **when you pass a function as a handler**. Let’s see what happens when we try to _move our quotes into **defaultProps**._

#### Example Revisited

_WiseSquareWithProps.js_

```js
class WiseSquareWithProps extends Component {
  static defaultProps = {
    messages: [
      /* wise messages go here */
    ],
  };

  dispenseWisdom() {
    console.log("THIS IS:", this); // undefined 😭
    let { messages } = this.props;
    let rIndex = Math.floor(Math.random() * messages.length);
    console.log(messages[rIndex]);
  }

  render() {
    return (
      <div className="WiseSquare" onMouseEnter={this.dispenseWisdom}>
        😃
      </div>
    );
  }
}
```

#### Fixing our binding

There are three ways to fix this:

- Use _**bind inline**_
- Use an _**arrow function**_
- Method _**bind in the constructor**_

##### Inline

```js
<div className="WiseSquare" onMouseEnter={this.dispenseWisdom.bind(this)}>
  {/* */}
</div>
```

_Pros:_

- Very Explicit

_Cons:_

- What if you need to _pass `this.dispenseWisdom` to multiple components?_
- _new function_ created on _every render_

##### Arrow Functions

```js
<div className="WiseSquare" onMouseEnter={() => this.dispenseWisdom()}>
  {/* */}
</div>
```

_Pros:_

- No mention of ~~bind!~~

_Cons:_

- Intent less clear.
- Again, What if you need to _pass `this.dispenseWisdom` to multiple components?_
- _new function_ created on _every render_

##### In the constructor

```js
class WiseSquareWithProps extends Component {
  constructor(props) {
    super(props);
    /* do other stuff */
    this.dispenseWisdom = this.dispenseWisdom.bind(this);
  }
}
```

_Pros:_

- Only need to _**bind once!**_
- More performant

_Cons:_

- ~~Hot reloading~~ won’t apply.

### Method Binding with Arguments

In our previous examples, `this.dispenseWisdom` didn’t take any arguments. But what if we need to pass arguments to an event handler?

#### Example:

_ButtonList.js_

```js
class ButtonList extends Component {
  static defaultProps = {
    colors: ["green", "red", "blue", "peachpuff"],
  };

  handleClick(color) {
    console.log(`You clicked on the ${color} button.`);
  }

  render() {
    return (
      <div className="ButtonList">
        {this.props.colors.map((c) => {
          const colorObj = { backgroundColor: c };
          return (
            /* Focus on this line*/
            <button style={colorObj} onClick={this.handleClick.bind(this, c)}>
              Click on me!
            </button>
          );
        })}
      </div>
    );
  }
}
```

Inside of a _loop_, you can _bind and pass in additional arguments_. Also possible to use an _arrow function_, **both these approaches suffer from the same performance downsides** we’ve already seen. We can do better, but first we need to talk about…

### Passing functions to child components

- A very _common pattern in React_
- _The idea_: **children are often not stateful**, but _need to tell parents to change state_
- How we _**send data “back up” to a parent**_ component

#### How data flows

- A **parent** component _defines_ a **function**
- The _*function*_ is _passed as_ a _*prop*_ to a _child_ component
- The _*child*_ component _invokes_ the _*prop*_
- The **parent function** is called, usually _*setting new state*_
- The **parent** component is _*re-rendered*_ along **with its children**

#### What it looks like?

_NumberList.js_ :

```js
class NumberList extends Component {
  constructor(props) {
    super(props);
    this.state = { nums: [1, 2, 3, 4, 5] };
  }

  remove(num) {
    this.setState((st) => ({
      nums: st.nums.filter((n) => n !== num),
    }));
  }

  render() {
    let nums = this.state.nums.map((n) => (
      <NumberItem value={n} remove={() => this.remove(n)} />
    ));
    return <ul>{nums}</ul>;
  }
}
```

_NumberItem.js_ :

```js
class NumberItem extends Component {
  render() {
    return (
      <li>
        {this.props.value}
        <button onClick={this.props.remove}>X</button>
      </li>
    );
  }
}
```

- We could also method _**bind inside of the map**_
- In fact, we can do even better!

#### Using a single bound function

_BetterNumList.js_

```js
class BetterNumList extends Component {
  constructor(props) {
    super(props);
    this.state = { nums: [1, 2, 3, 4, 5] };
    this.remove = this.remove.bind(this);
  }

  remove(num) {
    this.setState((st) => ({
      nums: st.nums.filter((n) => n !== num),
    }));
  }

  render() {
    let nums = this.state.nums.map((n) => (
      <BetterNumItem value={n} remove={this.remove} />
    ));
    return <ul>{nums}</ul>;
  }
}
```

_BetterNumItem.js_

```js
class NumberItem extends Component {
  constructor(props) {
    super(props);
    this.handleRemove = this.handleRemove.bind(this);
  }

  handleRemove() {
    this.props.remove(this.props.value);
  }

  render() {
    return (
      <li>
        {this.props.value}
        <button onClick={this.handleRemove}>X</button>
      </li>
    );
  }
}
```

#### Where to bind?

- The higher the better - _**don’t bind in the child component**_ _if not needed_.
- If you need a parameter, _pass it down to the child as a **prop** ._, _**then bind in parent and child**_
- _**Avoid inline arrow functions / binding**_ if possible
- _**No need to bind in the constructor**_ and make an inline function
- If you get stuck, don’t worry about performance, just try to get the communication working
  - You can always refactor later!

#### Naming Conventions

- You can call these handlers whatever you want - React doesn’t care
- For consistency, _try to follow the `action / handleAction` pattern_:
  - In the parent, give the function a name corresponding to the behavior (`remove`, `add`, `open`, `toggle`, etc.)
  - In the child, use the name of the action along with “handle” to name the event handler (`handleRemove`, `handleAdd`, `handleOpen`, `handleToggle`, etc.)

### Lists and Keys

_BetterNumList.js_ :

```js
class BetterNumList extends Component {
  render() {
    let nums = this.state.nums.map((n) => (
      <BetterNumItem value={n} remove={this.remove} />
    ));
    return <ul>{nums}</ul>;
  }
}
```

When mapping over data and returning components, you get a warning about keys for list items._*key*_ is a _special string attr_ to _include when creating lists of elements_

#### Adding keys

Let’s assign a key to our list items inside _nums.map()_:

```js
class NumberList extends Component {
  render() {
    const nums = this.state.nums.map((n) => (
      <NumberItem value={n} key={n} remove={this.remove} />
    ));
    return <ul>{nums}</ul>;
  }
}
```

#### Keys

- **Keys** help React _**identify which items are changed/added/removed**_.
- Keys _**should be given to repeated elems**_ to provide a stable identity.

#### Picking a key

- _Best way_: _*use string*_ that **uniquely** identifies item **among siblings**.
- Most often you would _*use IDs*_ from your _data_ as keys:

```js
let todoItems = this.state.todos.map((todo) => (
  <li key={todo.id}>{todo.text}</li>
));
```

#### Last resort

When you don’t have stable IDs for rendered items, you may **use the iteration index** as a key as a last resort:

```js
// Only do this if items have no stable IDs

const todoItems = this.state.todos.map((todo, index) => (
  <li key={index}>{todo.text}</li>
));
```

- Don’t use ~~indexes~~ for keys _if item order may change or items can be deleted_.
- This can cause _performance problems_ or bugs with component state.
