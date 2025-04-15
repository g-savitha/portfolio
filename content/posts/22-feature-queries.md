---
title: "Feature Queries in Web Development"
url: "/posts/feature-queries-in-web-dev"
date: 2023-03-27T13:26:46+05:30
draft: false
description: 'Feature queries help us detect browser support for specific features and provide fallbacks for better cross-browser compatibility.'
hideToc: false
enableToc: true
pinned: false
enableTocContent: true
tags:
 - css
 - javascript
 - legacy 
categories:
  - css
  - javascript
---


## What are feature queries?

Feature queries are a **set of conditional statements that check whether a particular feature is supported by a browser or not**. These queries are used to **control the behavior of a website by providing fallbacks** or alternative styles for browsers that do not support certain features.

For example, let's say you want to use the CSS Grid layout in your website. However, not all browsers support CSS Grid. To ensure that your website looks good on all browsers, you can use a feature query to check whether the browser supports CSS Grid. If it does, you can use the CSS Grid layout, and if it doesn't, you can provide a fallback layout that works for all browsers.

```css
/* Use CSS Grid if supported */
@supports (display: grid) {
  .container {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
  }
}
/* Fallback for browsers that do not support CSS Grid */
.container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
```

In the example above, the `@supports` rule checks whether the `display: grid` property is supported by the browser. If it is, the `grid-template-columns` property is used to create a 3-column grid layout. If not, the `.container` element is styled using a flexbox layout that wraps items and justifies content between them.

### What if '@supports' isnt supported by the browser?

If the `@supports` rule is not supported by the user's browser, the **browser will simply ignore it** and move on to the next rule in the stylesheet. This means that any styles or fallbacks that were defined within the `@supports` rule will not be applied to the page.

In this case, it's important to provide alternative styles that work on older or less-capable browsers. This can be done by defining default styles outside of the `@supports` rule, or by using other techniques such as **progressive enhancement or graceful degradation**.

**Progressive enhancement** involves starting with a basic design and then adding more advanced features for browsers that support them. This ensures that all users have access to the core functionality of the website, while still providing a richer experience for users with modern browsers.

**Graceful degradation**, on the other hand, involves starting with a fully-featured design and then scaling back for browsers that don't support certain features. This can be useful when working with older browsers that may not support more modern web technologies.

In summary, if the `@supports` rule is not supported by the user's browser, it's important to provide alternative styles or use other techniques to ensure that the website remains accessible and functional for all users.

## Feature queries in JS?

Yes, feature queries can also be used in JavaScript to detect browser support for specific APIs or features. For example, developers can use feature queries in JavaScript to detect support for features like fetch, or WebAssembly. However, feature queries are **more commonly associated with CSS, as they are primarily used to detect support for CSS properties and values**.

- Checking for `fetch` support in javascript

```js
if ('fetch' in window) {
  // fetch is supported
  // do something here
} else {
  // fetch is not supported
  // provide a fallback here
}
```

- Checking for `WebAssembly` support:
```js
if (typeof WebAssembly === 'object' && typeof WebAssembly.instantiate === 'function') {
  // WebAssembly is supported
  // do something here
} else {
  // WebAssembly is not supported
  // provide a fallback here
}
```

These are just two examples, but feature queries in JavaScript can be used to detect support for a wide range of features, including APIs, browser objects, and browser events.

Until next time, Happy learning! :tada: :computer:

