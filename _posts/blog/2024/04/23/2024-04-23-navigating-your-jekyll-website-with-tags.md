---
layout: post
title: "Navigating Your Jekyll Website with Tags"
date: "2024-04-23 23:04:02 +0600"
categories: blog
published: true
comments: true
tags: jekyll
---

So, I decided to enhance the navigation on my website and add tags functionality to my posts.

Here's what I wanted to accomplish:

1. Add tags to all of my posts.
1. Create a page listing all tags.
1. Create individual pages for each tag listing all relevant posts.

The first step was to define the "tag" variable in the Front Matter section for each post. For example, here's how I did it for this post:

```md
---
layout: post
title: "Navigating Your Jekyll Website with Tags"
tags: jekyll
---
```

Next, I added a block to handle tags processing in the `post.html` layout:

```html{% raw %}
<p class="post-meta">
  {% if page.tags %}
    {% assign tags = page.tags | remove: "[" | remove: "]" | replace: '"', '' | split: ", " %}
    {% for tag in tags %}
        <a href="/tags/{{ tag }}">#{{ tag }}</a>
    {% endfor %}
  {% endif %}
</p>{% endraw %}
```

In the next step, I needed to create a page listing all tags. I created the `tags.html` layout:

```html{% raw %}
---
layout: base
---

{% assign tags = site.tags %}

<div>
  <h1 class="page-heading">{{ page.title }}</h1>
  <ul style='padding-top: 16px;'>
  {% for tag in tags %}
    <li>
      <a href="/tags/{{ tag[0] }}">{{ tag[0] }} ({{ tag[1] | size }})</a>
    </li>
  {% endfor %}
</div>{% endraw %}
```

And added the corresponding .md file:

```md
---
layout: tags
title: Tags
permalink: /tags/
---
```

Finally, I created individual pages for each tag listing all relevant posts. For this, I created the `tag.html` layout:

```html{% raw %}
---
layout: base
---

<div>
  <h1>Articles tagged with "{{ page.tags }}"</h1>
  <ul style='padding-top: 16px;'>
    {% for post in site.posts %}
      {% if post.tags contains page.tags %}
        <li><a href="{{ post.url }}">{{ post.title }}</a>, published {{ post.date | date: "%Y-%m-%d" }}</li>
      {% endif %}
    {% endfor %}
  </ul>
</div>{% endraw %}
```

Then, I created a `tags` directory in the project root and for each tag, I created a .md file. For example:

```md
---
layout: tag
tags: jekyll
---
```

Note: There are different approaches to naming the directory for tags. Some recommend `_tags`, but this didn't work for me. Perhaps you have your own thoughts on this, and I'd be glad to hear them in the comments!

Useful links on the topic:

- [Description of Font Matter](https://jekyllrb.com/docs/front-matter/) from Jekyll's docs
- [Description of site variables](https://jekyllrb.com/docs/variables/#site-variables) from Jekyll's docs
- [Description of page variables](https://jekyllrb.com/docs/variables/#page-variables) from Jekyll's docs
- [How do I tag posts in Jekyll? Jekyll tagging made simple](https://www.untangled.dev/2020/06/02/tag-management-jekyll/) from blog of Joseph Victor Zammit
- [Managing tags in Jekyll blog easily](https://blog.lunarlogic.com/2019/managing-tags-in-jekyll-blog-easily/) from blog of Lunar Logic
- [Source code of this site:)](https://github.com/maskalev/maskalev.github.io)
