---
title: "Build Your Own Site in 10 min! with hugo "
date: 2020-08-23T14:58:40+05:30
draft: false
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

You need to pick a theme before starting. Wish there was some default theme to get started with. Anyways, there are lots of choices [over here](https://themes.gohugo.io/). I personally recommend to choose [Minimo](https://github.com/MunifTanjim/minimo) as it is simple to get started with (You can tweak it later), and also i'm a great fan of minimalism :wink:

#### Insatlling the theme

Basically you can install a theme in 3 ways.

- Download the zip file and unzip it manually in themes folder
- As a git clone
- As a git submodule.

I recommend that you avoid the `git submodule` workflow they suggest on the page. You surely want to tweak the theme in future. Its best to have a repo for both the content and the theme, as the deployment becomes easier (speaking out of personal experience :sweat_smile: , this method gave me a nightmare :sweat:).

Ok jokes apart. You can download the zip and unzip it manually in the themes/minimo . This method doesn;t work greatly all the time.

So I recommend to clone the repository. From your terminal run

```sh
git clone --depth 1 https://github.com/MunifTanjim/minimo themes/minimo
```

For installation using other methods and also to tweak the website according to your needs. [Check out the official docs](https://minimo.netlify.app/docs/installation/)

Once you have cloned the repo, you need to configure the `config.toml` . As this is the file, which tells Hugo some details of the configuration to the website you created. So copy the `config.toml` from the theme whichever you install so that you dont accidentally change the theme's info. You can change the info from theme once you know advanced concepts of hugo. If you are a beginner it is not recommended to do so.

```sh
cp themes/minimo/exampleSite/config.toml .
```

That's it your website is created. Tweak the `config.toml` with your details and start using it. :smiley:

#### Add content and start the server

To start the server, run the following command in terminal

```sh
hugo serve -D
```

`-D` command builds the static pages.

You can create a new post by creating a new `.md` file, prefixing it with your filename. To create some content run

```sh
hugo new posts/firstpost.md
```

This posts folder automatically gets created in content folder. Edit this newly created file with your content

It will look something like this.

```markdown
---
title: "First post"
date: 2019-03-26T08:47:11+01:00
draft: true
---
```

#### Host and publish the site on your custom domain

Once you have created your site. You can host it on github-pages or netlify or vercel or gitlab. My personal favourite is `github-pages`.

To know how to host it on gh-pages, refer this [official doc](https://gohugo.io/hosting-and-deployment/hosting-on-github/). By hosting the site on the respective platform, you will be given a default domain, you can use it or if you wish to have custom domain. Follow the below steps.

If you have hosted it on github pages.

- Go to your repository settings, under github pages, choose `gh-pages` branch as the source of your website. Under custom domain, add your own domain. Thats it your website is now live! :heart_eyes:
