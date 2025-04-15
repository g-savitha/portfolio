---
title: "Can we skip the react import?"
url: "/posts/skip-react-imports"
date: 2023-06-10T18:32:03+05:30
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

Let's have a look at this snippet:

```jsx
// React 18
import React from 'react';
import { createRoot } from 'react-dom/client';

const element = (
  <p id="greet">
    नमस्ते :pray:!
  </p>
);

const container = document.querySelector('#root');
const root = createRoot(container);
root.render(element);
```

On the very first line of our code, we are importing the `React`, but we are not using it anywhere, can we skip it?

Behind the scenes, the JSX code we write gets converted to :

```jsx
import React from 'react';
import { createRoot } from 'react-dom/client';

const element = React.createElement(
  'p',
  { id: 'greet' },
  'नमस्ते :pray:!'
);

const container = document.querySelector('#root');
const root = createRoot(container);
root.render(element);
```

Before JSX, this is how we used to create react elements. React elements are nothing but a plain old javascript objects.

Now, back to the code. Here we are using the `React` as a dependency, it's just hidden by the JSX.
Earlier versions of `React`( < 17 ) used to throw an error, when you don't import it.

> Error: React not defined

This error was confusing lots of new developers, starting from `React` 17, Babel started importing `React`. The same process which turns `<p>` to `React.createElement('p')` will also check if `React` is imported or not. It will import it, if its not imported already

So from React 17, you don't need to import `React`, but in certain cases if we want to use hooks, importing `React` will be handy.

