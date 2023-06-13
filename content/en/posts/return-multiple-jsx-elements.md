---
title: "Why can't we return Multiple JSX Elements"
date: 2023-06-13T18:33:33+05:30
draft: false
description: 'React snippet'
hideToc: false
enableToc: false
pinned: false
enableTocContent: false
tags:
 - react
 - jsx
 - snippets
categories:
  - react
  - jsx
  - snippets
---

Let's consider this example:

```jsx
import React from 'react';

function App() {
  return (
    <h1>Hello World!</h1>
    <p>Love from India!</p>
  );
}

export default App;
```

When we try to execute the above code, we get the following error
`Parsing error: Adjacent JSX elements must be wrapped in an enclosing tag`

Wouldn't it be easy to return multiple elements in JSX, like we do in HTML? Why are we getting this error?:

Let's unpack this:

Behind the scenes all JSX elements gets converted to Javascript. So the unpacked code looks like this:

```js
import React from 'react';

function App() {
  return (
    React.createElement('h1',null, "Hello World!");
    React.createElement('p', null, "Love from India!")
  );
}

export default App;
```

Now we get an error of: 

`Parsing error: Unexpected token ;`

We are trying to *return 2 seperate `React.createElement()` function calls* which isn't allowed in javascript. 

Let's look at another example in javascript:

```js
function someFunction() {
  let arr = [1, 2, 3];

  return (
    arr.pop()
    arr.pop()
  );
}
```

We still get the same error `Parsing error: Unexpected token ;`. `return` statements expect only one `expression slot` in javascript

> `return arr.pop()` :white_check_mark:
> `return arr.pop() arr.pop() arr.pop() ....` :x:

How can we fix it? Using **[FRAGMENTS](https://react.dev/reference/react/Fragment)**

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.
