---
title: "Build Your Own Site in 10 min! with hugo "
date: 2020-08-23T14:58:40+05:30
draft: true
meta:
  image: # url to image. Important for blog listing and seo
  description: # overrides .Summary
featured: false # feature a post in homepage
tableofcontents: true # whether to generate ToC
tags: ["hugo", "website", "portfolio"]
categories: [misc]
---

<!--  Start Typing... -->

Yes you read it right, you can build and host your website in 10 min :hushed:.

How?

## Static site generators to the rescue

### Ok, but what is a static site? :confused:

Basically websites are of two types, `static` and `dynamic`. A static site as the name sounds it is - static, constant and fixed. It doesn't change dynamically when a developer makes a change to a file . They just create the static content(HTML and CSS) and upload them on to the server where it remains unchanged.

Where as dynamic sites are in almost constant state of change and are powered by servers or [Content Management Systems(CMS)](https://kinsta.com/knowledgebase/content-management-system/). Server or CMS builds each page dynamically whenever a change occurs. When a URL is requested to fetch, CMS gets the appropriate data from the DB, loads on HTML, renders the content within template and returns formatted HTML to client's browser. This process is also known as `server side processing`.

### Looks like CMS websites are the solution, then why SSG? :woman_shrugging:

Oh boy, you are a tough cookie. Lets see the disadvantages of CMS in brief.

- As CMS started growing popularity, CMS plugins or software have become more vulnerable to cyber attacks and this number is growing. [ITPRO reports](https://www.itpro.co.uk/security/33149/90-of-hacked-cms-sites-in-2018-were-powered-by-wordpress).
- Performance issues. Obviously, because server is doing the more work. Page needs to be loaded each and every time a request is sent, whenever a user visits a site, backend code needs to startup, interact with db, construct a HTTP response and send it back to server, after all this stuff is done, finally HTML file is returned to display the content.

### How SSGs helps us?

Static site generators (SSGs) allow you to have a compromise between writing out a bunch of static html pages and using a potentially heavy (CMS) - retaining the benefits of both :open_mouth: . SSGs give us a flexibility to write code dynamically and publish statically.

SSGs generates all the static pages of your site at once and deploys it to HTTP server.

#### Benefits of using SSGs in brief?

- Speed and performance.
- Secured. Now we dont have the problems that come with CMS powered websites. Since static website is solely static files, they have no DB - no DB means no chance of getting hacked .
- Improved cost and reliabilty. As we dont have a DB, we dont get connection errors like `failed to establish connection to DB` and also less maintainance costs as we dont have DB and more.

### Types of SSGs

Now, lets look at some of the most popular options.

- [Hugo](https://gohugo.io/) is a very popular SSG which claims itself as a fastest framework for building sites. It is written in [Go](https://golang.org/)
- [Next.js](https://nextjs.org/) is a server-rendered framework developed on top of [React](https://reactjs.org/).
- [Gatsby.js](https://www.gatsbyjs.com/) is built in React and uses [GraphQL](https://graphql.org/) to manipulate data. It works great with documentation and blogs.
- [Jekyll](https://jekyllrb.com/) is written using [Ruby](https://www.ruby-lang.org/en/).

Enough with words, Lets get started by building a site.

## Build site with Hugo

#### Install hugo

To install hugo on linux(Ubuntu and Debian) from your terminal run

```sh
sudo apt-get install hugo

```

For other platforms, check the [official guide](https://gohugo.io/getting-started/installing/)

#### Create a site

Once you install hugo, create a hugo site using

```sh
hugo new site mywebsite

```

#### Select a theme

You need to pick a theme before starting. Wish there was some default theme to get started with. Anyways, there are lots of choices [over here](https://themes.gohugo.io/). I personally recommend to choose []()
