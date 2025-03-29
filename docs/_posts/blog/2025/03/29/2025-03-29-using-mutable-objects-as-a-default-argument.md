---
layout: post
title: "Using Mutable Objects As A Default Argument"
date: "2025-03-29 15:51:01 +0600"
categories: blog
published: true
comments: false
tags: python
---

It looks harmless, but using a mutable object (like a list or dict) as a default argument can cause confusing and hard-to-track bugs.

I still remember one interview where I was asked about this — and although I knew the basic idea, I couldn’t explain it clearly or fix it properly. That moment stuck with me.

In this post, I’m breaking it down:
- What the issue is and why it happens
- Several possible solutions, including the well-known None default
- Plus a slightly deeper dive — with a sentinel object pattern that avoids subtle edge cases

You're not alone if you've ever been caught off guard by this quirk. Let’s fix it for good!

### Problem description

```python
>>> def foo(x: list[int | None]=[]) -> list[int]:
...     x.append(1)
...     return x
... 
>>> # It seems harmless, but the default value is evaluated only once,
>>> # when the function is defined — not each time it’s called.
>>> foo()
[1]
>>> foo()
[1, 1]
>>> # The list keeps growing on every call — even though we didn’t pass anything!
```

### 1st approach
Checking for an empty list inside the function

```python
>>> def foo(x: list[int | None]=[]) -> list[int]:
...     if not x:
...             x = []
...     x.append(1)
...     return x
... 
>>> foo()       
[1]
>>> foo()
[1]
>>> # It works, but keep in mind that 'not x' triggers __bool__() or __len__() 
>>> # under the hood.
```

### Common solution
This is a common and cleaner approach. 'is' is not overloadable, so it safely compares identities.

```python
>>> def foo(x: list[int | None] | None = None) -> list[int | None]:
...     if x is None: 
...             x = []
...     x.append(1)   
...     return x
... 
>>> foo()
[1]
>>> foo()
[1]
>>> # Caveat: someone could pass 'None' explicitly — which might not be what you want.
```

### The best solution!
For full control, define a unique placeholder object that no one can accidentally pass in.

```python
>>> from typing import Any
>>> _sentinel: Any = object()
>>> def foo(x: list[int | None] = _sentinel) -> list[int | None]:
...     if x is _sentinel:
...             x = []
...     x.append(1)
...     return x
... 
>>> foo()                    
[1]
>>> foo()
[1]
>>> # Clear, safe, and ensures that only actual lists are accepted.
```
