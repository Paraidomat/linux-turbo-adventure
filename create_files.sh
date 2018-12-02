CurrentDir=$(pwd)

echo ${CurrentDir}

# pandoc $(ls -d -1 ./Markdown/*.* | sort) -o ./Handout/Handout.html \
#    --template "${CurrentDir}/Template/Handout/template.html" \
#    --css "${CurrentDir}/Template/Handout/template.css" \
#    --self-contained --toc --toc-depth 2

pandoc $(ls -d -1 ./Markdown/*.* | sort) -o ./docs/moon.html \
    -t revealjs -V theme=moon \
    -V revealjs-url="./Resources/reveal.js-3.7.0" \
    -V transition=slide -V width=1280 --slide-level=2 -s
