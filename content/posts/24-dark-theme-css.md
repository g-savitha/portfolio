---
title: "How to enable dark theme in css"
url: "/posts/dark-theme-css"
date: 2023-04-01T22:07:21+05:30
draft: false
description: 'CSS Snippet'
hideToc: false
enableToc: false
pinned: false
enableTocContent: false
tags:
 - css
 - snippets
categories:
  - frontend
---

## Dark mode in your website

You can create a toggle for dark and light theme in CSS by using a combination of CSS variables, media queries, and JavaScript

```css
/* defining color variables (globally) in css */
:root{
  --bg-color : white;
  --text-color : black;
  /*These names are generalised to avoid confusion*/
  --theme-bg-color : black; 
  --theme-text-color: white 
}
/* light mode styles */
body{
  background-color : var(--bg-color);
  color : var(--text-color);
}
/* This will apply the dark mode styles when the user's device is set to use a dark color scheme. */
@media(prefers-color-scheme: dark){
  body {
    background-color : var(--theme-bg-color);
    color : var(--theme-text-color);
  }
}
```

Create a button in your html to toggle the theme.

```html
  <button class="toggle_theme">Toggle theme</button>
```

Add this js snippet, to toggle css variables when the button is clicked

```js
const toggleBtn = document.querySelector(".toggle_theme");
toggleBtn.addEventListener('click', ()=>{
  document.body.classList.toggle('dark-theme');
})
```

Define css for your `.dark-theme` class:

```css
.dark-theme{
  --bg-color : black;
  --text-color : white;
  --theme-bg-color: white;
  --theme-text-color: black;
}
```

This will toggle the values of the CSS variables when the button is clicked, which will change the background and text colors of the page.

In conclusion, `prefers-color-scheme` media query sets the theme automatically based on the user's device settings, while the `.dark-theme` class allows for manual toggling between light and dark modes.

