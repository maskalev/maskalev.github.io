---
layout: post
title: "How to parse XML with non-unique tags?"
date: "2024-02-05 15:30:24 +0600"
categories: blog
published: true
comments: true
tags: xml
---

It is not difficult to parse an XML document in which all tags are unique (or the path to them is unique). And it's good if that's how your schemes are described! But they are not always described the way you want them to be. Clients often come to you with their own schemes that cannot be changed. And you will have to process, for example, such a document:

```xml
<?𝚡𝚖𝚕 𝚟𝚎𝚛𝚜𝚒𝚘𝚗="𝟷.𝟶" 𝚎𝚗𝚌𝚘𝚍𝚒𝚗𝚐="𝚄𝚃𝙵-𝟾"?>
<𝚋𝚘𝚍𝚢>
   <𝚙𝚊𝚛𝚝𝚗𝚎𝚛𝚜>
       <𝚙𝚊𝚛𝚝𝚗𝚎𝚛>
           <𝚛𝚘𝚕𝚎>𝚜𝚞𝚙𝚙𝚕𝚒𝚎𝚛</𝚛𝚘𝚕𝚎>
           <𝚗𝚊𝚖𝚎>𝚏𝚊𝚌𝚝𝚘𝚛𝚢</𝚗𝚊𝚖𝚎>
           <𝚌𝚘𝚍𝚎>𝟷𝟸𝟹𝟺𝟻𝟼</𝚌𝚘𝚍𝚎>
       </𝚙𝚊𝚛𝚝𝚗𝚎𝚛>
       <𝚙𝚊𝚛𝚝𝚗𝚎𝚛>
           <𝚛𝚘𝚕𝚎>𝚛𝚎𝚜𝚎𝚕𝚕𝚎𝚛</𝚛𝚘𝚕𝚎>
           <𝚗𝚊𝚖𝚎>𝚜𝚝𝚘𝚛𝚎</𝚗𝚊𝚖𝚎>
           <𝚌𝚘𝚍𝚎>𝟸𝟹𝟺𝟻𝟼𝟽</𝚌𝚘𝚍𝚎>
       </𝚙𝚊𝚛𝚝𝚗𝚎𝚛>
       <𝚙𝚊𝚛𝚝𝚗𝚎𝚛>
           <𝚛𝚘𝚕𝚎>𝚌𝚞𝚜𝚝𝚘𝚖𝚎𝚛</𝚛𝚘𝚕𝚎>
           <𝚗𝚊𝚖𝚎>𝚙𝚎𝚛𝚜𝚘𝚗</𝚗𝚊𝚖𝚎>
           <𝚌𝚘𝚍𝚎>𝟹𝟺𝟻𝟼𝟽𝟾</𝚌𝚘𝚍𝚎>
       </𝚙𝚊𝚛𝚝𝚗𝚎𝚛>
   </𝚙𝚊𝚛𝚝𝚗𝚎𝚛𝚜>
</𝚋𝚘𝚍𝚢>
```

As you can see, there are several `𝚙𝚊𝚛𝚝𝚗𝚎𝚛` segments here that describe the participants in a particular chain. We are interested in the tag `𝚌𝚘𝚍𝚎` of the participant with the `𝚛𝚘𝚕𝚎 = 𝚛𝚎𝚜𝚎𝚕𝚕𝚎𝚛`. The problem is that the document provider does not guarantee either the number of `𝚙𝚊𝚛𝚝𝚗𝚎𝚛` segments or their order (`𝚛𝚘𝚕𝚎 = 𝚌𝚞𝚜𝚝𝚘𝚖𝚎𝚛` may precede `𝚛𝚘𝚕𝚎 = 𝚜𝚞𝚙𝚙𝚕𝚒𝚎𝚛`). It is even possible that the segment we need will be missing!

A map is ideal for solving the problem, where the keys are the contents of the `𝚛𝚘𝚕𝚎` tags, and the values are the contents of the `𝚌𝚘𝚍𝚎` tags. It will turn out something like this:

```python
𝚖𝚊𝚙_ = {"𝚜𝚞𝚙𝚙𝚕𝚒𝚎𝚛": "𝟷𝟸𝟹𝟺𝟻𝟼", "𝚛𝚎𝚜𝚎𝚕𝚕𝚎𝚛": "𝟸𝟹𝟺𝟻𝟼𝟽", "𝚌𝚞𝚜𝚝𝚘𝚖𝚎𝚛": "𝟹𝟺𝟻𝟼𝟽𝟾"}
```

In the end, we just need to extract the value of the desired key!

Of course, you may need to deal with various exceptions (for example, empty or missing tags), but this, as well as the way to get a map, depends on your preferences and technical specifications (if you are lucky enough to have one). I just tried to talk about the method, not about its specific technical implementation.
