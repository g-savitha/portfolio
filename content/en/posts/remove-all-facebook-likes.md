---
title: "Remove All Your Facebook Likes"
date: 2021-04-08T21:50:19+05:30
draft: false
description: "Remove your facebook likes by using this snippet "
tags: [gist, javascript, security, scripts]
categories: [scripts, privacy]
image: "https://micdn-13a1c.kxcdn.com/images/sg/content-images/broken-like-facebook.jpg"
---

Recently came across an interesting code snippet from github gists.

```js
setInterval(() => {
  for (const Button of document.querySelectorAll(
    'div[aria-label="Action options"]'
  )) {
    Button.click();
    document.querySelector('div[role="menuitem"]').click();
  }
}, 1000);
```

Visit the below url and dont forget to replace with your FB username or userid.

https://www.facebook.com/{your_id_or_username}/allactivity/?category_key=LIKEDPOSTS&filter_hidden=ALL&filter_privacy=NONE

You can choose filter to choose year or month.

Once you are done with this, open console on your webpage (`cmd+shift+J` on mac or `ctrl+shift+I` on windows or linux) or just right click on the webpage choose `Inspect Element` then select `Console` and just paste the above snippet and hit `Enter`.

Based upon your activity history it may take some time or it may throw an API limit Error. Nevertheless, you can try again later may be after a day.

Now go and enjoy some privacy :smile: :tada:

---

If this was helpful to you, please Share this article so that it reaches others as well. To get my latest articles straight to your inbox, please subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) . You can also follow me on twitter [@gsavitha\_](https://twitter.com/gsavitha_).
