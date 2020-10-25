---
title: "CRA and Modules"
date: 2020-08-24T13:23:51+05:30
draft: true
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

## Create react App

React is a front-end library — you don’t need server-side stuff. You can get react.js and react-dom.js from a CDN. You can transpile JSX in the browser at runtime. But there’s a better way!

**Create-React-App** is a _utility script_ that:

- Creates a skeleton react project
- Sets it up so that JS files are run through Babel automatically.
- Lets us use super-modern Javascript features/idioms
- Makes testing & deployment much easier.

#### Installing

Only once: install create-react-app:

```sh
npm install -g create-react-app
```

Then to create each React project you want:

```sh
create-react-app my-app-name
```

#### Starting Your App

```sh
npm start
```

---

### Webpack

CRA is built on top of _“Webpack”_, a JS utility that:

- Enables _module importing/exporting_
  - _Packages up all CSS/images/JS_ into a _*single file*_ for browser
  - Dramatically _reduces no. of HTTP requests_ for _performance_
- **Hot reloading**: when you change a source file, automatically reloads
  - Is very clever and tries to _only reload relevant files_
- Enables _easy testing & deployment_

> Note : _The Webpack Rabbit Hole_. Webpack is a powerful tool, and configuring it can be quite complicated. Create React App abstracts away that configuration from you. [Learn about webpack here](https://webpack.js.org/)

---

## Modules

> CRA uses ES2015 _“modules”._ This is a newer, standardized version of Node’s require(). You use this _to export/import classes/data/functions_ between JS files

#### Sample Component

_demo/my-app-name/src/App.js_

```js
import React, { Component } from "react"; //
import logo from "./logo.svg"; //
import "./App.css"; //

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <p>This React app is INCREDIBLE.</p>
        </header>
      </div>
    );
  }
}

export default App; //
```

##### Importing “Default” Export

_demo/import-export/mystuff.js_

```js
function myFunc() {
  console.log("Hi");
}

export default myFunc;
```

_demo/import-export/index.js_

```js
// Must start with dot --- "mystuff" would be a npm module!

import myFunc from "./mystuff";
```

##### Importing Non-Default Named Things

_demo/import-export/mystuff.js_

```js
function myFunc() {
  console.log("Hi");
}

export default myFunc;
```

_demo/import-export/index.js_

```js
import { otherFunc, luckyNumber } from "./mythings";
```

##### Importing Both

_demo/import-export/both.js_

```js
function mainFunc() {
  console.log("Ok");
}

const msg = "Awesome!";

export default mainFunc;
export { msg };
```

_demo/import-export/index.js_

```js
import mainFunc, { msg } from "./both";
```

##### To Default or Not?

> Conventionally, default exports are used when there’s a _“most likely”_ thing to exporting. For example, in a React component file, it’s common to have the component be the default export. You _never need_ to make a default export, but it can be helpful to indicate the most important thing in a file.

##### Resources

[Export](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export)
[Import](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
