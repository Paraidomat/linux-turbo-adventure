pandoc $(ls -d -1 ./Markdown/*.* | sort) -o ./Handout/Handout.html \
    --template ./Template/Handout/template.html \
    --css ./Template/Handout/template.css \
    --self-contained --toc --toc-depth 2
