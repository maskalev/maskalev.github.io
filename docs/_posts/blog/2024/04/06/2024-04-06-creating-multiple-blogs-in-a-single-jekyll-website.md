---
layout: post
title: "Creating Multiple Blogs in a Single Jekyll Website"
date: "2024-04-06 10:01:40 +0600"
categories: blog
published: true
comments: true
tags: jekyll
---

At the outset, I'll mention that I'm using the "minima" theme, but I don't think it significantly affects the process.

So, at some point, I decided that I needed to create multiple independent blogs on my website. For example, the main blog (the one you're reading right now) and a TIL (Today I Learned) blog for short notes on interesting things.

First, I familiarized myself with the "category" variable.

The Jekyll documentation provides the following description:

> Instead of placing posts inside of folders, you can specify one or more categories that the post belongs to. When the site is generated the post will act as though it had been set with these categories normally. Categories (plural key) can be specified as a YAML list or a space-separated string.

It seems like just what I need!

Obviously, I want to add links to both blogs in the page header so that I can navigate to the desired blog at any time.

To do this, I created two documents in the root directory to describe these links:

```md
# blog.md{% raw %}
---
layout: blog
title: Blog
permalink: /blog/
{% endraw %}
---

# til.md{% raw %}
---
layout: til
title: TIL
permalink: /til/
{% endraw %}
---
```

Also, in `_config.yml`, I added a section called `header_pages`. It's not mandatory, but it allows you to control the order of links in the header (without this section, the links are arranged in alphabetical order).

```yaml
header_pages:
  - blog.md
  - til.md
```

The last thing left to do was to describe the corresponding templates in the `_layouts` directory.

They are very similar to the default `home.html` page, with just one difference – the line:

```html{% raw %}
{% assign posts = site.posts %}{% endraw %}
```

I replaced it with:

```md
# blog.html{% raw %}
{% assign posts = site.categories.blog %}
{% endraw %}

# til.html{% raw %}
{% assign posts = site.categories.til %}{% endraw %}
```

Now, all you need to do is specify the `categories` variable in the `.md` file with the post text. For example, for this post:

```md
---
layout: post
title: "Creating Multiple Blogs in a Single Jekyll Website"
date: "2024-04-06 10:01:40 +0600"
categories: blog
---
```

I would like to note separately that adding multiple categories also works perfectly!

Useful links on the topic:

- [Description of predefined variables for posts](https://jekyllrb.com/docs/front-matter/#predefined-variables-for-posts) from Jekyll's docs
- [Description of site variables](https://jekyllrb.com/docs/variables/#site-variables) from Jekyll's docs
- [Description of page variables](https://jekyllrb.com/docs/variables/#page-variables) from Jekyll's docs
- [Discussion on Stackoverflow](https://stackoverflow.com/questions/14560687/multiple-blogs-in-single-jekyll-website/)
- [Source code of Minima theme](https://github.com/jekyll/minima)
- [Source code of this site:)](https://github.com/maskalev/maskalev.github.io)

Discussions are welcome!
