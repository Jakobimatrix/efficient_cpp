#/bin/sh

for i in $(find * -name '*.md'); do # Not recommended, will break on whitespace
    aspell check "$i"
done
