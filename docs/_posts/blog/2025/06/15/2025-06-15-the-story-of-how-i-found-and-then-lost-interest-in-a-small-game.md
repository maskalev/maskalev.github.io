---
layout: post
title: "The Story of How I Found and Then Lost Interest in a Small Game"
date: "2025-06-15 17:12:59 +0600"
categories: blog
published: true
comments: true
tags:
---

A few months ago, I came across a video puzzle ([https://videopuzzle.org](https://videopuzzle.org)). As the name implies, this is a puzzle, but you don't need to assemble a static picture, but a video clip. An additional motivating factor was that the game counts the number of moves and, at the end, shows a rating that shows the number of moves that other participants have made. 

At first, I was just having fun with this game (some tasks were quite difficult -- anyone who remembers how difficult it is to assemble the sky in an ordinary puzzle will understand me), and, although sometimes I could find the best solution, on average, my solutions were far from ideal. So I started thinking about how to find the perfect solution!

I was solving a puzzle in a paper, going over all the possible starting combinations (that's how I found out that there weren't many of them -- only 16). That is, my task is to choose the most optimal solution out of 16.

So I started finding the best solution every day. But it's been sooo long!

Remembering that I am a programmer (ha-ha!), I decided to entrust the search for a solution to my computer. After some thought, I concluded that solving a puzzle means SORTING the puzzle elements in the right order! However, special sorting conditions must be taken into account, since on each move the puzzle elements can only be swapped in pairs.

In general, some time later, I had a small script ready that took the initial position of the elements and, as a result, displayed a list of moves that needed to be made in order to assemble the puzzle optimally. 

I was the champion for a couple of weeks!

![fig. A]({{ "/assets/blog/2025/06/15/videopuzzle-results.jpg" | relative_url }})

But then I just got tired of it, because I was no longer playing, but just replaying the moves that the algorithm offered me.

But, as they say, programming is when you're too lazy to do something manually, so you spend three days automating it in five seconds.

Thanks, videopazzle! It was fun until you turned into a console team.
