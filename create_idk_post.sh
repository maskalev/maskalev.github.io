#!/bin/bash

read -p "Enter new IDK post's title: " post_title

current_date_dir=$(date +"%Y/%m/%d")
current_date_md=$(date +"%Y-%m-%d")
current_datetime=$(date +"%Y-%m-%d %H:%M:%S %z")

formatted_post_title=$(echo "$post_title" | tr "[:upper:]" "[:lower:]" | tr " " "-")

post_directory="./docs/_posts/idk/$current_date_dir"
if [ ! -d "$post_directory" ]; then
    mkdir -p "$post_directory"
fi

post_filename="$post_directory/$current_date_md-$formatted_post_title.md"
if cat > "$post_filename" <<EOF
---
layout: post
title: "$post_title"
date: "$current_datetime"
categories: idk
published: false
comments: false
---
EOF
then
    echo "New empty IDK post was created: $post_filename"
else
    echo "Error occured!"
fi
