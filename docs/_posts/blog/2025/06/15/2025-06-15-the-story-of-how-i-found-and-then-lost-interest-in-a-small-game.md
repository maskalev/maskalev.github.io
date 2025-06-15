---
layout: post
title: "The Story of How I Found and Then Lost Interest in a Small Game"
date: "2025-06-15 17:12:59 +0600"
categories: blog
published: true
comments: true
tags:
---

A few months ago, I stumbled upon a video puzzle game ([https://videopuzzle.org](https://videopuzzle.org)). As the name suggests, it’s a puzzle, but instead of assembling a static image, you piece together a short video clip. One thing that made it especially engaging was that it tracked the number of moves you made and, at the end, showed a leaderboard with how others performed.

At first, I was just having fun (some puzzles were pretty tricky -- anyone who’s tried to assemble the sky in a jigsaw puzzle knows what I mean). Occasionally, I’d manage to find an efficient solution, but most of the time, my results were far from ideal. That got me thinking: how do you find the perfect solution?

I started working on the puzzles on paper, going through all the possible starting positions -- which, as it turned out, weren’t that many: just 16 combinations. So the real challenge was picking the most optimal solution out of those 16.

I got into a routine of solving one every day, always hunting for the best approach. But it took so much time.

Then I remembered -- I’m a programmer (ha-ha!). So I figured, why not let the computer do the boring part? After some thinking, I realized that solving the puzzle is just a matter of sorting the tiles into the correct order, though with a twist: you can only swap pieces in pairs with each move.

Eventually, I wrote a little script. It took the initial layout of the puzzle and gave me a step-by-step list of moves to solve it most efficiently.

```python
GLOBAL_SWAPS = (
    {},
    {"up": 1},
    {"down": 1},
    {"down": 2},
    {"left": 1},
    {"left": 1, "up": 1},
    {"left": 1, "down": 1},
    {"left": 1, "down": 2},
    {"right": 1},
    {"right": 1, "up": 1},
    {"right": 1, "down": 1},
    {"right": 1, "down": 2},
    {"right": 2},
    {"right": 2, "up": 1},
    {"right": 2, "down": 1},
    {"right": 2, "down": 2},
)


def swap(lst, swap_count=0):
    swaps = []
    for i in range(len(lst)):
        while lst[i] != i + 1:
            correct_index = lst.index(i + 1)
            lst[i], lst[correct_index] = lst[correct_index], lst[i]
            swaps.append((lst[i], lst[correct_index]))
            swap_count += 1
    
    return swap_count, swaps


def shuffle(init_lst, **kwargs):
    lst = init_lst[:]
    for k, v in kwargs.items():
        if k == "up":
            for _ in range(v):
                (
                    lst[0], lst[1], lst[2], lst[3],
                    lst[4], lst[5], lst[6], lst[7],
                    lst[8], lst[9], lst[10], lst[11],
                    lst[12], lst[13], lst[14], lst[15]
                ) = (
                    lst[4], lst[5], lst[6], lst[7],
                    lst[8], lst[9], lst[10], lst[11],
                    lst[12], lst[13], lst[14], lst[15],
                    lst[0], lst[1], lst[2], lst[3],
                )
        elif k == "down":
            for _ in range(v):
                (
                    lst[0], lst[1], lst[2], lst[3],
                    lst[4], lst[5], lst[6], lst[7],
                    lst[8], lst[9], lst[10], lst[11],
                    lst[12], lst[13], lst[14], lst[15]
                ) = (
                    lst[12], lst[13], lst[14], lst[15],
                    lst[0], lst[1], lst[2], lst[3],
                    lst[4], lst[5], lst[6], lst[7],
                    lst[8], lst[9], lst[10], lst[11]
                )
        elif k == "left":
            for _ in range(v):
                (
                    lst[0], lst[1], lst[2], lst[3],
                    lst[4], lst[5], lst[6], lst[7],
                    lst[8], lst[9], lst[10], lst[11],
                    lst[12], lst[13], lst[14], lst[15]
                ) = (
                    lst[1], lst[2], lst[3], lst[0],
                    lst[5], lst[6], lst[7], lst[4],
                    lst[9], lst[10], lst[11], lst[8],
                    lst[13], lst[14], lst[15], lst[12]
                )
        elif k == "right":
            for _ in range(v):
                (
                    lst[0], lst[1], lst[2], lst[3],
                    lst[4], lst[5], lst[6], lst[7],
                    lst[8], lst[9], lst[10], lst[11],
                    lst[12], lst[13], lst[14], lst[15]
                ) = (
                    lst[3], lst[0], lst[1], lst[2],
                    lst[7], lst[4], lst[5], lst[6],
                    lst[11], lst[8], lst[9], lst[10],
                    lst[15], lst[12], lst[13], lst[14]
                )
    return lst


def main(init_lst):
    best_swap_count = float("inf")
    for global_swap in GLOBAL_SWAPS:
        swap_count, swaps = swap(shuffle(init_lst=init_lst, **global_swap), swap_count=sum(global_swap.values()))
        if swap_count < best_swap_count:
            best_swap_count = swap_count
            best_global_swap = global_swap
            best_swaps = swaps
    return best_swap_count, best_global_swap, best_swaps
  

if __name__ == "__main__":
    print("===== TESTS =====")
    init_lst = [7, 10, 14, 15, 3, 2, 9, 1, 16, 11, 13, 12, 6, 8, 5, 4]
    assert shuffle(init_lst=init_lst, up=1) == [3, 2, 9, 1, 16, 11, 13, 12, 6, 8, 5, 4, 7, 10, 14, 15], shuffle(init_lst=init_lst, up=1)
    assert shuffle(init_lst=init_lst, down=1) == [6, 8, 5, 4, 7, 10, 14, 15, 3, 2, 9, 1, 16, 11, 13, 12], shuffle(init_lst=init_lst, down=1)
    assert shuffle(init_lst=init_lst, left=1) == [10, 14, 15, 7, 2, 9, 1, 3, 11, 13, 12, 16, 8, 5, 4, 6], shuffle(init_lst=init_lst, left=1)
    assert shuffle(init_lst=init_lst, right=1) == [15, 7, 10, 14, 1, 3, 2, 9, 12, 16, 11, 13, 4, 6, 8, 5], shuffle(init_lst=init_lst, right=1)
    assert main(init_lst) == (13, {}, [(1, 7), (2, 10), (3, 14), (4, 15), (5, 14), (6, 10), (7, 9), (8, 9), (9, 16), (10, 11), (11, 13), (14, 16), (15, 16)]), main(init_lst)

    init_lst = [9, 14, 11, 7, 4, 16, 12, 6, 8, 1, 3, 10, 15, 5, 2, 13]
    assert main(init_lst) == (12, {"left": 1, "up": 1}, [(1, 16), (2, 12), (3, 6), (5, 16), (7, 10), (9, 16), (10, 12), (11, 13), (12, 15), (13, 14)]), main(init_lst)

    init_lst = [4, 7, 5, 6, 15, 14, 13, 11, 16, 9, 2, 10, 8, 1, 3, 12]
    assert main(init_lst) == (12, {}, [(1, 4), (2, 7), (3, 5), (4, 6), (5, 15), (6, 14), (7, 13), (8, 11), (9, 16), (10, 16), (11, 13), (12, 16)]), main(init_lst)

    init_lst = [14, 9, 5, 2, 15, 6, 4, 7, 16, 11, 1, 10, 8, 12, 3, 13]
    assert main(init_lst) == (12, {}, [(1, 14), (2, 9), (3, 5), (4, 9), (5, 15), (7, 9), (8, 9), (9, 16), (10, 11), (11, 14), (12, 14), (13, 16)]), main(init_lst)

    init_lst = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    assert main(init_lst) == (0, {}, []), main(init_lst)

    init_lst = [14, 15, 16, 13, 2, 3, 4, 1, 6, 7, 8, 5, 10, 11, 12, 9]
    assert main(init_lst) == (2, {"right": 1, "up": 1}, []), main(init_lst)

    init_lst = [3, 10, 11, 14, 9, 15, 8, 5, 16, 13, 2, 1, 4, 7, 12, 6]
    assert main(init_lst) == (12, {"right": 1}, [(1, 14), (2, 3), (3, 10), (4, 11), (6, 9), (7, 15), (9, 14), (10, 16), (11, 13), (12, 16), (13, 14)]), main(init_lst)

    init_lst = [4, 8, 2, 11, 14, 15, 6, 1, 16, 12, 5, 10, 9, 7, 13, 3]
    assert main(init_lst) == (11, {"left": 1}, [(1, 8), (3, 11), (5, 15), (7, 8), (8, 14), (9, 12), (10, 15), (11, 15), (12, 16), (13, 14)]), main(init_lst)

    print("===== TESTS OK =====")

    init_lst = [int(x) for x in input("Еnter the numbers through a space: ").split()]
    best_swap_count, best_global_swap, best_swaps = main(init_lst=init_lst)

    print(f"best_swap_count = {best_swap_count}")
    print(f"best_global_swap = {best_global_swap}")
    print(f"best_swaps = {best_swaps}")
```

I was the leaderboard champion for a couple of weeks!

![fig. A]({{ "/assets/blog/2025/06/15/videopuzzle-results.jpg" | relative_url }})

But then... I just got bored. I wasn’t playing anymore -- I was just replaying the same sequence of moves my algorithm had figured out for me.

But hey, that’s programming for you: being too lazy to do something by hand, so you spend three days automating it to run in five seconds.

Thanks, VideoPuzzle -- it was fun, right up until you turned into a terminal command.
