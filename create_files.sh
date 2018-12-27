CurrentDir=$(pwd)

echo ${CurrentDir}

# Handout
pandoc $(ls -d -1 ./Markdown/*.* | sort) -o ./Handout/Handout.html \
    --template "${CurrentDir}/Templates/Handout/GitHub.html5" \
    --self-contained --toc --toc-depth 1

# Web
pandoc $(ls -d -1 ./Markdown/*.* | sort) -o ./Web/Handout.html \
    --template "${CurrentDir}/Templates/Web/template.html" \
    --css "${CurrentDir}/Templates/Web/template.css" \
    --self-contained --toc --toc-depth 1

# Slides
pandoc $(ls -d -1 ./Markdown/*.* | sort) -o ./Slides/moon.html \
    -t revealjs -V theme=moon \
    -V revealjs-url="./Resources/reveal.js-3.7.0" \
    -V transition=slide -V width=1280 -V margin="0.1" \
    --slide-level=2 -s
