#!/bin/bash

read -p "Enter new tag's title: " tag_title


tag_filename="tags/$tag_title.md"
if cat > "$tag_filename" <<EOF
---
layout: tags
tags: $tag_title
---
EOF
then
    echo "New empty tag was created: $tag_title"
else
    echo "Error occured!"
fi
