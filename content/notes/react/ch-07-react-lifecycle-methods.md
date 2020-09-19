---
title: "React Lifecycle Methods"
date: 2020-09-01T18:20:33+05:30
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

## React Component Lifecycle

-Each component has several “lifecycle methods” that one can override to run code at particular times in the process.

- These components comes with methods which allows developers to update application state and reflect the changes to the UI before/after key react “events”.
- There are three main phases in a component's lifecycle:
  - mounting
  - updating
  - unmounting

### Mounting

These methods are called in the following order

- _constructor()_
- [static getDerivedStateFromProps()](https://reactjs.org/docs/react-component.html#static-getderivedstatefromprops)
- _render()_
- _componentDidMount()_

#### constructor()

Often _used for initializing state or binding event handlers_ to class instance.

```js
class MyComponent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0,
      value: "Hey There!",
    };

    this.handleClick = this.handleClick.bind(this);
  }
}
```

#### render()

_**After the constructor, React calls render()**_. It tells React what should be displayed. React updates the DOM to match the output of render().

#### componentDidMount()

- This method _runs after the component is mounted_.
- **Mounting** is the first time the component is rendered to DOM.
- This is a _good place to load any data via AJAX or set up subscriptions/timers_.
- Calling _setState()_ here _*will trigger rerender*_, so be cautious.

- **componentDidMount()** method _runs after the component has been rendered_.

```js
class Clock extends Component {
  componentDidMount() {
    this.timerID = setInterval(() => {
      this.tick();
    }, 1000);
  }

  // ...
}
```

**componentDidMount** is also quite _useful for making AJAX requests_ when the _component is mounted_

```js
class GitHubUserInfo extends Component {
  componentDidMount() {
    axios.get("https://api.github.com/users/facebook").then((response) => {
      let user = response.data;
      this.setState({ user });
    });
  }

  // ...
}
```

- We can also make _componentDidMount_ an _async_ function:

```js
class GitHubUserInfo extends Component {
  async componentDidMount() {
    let response = await axios.get("https://api.github.com/users/elie");
    let user = response.data;
    this.setState({ user });
  }

  // ...
}
```

### Updating

This a suitable place to implement any side effect operations.

- syncing up with _localStorage_
- auto-saving
- updating DOM for uncontrolled components

This is the order of methods called when a component is being re-rendered:

- [static getDerivedStateFromProps()](https://reactjs.org/docs/react-component.html#static-getderivedstatefromprops)
- [shouldComponentUpdate()](https://reactjs.org/docs/react-component.html#shouldcomponentupdate)
- _render()_
- [getSnapshotBeforeUpdate()](https://reactjs.org/docs/react-component.html#getsnapshotbeforeupdate)
- _componentDidUpdate()_

#### componentDidUpdate()

- This method is _called after every render occurs_.
- You can do a comparison between the previous and current props and state:

```js
componentDidUpdate(prevProps, prevState) {
  // you can call setState here as well if you need!
}
```

- Note : `componentDidUpdate()` will not be invoked if `shouldComponentUpdate()` returns _false_.

### Unmounting

#### componentWillUnmount()

- When _component is unmounted or destroyed_, this will be called.
- This is a place to do some clean up like:
  - Invalidating timers
  - _Canceling network request_
  - _Removing event handlers directly put on DOM_
  - Cleaning up subscriptions
- _Calling_ _*setState*_ here is _useless_ — there will be _no re-rendering after this_!

```js {hl_lines=[8,9,10]}
class Clock extends Component {
  componentDidMount() {
    this.timerID = setInterval(() => {
      this.tick();
    }, 1000);
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  // ...
}
```

### Error Handling

These methods are called when there is an error during rendering, in a lifecycle method, or in the constructor of any child component.

- [static getDerivedStateFromError()](https://reactjs.org/docs/react-component.html#static-getderivedstatefromerror)
- [componentDidCatch()](https://reactjs.org/docs/react-component.html#componentdidcatch)

---

[Visualize component lifecycle](https://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/)
