---
title: "Slice Type in Rust"
date: 2020-06-30T12:26:32+05:30
draft: false 
meta:
  image: # url to image. Important for blog listing and seo
  description: "slice is a data-type in Rust. Slice references a contiguous
    sequence from a given collection. one cool thing about slice is, it
    can accept both String and Slice types(unlike String, which 
    accepts only itself)..."
featured: false # feature a post in homepage
tableofcontents: true # whether to generate ToC
tags: []
categories: []
---

In Rust, there is a concept of borrowing and taking ownership. This is a concept
not many languages implement.

## Ownership and Borrowing

In a Rust program, any given value is owned by a variable. For instance, if we
declare `let a = 30;`, value `30` would be owned by variable `a`.

Following is a program to illustrate it:

```rust {hl_lines=["5-6"]}
// won't compile
fn main() {
    let some_string = String::from("hello world");

    println!("Length {}", str_length(some_string));
    println!("string is '{}'", some_string);
}

fn str_length(s: String) -> usize {
    s.len()
}
```

### Taking Ownership

Look at the highlighted codeblock. I am passing the variable `some_string` to
function `str_length()` which accepts parameter as value. When the function gets
called, the value of `some_string` **moves** to function `str_length`, making the
variable unusable after the function
call(here: `println!("string is '{}'", some_string);`).
This is called **taking ownership**.

### Borrowing

On the other hand: if I pass argument `some_string` to `str_length` by reference,
the ownership would be retained by `some_string`. A modified version of
`str_length` signature would look like:

```rust
fn str_length(s: &String)
```

This is known as **Borrowing**. It is not quite as simple as it looks like.
There are certains rules which needs to be followed while borrowing a value. For
instance: a variable can be mutated only once at a given scope.

## The Slice Type

A `slice` is reference to a **contiguous sequence** of elements in a collection.
It does not take ownership(since it just _references_ a sequence).

```rust {hl_lines=[4]}
// slice of a string
fn main() {
  let s1 = String::from("hello, Rust");
  let sliced_str = &s1[0..5];  // hello
}
```

A good thing about slice is that it accepts type `String` as well as itself
(i.e. `str` type), unlike `String`(which does not accept `str`).

> In Rust, `..` is called as range syntax.
>
An example would demonstrate it better:

```rust
fn main() {
    let str1 = String::from("hello, Rust");

    print_str(&str1[2..4]); // ll
    print_str(&str1);       // hello, Rust
}

fn print_str(s: &str) {
    println!("{}", s);
}
```

### Slice Varients

Slice comes with quite a few varients, which fits different use cases. Here I am
listing a few:

**Referencing from the start of a Collection:** when referencing from the very
first element in a collection(i.e. 0), one could ommit it. Example: `&s[..4]`.

Likewise, when **referencing upto the last element of a collection**, can be
omitted. `&s[3..]`.

Similarly, when **referencing the whole collection(i.e. from start to end)**,
one can ommit ranges in range syntax. Example: `&s[..]`

### Real-World Example

```rust {hl_lines=[13]}
fn main() {
  let s = String::from("Hello, world");
  let word = get_first_word(&s);

  println!("First word is '{}'", word);
}

fn get_first_word(s: &str) -> &str {
  let str_bytes = s.as_bytes();

  for (i, &item) in str_bytes.iter().enumerate() {
    if item == b' ' {
      return &s[0..i];
    }
  }

  return &s[..];
}
```
