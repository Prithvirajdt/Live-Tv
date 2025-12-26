#!/bin/bash

OUTPUT="build/master.m3u"

echo "#EXTM3U" > $OUTPUT

cat static/my_static.m3u | sed '1d' >> $OUTPUT

for file in sources/*.m3u; do
  echo "" >> $OUTPUT
  cat "$file" | sed '1d' >> $OUTPUT
done
