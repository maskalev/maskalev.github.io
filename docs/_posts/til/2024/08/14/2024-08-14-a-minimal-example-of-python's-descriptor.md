---
layout: post
title: "A minimal example of Python's descriptor"
date: "2024-08-14 14:37:18 +0600"
categories: til
published: true
comments: true
---

A minimal example of Python's descriptor

Today I've looked into Python's descriptors to find a minimal example of it.

What I done.
 
It known that in descriptor you can define methods `__set__()`, `__get__(),` and `__delete__()` to manage of accessing to object's attributes. But what is the minimal set of these methods you can define in your descriptor? To find the answer to this question I created three classes, each consisting only of one method.
```python
class Foo:
    def __init__(self, foo, bar, baz):
        self._foo = foo
        self._bar = bar
        self._baz = baz
    
    class D_set:
        def __set__(self, instance, value):
            print("__set__ method")
            instance._foo = value


    class D_get:
        def __get__(self, instance, owner):
            print("__get__ method")
            return instance._bar


    class D_delete:
        def __delete__(self, instance):
            print("__delete__ method")
            del instance._baz

    foo = D_set()
    bar = D_get()
    baz = D_delete()
```

```python
>>> foo = Foo("foo", "bar", "baz")
>>> foo.foo
<foo.Foo.D_set object at 0x7d5498c40f40>
>>> foo.bar
__get__ method
'bar'
>>> foo.baz
<foo.Foo.D_delete object at 0x7d5498c40d60>
```

You can see that only the `D_get` class is a real descriptor (it manages to access to the `self._bar` attribute). Others are not descriptors, because values of `self._foo` and `self._baz` attributes are instances, not strings.