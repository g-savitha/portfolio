---
title: "Intro to React"
date: 2020-08-24T12:28:38+05:30
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

Popular, powerful front-end framework.

Developed by and sponsored by Facebook.

- Make it easy to make reusable `view components`
  - These _encapsulate logic and HTML_ into a _class_
- Often make it easier to build modular applications

_Components :_

- The building blocks of React
- Pieces of UI & view logic
- _Classes_ that know how to **render themselves into HTML**

A bit like this...

```js
class Dog {
  constructor(name, color) {
    this.name = name;
    this.color = color;
  }
  render() {
    return `<p>${this.name}</p>`;
  }
}
```

A component is a React class with a _**render()**_ method:

```js
class Hello extends React.Component {
  render() {
    return <p>Hi Everyone!</p>;
  }
}
```

We add our component to HTML with _**ReactDOM.render**_:

```js
ReactDOM.render(<Hello />, document.getElementById("root"));
```

---

## Intro to JSX

```js
class Hello extends React.Component {
  render() {
    return <p>Hi Everyone!</p>;
  }
}

ReactDOM.render(<Hello />, document.getElementById("root"));
```

JSX is like **HTML embedded in JavaScript**:

```js
if (score > 100) {
  return <b>You win!</b>;
}
```

You can also _"re-embed”_ JavaScript in JSX:

```js
if (score > 100) {
  return <b>You win, {playerName}</b>;
}
```

(looks for JavaScript variable _playerName_)

### Using JSX

- JSX isn’t legal JavaScript
  - It has to be “transpiled” to JavaScript
- You can do this with [Babel](https://babeljs.io/)

### Transpiling JSX in browser

- Load _Babel_ standalone library:

```js
<script src="https://unpkg.com/babel-standalone"></script>
```

- Mark JSX files with `type="text/jsx"`:

```js
<script src="index.js" type="text/jsx"></script>
```

#### Serving demo

For security reasons, Babel won’t work with `file://`scripts

Run files under a simple static server:

```sh
python3 -m http.server
```

or use _Live server_ extension in VSCode.

---

## Properties

aka. **Props**

_**A useful component is a reusable one**_. This often means making it configurable or customizable.

```js
class Hello extends React.Component {
  render() {
    return <p>Hi Everyone!</p>;
  }
}
```

It would be better if we could configure our greeting. Our greeting will be Hi \_ \_ \_ _ from _ \_ \_ \_

Let’s make two “properties”:

`to` -> Who we are greeting

`from` -> Who our greeting is from

`hello2/index.js`

```js
ReactDOM.render(<Hello to="me" from="you" />, document.getElementById("root"));
```

Set properties on element; get using _**this.props.propName**_.

```js
class Hello extends React.Component {
  render() {
    return (
      <div>
        <p>Secret Message: </p>
        <p>
          Hi {this.props.to} from {this.props.from}
        </p>
      </div>
    );
  }
}
```

#### Reusing Component

You can use a component many times:

Adding to different places:

_index.js_

```js
ReactDOM.render(<Hello to="Kay" from="Kim" />, document.getElementById("root"));

ReactDOM.render(<Hello to="me" from="you" />, document.getElementById("also"));
```

Adding several at once:

_index.js_

```js
ReactDOM.render(
  <div>
    <Hello to="Kay" from="Kim" />
    <Hello to="me" from="you" />
  </div>,
  document.getElementById("root")
);
```

> Note _div_ wrapper — JSX often **renders a single top-level element**.

### Properties Requirements

- Properties are for _configuring_ your component
- Properties are _**immutable**_
- Properties can be _strings_:

```js
<User name="Jane" title="CEO" />
```

For other types, _embed JS expression_ using the _curly braces_:

```js
<User name="Jane" salary={100000} hobbies={["bridge", "reading", "tea"]} />
```

### Using Properties

- Get to properties inside class with _**this.props.propertyName**_
- Properties are immutable — cannot change!

---

## Conditionals in JSX

The **render()** method can return either:

- a _**single valid**_ _DOM object_ `(return <div>...</div>)`
- _**an array**_ of _DOM objects_
- _**null**_ (~~undefined~~ is not ok!)

You can _put whatever logic_ you want in your **render()** method for this:

```js
class Lottery extends React.Component {
  render() {
    if (this.props.winner) return <b>You win!</b>;
    else return <b>You lose!</b>;
  }
}
```

### Ternary

It’s very common in **render()** to use ternary operators:

```js
class Lottery extends React.Component {
  render() {
    return <b>You {this.props.winner ? "win" : "lose"}!</b>;
  }
}
```

#### Example: Slots!

_demo/slots/Machine.js_

```js
class Machine extends React.Component {
  render() {
    const { s1, s2, s3 } = this.props;
    const winner = s1 === s2 && s2 === s3;

    return (
      <div className="Machine">
        <b>{s1}</b> <b>{s2}</b> <b>{s3}</b>
        <p>You {winner ? "win!" : "lose!"}</p>
      </div>
    );
  }
}
```

_demo/slots/index.js_

```js
ReactDOM.render(
  <Machine s1="🍇" s2="🍇" s3="🍇" />,
  document.getElementById("root")
);
```

---

## Looping in JSX

It’s common to use _**array.map(fn)**_ to output loops in JSX:

```js
class Messages extends React.Component {
  render() {
    const msgs = [
      { id: 1, text: "Greetings!" },
      { id: 2, text: "Goodbye!" },
    ];

    return (
      <ul>
        {msgs.map((m) => (
          <li>{m.text}</li>
        ))}
      </ul>
    );
  }
}
```

#### Ecxample: Friends!

_demo/friends/Friend.js_

```js
class Friend extends React.Component {
  render() {
    const { name, hobbies } = this.props;
    return (
      <div>
        <h1>{name}</h1>
        <ul>
          {hobbies.map((h) => (
            <li>{h}</li>
          ))}
        </ul>
      </div>
    );
  }
}
```

_demo/friends/index.js_

```js
ReactDOM.render(
  <div>
    <Friend name="Jessica" hobbies={["Tea", "Frisbee"]} />
    <Friend name="Jake" hobbies={["Chess", "Cats"]} />
  </div>,
  document.getElementById("root")
);
```

---

## Default Props

Components can specify _default values_ for _missing props_

_demo/hello-3/Hello.js_

```JS
class Hello extends React.Component {
  static defaultProps = {
    from: "Joel",
  };

  render() {
    return <p>Hi {this.props.to} from {this.props.from}</p>;
  }
}
```

Set properties _on element_; get using **this.props.propName**.

_demo/hello-3/index.js_

```js
ReactDOM.render(
  <div>
    <Hello to="Students" from="Elie" />
    <Hello to="World" />
  </div>,
  document.getElementById("root")
);
```

---

## Styling React

You can add CSS classes in JSX.

However: since _class_ is a reserved keyword in JS, _spell it **className**_ in JSX:

```js
class Message extends React.Component {
  render() {
    return <div className="urgent">Emergency!</div>;
  }
}
```

You can inline CSS styles, but now _style_ _takes a JS object_:

```js
class Box extends React.Component {
  render() {
    const colors = {
      color: this.props.favoriteColor,
      backgroundColor: this.props.otherColor,
    };

    return <b style={colors}>{this.props.message}</b>;
  }
}
```
