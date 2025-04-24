---
title: "Fluid Grids"
url: "/posts/fluid-grids"
date: 2023-04-01T23:01:00+05:30
draft: false
description: 'CSS Snippet'
hideToc: false
enableToc: false
pinned: false
enableTocContent: false
tags:
 - css
 - snippets
 - css-grid
categories:
  - frontend
---

## How to implement fluid grids?

Let's look at this *world famous* CSS snippet that creates a dynamic number of columns (as you resize your browser), maintaining each column to be the same width.

{{< codes html css >}}
{{< code >}}
```html
<main class="grid">
  <div class="grid_item"></div>
  <div class="grid_item"></div>
  <div class="grid_item"></div>
  <div class="grid_item"></div>
  <div class="grid_item"></div>
  <div class="grid_item"></div>
</main>
```
{{< /code >}}
{{< code >}}
```css
.grid {
    display: grid;
    gap: 16px;
    grid-template-columns:
      repeat(auto-fill, minmax(150px, 1fr));
  }
```
{{< /code >}}
{{< /codes >}}

This is useful when we have a list of items to render, lets take card components for instance. We want them to be uniform and tile nicely no matter what the screen size is, or how many items we have.

Let's try to understand the snippet.
1. `minmax` function of CSS grid, helps us in constraining the value between upper and lower bounds. 
2. `auto-fill` helps us to fit our grid with as many 150px wide columned cards as possible. They increase/ decrease as we resize our browser. `auto-fill` helps us to implement **_fluid behaviour_** in grid.


What if the width of the grid is higher, lets say 420px? On larger screens its fine, but on smaller screens, you might see a weird *horizontal scrollbar* extending on your screen. To avoid that, we can implement this in 2 ways.

1. One obvious approach is, using **media queries** to get a responsive layout on smaller screens

```css
.grid{
  display: grid;
  gap : 16px; 
  grid-template-columns: 1fr;
}
/* taking that extra 15px for scrollbars */
@media(min-width: 435px){
  .grid{
    display: grid;
    gap: 16px;
    grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
  }
}
```

2. Alternatively, we can use a **fluid approach** by adding another constraint to the snippet.

```css
.grid{
  display: grid;
  gap: 16px;
  grid-template-columns: repeat(auto-fill, minmax(min(420px,100%),1fr));
}
```

Let's break this down.

`min(420px,100%)`: Here `100%` refers to `.grid`'s width. If your screen size is 1600px, then 100% of `.grid`'s width would be 1600px. If your screen size is 250px, 100% of that would be 250px. Considering the screensize, minimum of the 420px and 100% will be picked up. Once we have figured out the min value, that value will be plugged into your "world famous snippet".

