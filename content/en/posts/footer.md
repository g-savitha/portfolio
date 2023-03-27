---
title: "Fixing Your Footer Position with Flexbox"
date: 2023-03-27T14:09:27+05:30
draft: false
description: 'CSS Snippet'
hideToc: false
enableToc: false
pinned: false
enableTocContent: false
tags:
 - css
 - snippet
categories:
  - css
  - snippets
---
If you want to fix the position of your footer at the center bottom of your webpage using flexbox layout, you can use the following code:

```html
<body>
  <header class="header">
    <!-- header content here -->
  </header>
  <main class="main">
    <!-- main content here -->
  </main>
  <footer class="footer">
    <!-- footer content here -->
  </footer>
</body>
```
```css
html, body {
  height: 100%;
}
body {
  display: flex;
  flex-direction: column;
}
.main {
  flex: 1;
}
.footer {
  margin-top: auto;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
```
To achieve this, there are a few things to keep in mind:

1. Set the height of the `html` and `body` elements to 100% so that they take up the full height of the screen, even if the content is not long enough to fill the entire height.
2. Set the `flex` property of the `.main` element to 1, which means it will grow to fill any remaining space in the body element after the header and footer have been sized.
3. Use `margin-top: auto` on the `.footer` element to push it to the bottom of the body element and take up any remaining vertical space.

By using percentage-based height on the `html` and `body` elements, and flex property on the .main class, the layout can adapt to different screen sizes and resolutions while maintaining a consistent vertical arrangement of header, main content area, and footer. This approach is particularly useful for creating responsive web designs that work well on mobile devices, tablets, and desktops.

---
If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.

