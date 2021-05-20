---
title: "Syncing Git Fork with Original Repository"
date: 2020-09-11T11:30:29+05:30
draft: false
featured: false # feature a post in homepage
tableofcontents: true # whether to generate ToC
tags: [git, tools, ci-cd]
categories: [ci-cd, devops]
hideToc: false
enableToc: true
enableTocContent: true
description: This article helps you in pulling changes into your forked repository from the original one.
image: ""
---

<!--  Start Typing... -->

## TL;DR :rocket:

These are the only commands you need to sync your forked repo with the original repo

```sh
git remote add upstream https://github.com/<Original Owner Username>/<Original Repository>.git
git fetch upstream
git checkout master
git merge upstream/master
git push
```

---

## Why should I do this? :smirk:

Before submitting any pull request, _syncing your forked repository with original repository is an important step to perform_, as you may want to get the bug fixes or additional features to merge with your code since the time you forked the original repo.

## But I can do a PR instead.. :information_desk_person:

You can, but _that adds an extra commit into your forked repo_ instead of matching it with the original repo.

Inorder to sync without any additional changes as a part of the process,

- **Configure the original repo as upstream remote**.
- **Merge changes from original repo**
- **Push the merged version back to Github**.

## Adding original repo as an upstream

- Open the forked repo in your Git Bash or command prompt or terminal.
- List the current configured remote repositories

```sh
git remote -v
> origin  https://github.com/<YOUR_USERNAME>/<YOUR_FORK>.git (fetch)
> origin  https://github.com/<YOUR_USERNAME>/<YOUR_FORK>.git (push)
```

- Add the original repo as upstream repo

```sh
git remote add upstream https://github.com/<ORIGINAL_OWNER>/<ORIGINAL_REPOSITORY>.git
```

- Verify the new upstream repo for your forked repo

```sh
git remote -v
> origin    https://github.com/<YOUR_USERNAME>/<YOUR_FORK>.git (fetch)
> origin    https://github.com/<YOUR_USERNAME>/<YOUR_FORK>.git (push)
> upstream  https://github.com/<ORIGINAL_OWNER>/<ORIGINAL_REPOSITORY>.git (fetch)
> upstream  https://github.com/<ORIGINAL_OWNER>/<ORIGINAL_REPOSITORY>.git (push)
```

You can now pull the changes from original repo.

## Merge changes from upstream

- Open the forked repo in your Git Bash or command prompt or terminal.
- First things first, **fetch the changes (branches and their commits) from upstream**

```sh
git fetch upstream
> remote: Counting objects: 75, done.
> remote: Compressing objects: 100% (53/53), done.
> remote: Total 62 (delta 27), reused 44 (delta 9)
> Unpacking objects: 100% (62/62), done.
> From https://github.com/<ORIGINAL_OWNER>/<ORIGINAL_REPOSITORY>
>  * [new branch]      master     -> upstream/master
```

**Note :** Commits to the original repo(`master`) will be stored in a local branch, `upstream/master`

- Make sure you are on your local (fork's) `master` branch

```sh
git checkout master
> Switched to branch 'master'
```

- The last step, which achieves our goal: **Merge changes from original repo (`upstream/master`) into your forked repo(`master`).**

```sh
git merge upstream/master
> Updating a422352..5fdff0f
> Fast-forward
>  ...
```

This step brings changes of forked repo in sync with original repo, without losing any uncommited changes :D

## Optional Step

If you made changes to your repo and want to push them back to Github

```sh
git push origin master
```

Until next time :wave:, Happy learning! :tada: :computer:

---

If this was helpful to you, please Share this article so that it reaches others as well. To get my latest articles straight to your inbox, please subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) . You can also follow me on twitter [@gsavitha\_](https://twitter.com/gsavitha_).
