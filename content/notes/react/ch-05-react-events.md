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

### Commonly used React Events

You can attach event handlers to HTML elements in React via special reserved attributes. (You can do this in vanilla JS too, though the syntax is a bit different.)

### Event Attributes

Any event you can listen for in JS, you can listen for in React.

_Examples:_

- Mouse events: `onClick`, `onMouseOver`, etc
- Form events: `onSubmit`, etc
- Keyboard events: `onKeyDown`, `onKeyUp`, `onKeyPress`
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

---

### The Joys of Method Binding :weary:

#### The keyword `this`:

> When your event handlers reference the keyword _this_, watch out! You will lose the _this_ context **when you pass a function as a handler**. Let’s see what happens when we try to move our quotes into _defaultProps_.

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

_Performance Issues:_

- What if you need to _pass `this.dispenseWisdom` to multiple components?_ A _new function_ is created on _every render_

##### Arrow Functions

```js
<div className="WiseSquare" onMouseEnter={() => this.dispenseWisdom()}>
  {/* */}
</div>
```

_Pros:_

- No mention of ~~bind()!~~

_Cons:_

- Intention is less clear.

_Performance Issues:_

- Again, What if you need to _pass `this.dispenseWisdom` to multiple components?_ A _new function_ is created on _every render_

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

- Looks Ugly
- ~~HOT RELOADING~~ won’t apply.

> Note : This method is being used since the introduction of ES6, previously we used to bind _this_ using above two methods. Even though syntax looks ugly, its better to use this approach for better performance.

If calling bind annoys you, there are two ways to get around this. One is _Arrow functions_, which we already saw . Other method is [experimental public class fields](https://babeljs.io/docs/en/babel-plugin-transform-class-properties/) syntax, you can use _*class fields*_ _to correctly set bind_ callbacks.

[Source:](https://reactjs.org/docs/handling-events.html)

```js
class LoggingButton extends React.Component {
  // This syntax ensures `this` is bound within handleClick.
  // Warning: this is *experimental* syntax.

  // babel will bind this in a constructor

/*BEHIND THE SCENES ...*/

  // constructor(){
  //   this.handleClick = () =>{
  //     /**/
  //   }

  }
  handleClick = () => {
    console.log("this is:", this);
  };

  render() {
    return <button onClick={this.handleClick}>Click me</button>;
  }
}
```

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
- How do we _**send data “back up” to a parent**_ component ?

#### How data flows

- A **parent** component _defines_ a **function**
- The _*function*_ is _passed as_ a _*prop*_ to a _child_ component
- Now , the _*child*_ component has the function and it can _invoke_ it as a the _*prop*_
- That calls the **parent function** , where usually _*a new state is set or update the exisisting state*_
- As the state causes the change in the parent state, the **parent** component is _*re-rendered*_ along **with its children**

#### What it looks like?

_Not an ideal way:_

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

- We could also _**method bind inside of the map**_
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

- _**The higher the better**_ - **don’t bind in the child component** if not needed.
- If you need a parameter, _**pass it down to the child as a prop**_, _**then bind in parent and child**_
- _**Avoid inline arrow functions and binding inside of render**_ **if possible** -> for performance reasons.
- _No need to bind in the constructor_ _*and*_ _make an inline function_ -> Do either one of them. I always prefer _**in the constructor**_
- If you get stuck, don’t worry about performance, just try to get the communication working
  - You can always refactor later!

#### Naming Conventions

- You can call these handlers whatever you want - React doesn’t care
- For consistency, _try to follow the `action/handleAction`_ ( `action` in parent and `handleAction` in child) pattern:

  - In the parent, give the function a name corresponding to the behavior (`remove`, `add`, `open`, `toggle`, etc.) [send as props]
  - In the child, use the name of the action along with “handle” to name the event handler (`handleRemove`, `handleAdd`, `handleOpen`, `handleToggle`, etc.)

---

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

> When choosing a **key**it is important to note that, it need to be **unique**.

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

> **Keys** help React _**identify which items are changed/added/removed**_. Keys _**should be given to repeated elems**_ to provide a stable identity.

#### Picking a key

> _Best way_: _*use string*_ that **uniquely** identifies item **among siblings**. Most often you would _*use IDs*_ from your _data_ [data from db or api etc.] as keys:

```js
let todoItems = this.state.todos.map((todo) => (
  <li key={todo.id}>{todo.text}</li>
));
```

#### Last resort

> When you don’t have stable IDs for rendered items, you may _*use the iteration index*_ as a key as a last resort

```js
// Only do this if items have no stable IDs

const todoItems = this.state.todos.map((todo, index) => (
  <li key={index}>{todo.text}</li>
));
```

_A good rule of thumb:_

> Don’t use ~~indexes~~ for keys _if item order may change or items can be deleted_. This can cause _performance problems_ or bugs with component state.

> _A goodread:_ [Index as a key is an anti-pattern](https://medium.com/@robinpokorny/index-as-a-key-is-an-anti-pattern-e0349aece318)

---

> [shortid](https://www.npmjs.com/package/shortid) &[uuid](https://www.npmjs.com/package/uuid) npm packages helps us to create unique ids
