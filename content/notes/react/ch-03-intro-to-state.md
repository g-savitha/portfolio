---
title: "Intro to State"
date: 2020-08-24T14:57:47+05:30
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

# What is State?

## Thinking about state

In any sufficiently advanced web application, the user interface has to be stateful.

- logged-in users see a different screen than logged-out users
- clicking “edit profile” opens up a modal (pop-up) window
- sections of a website can expand or collapse, for instance clicking “read more”

The state of the client interface (frontend) is not always directly tied to state on the server.

Why would the server need to know if a modal is open?

## State changes

State is designed to _constantly change in response to events_.

A great way to think about state is to think of games, for instance chess. At any point in time, the board is in a complex state.

![chess](https://images.chesscomfiles.com/uploads/v1/images_users/tiny_mce/SamCopeland/phpuTejFE.gif)

_Every new move represents a single discrete state change._

## What Does State Track?

There are two types of things state on the client/frontend keeps track of:

- _UI logic_ - the _**changing state of the interface**_ e.g., there is a modal open right now because I’m editing my profile
- _business logic_ - the _**changing state of data**_ e.g., in my inbox, messages are either read or unread, and this in turn affects how they display.

### Vanilla / jQuery State

The way we kept track of state with jQuery was by selecting DOM elements and seeing if they were displayed/hidden, or if they had certain styles or attributes.

```js
// getting a text input value
var firstName = $("#firstNameInput").val();
// setting a text input value
$("#firstNameInput").val("Michael");
```

In other words, we were inferring the state of the application from the DOM itself.

React is going to do the opposite!

To review..

_State:_

- _Internal data specific to a component_
- _Data that changes over time!_

# React State

In _React_, _**state is an instance attribute**_ on a _component._ It’s _**always an object**_ (POJO -> Plain old JS Object), since _**you’ll want to keep track of several keys/values**_.

```js
// what is the current state of my component?
console.log(this.state);

{
  playerName: "Whiskey",
  score: 100
}
```

## Initial State

State _should be initialized as soon as the component is created_. So we _**set it in the constructor function**_:

```js
class ClickCount extends Component {
  constructor(props) {
    super(props);
    this.state = {
      numClicks: 0, // start at zero clicks
    };
  }
}
```

### React Constructor Function

If your component is _stateless_, you can **omit the constructor** function. If you are building a component with _state_, you need a standard React **constructor**

```js
constructor(props) {
  super(props);
  this.state = {
    /* values we want to track */
  };
}
```

- **constructor** takes _one argument_, _*props*_
- You _**must call super(props) at start of constructor**_, which **“registers” your class as a React Component**
- **Inside the instance methods**, you can refer to _this.state just like you did this.props_

State can be defined using the new public fields syntax

```js
class ClickCount extends Component {
  state = { numClicks: 0 };
  // ...
}
```

Notice that it is _state_, not ~~this.state~~, when done like this.

#### Example:

_demo/basicExample.js_

```js
class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      player: "Whiskey",
      score: 0,
    };
  }

  render() {
    return (
      <div>
        <h1>Battleship</h1>
        <p>Current Player: {this.state.player}</p>
        <p>Score: {this.state.score}</p>
      </div>
    );
  }
} // end
```

## Changing State

_**this.setState()**_ is the built-in React method of changing a component’s state.
`this.setState({ playerName: "Matt", score: 0 })`

- _Can call in any instance method_ except the **constructor**
- Takes an _object describing the state changes_
- _Patches state object_ — keys that you didn’t specify don’t change
- **Asynchronous**!
  - The component _state will eventually update_.
  - React controls when the state will actually change, for performance reasons.
- **Components re-render** when their _state changes_

_demo/click-me/src/Rando.js_

```js
class Rando extends Component {
  constructor(props) {
    super(props);
    this.state = { num: 0 };
    this.makeTimer();
  }

  makeTimer() {
    setInterval(() => {
      this.setState({
        num: Math.floor(Math.random() * this.props.maxNum),
      });
    }, 1000);
  }

  render() {
    return <button>Rando: {this.state.num}</button>;
  }
} // end
```

## React Events

_State_ most commonly _changes_ in direct _response to some event_. In React, _every JSX element has built-in attributes representing every kind of browser event._ They are camel-cased, like _onClick_, and _**take callback functions as event listeners**_.

```js
<button
  onClick={function (e) {
    alert("You clicked me!");
  }}
>
  Click Me!
</button>
```

> React Events are a bit of an abstraction on top of regular browser events. They’re called [synthetic events](https://reactjs.org/docs/events.html#overview), but in practice they behave the same and you don’t have to worry about the abstraction. Check out the React documentation for all types of [supported events](https://reactjs.org/docs/events.html#supported-events).

### Example : Broken Click

If we’re updating state in response to an event, we’ll have to call a method with `this.setState()`:

_demo/click-me/src/BrokenClick.js_

```js
class BrokenClick extends Component {
  constructor(props) {
    super(props);
    this.state = { clicked: false };
  }

  handleClick() {
    this.setState({ clicked: true });
  }

  render() {
    return (
      <div>
        <h1>
          The Button is
          {this.state.clicked ? "clicked" : "not clicked"}
        </h1>
        <button onClick={this.handleClick}>Broken</button>
      </div>
    );
  }
} // end
```

_*`this`*_ is back!!

But _this_ is undefined!

- Who is calling handleClick for us?
  - React is, on click
- What is it calling it on?
  - 🤷 it doesn’t remember to call it on our instance
  - The method was called “out of context”
- What do we do?
  - _**`.bind()` it!**_

### Example : Fixed click

We’ll fix the situation by _**binding our instance methods in the constructor**_.

_demo/click-me/src/FixedClick.js_

```js
class FixedClick extends Component {
  constructor(props) {
    super(props);
    this.state = { clicked: false };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    this.setState({ clicked: true });
  }

  render() {
    return (
      <div>
        <h1>
          The Button is
          {this.state.clicked ? "clicked" : "not clicked"}
        </h1>
        <button onClick={this.handleClick}>Fixed</button>
      </div>
    );
  }
} // end
```

# States vs Props.

State and Props are the most important concepts in React (after knowing what a “component” is).

| _term_ | _structure_ | _mutable_ | _purpose_                      |
| ------ | ----------- | --------- | ------------------------------ |
| state  | POJO `{}`   | yes       | stores changing component data |
| props  | POJO `{}`   | no        | stores component configuration |

## State as Props

A common pattern we will see over and over again is a _**stateful (“smart”) parent**_ component _passing down_ its _*state*_ values _*as props*_ _**to stateless (“dumb”) child**_ components.

```js
class CounterParent extends Component {
  constructor(props) {
    super(props);
    this.state = { count: 5 };
  }
  render() {
    // passing down parent state as a prop to the child
    return (
      <div>
        <CounterChild count={this.state.count} />
      </div>
    );
  }
}
```

This idea is generalized in React as _**“downward data flow”**_. It means that **components get simpler as you go down the component hierarchy**, and _**parents tend to be more stateful**_ than their children.

> _Further Reading_ : checkout [React Docs](https://reactjs.org/docs/faq-state.html) . Two other great resources: [Props vs State](https://github.com/uberVU/react-guide/blob/master/props-vs-state.md) > [ReactJS : Prop vs State](https://lucybain.com/blog/2016/react-state-vs-pros/)
