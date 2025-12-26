- name: Build master playlist (selected channels only)
  run: |
    echo "#EXTM3U" > build/master.m3u

    (
      if [ -f static/my_static.m3u ]; then
        sed '1d' static/my_static.m3u
      fi

      for f in sources/*.m3u; do
        sed '1d' "$f"
      done
    ) | awk '
    BEGIN {
        IGNORECASE=1
        wanted="&tv|anmol tv|big magic|colors hd|colors infinity|colors marathi|colors rishtey|dangal|shemaroo tv|shemaroo umang|set hd|sony pal|sony sab hd|star bharat hd|star plus hd|star pravah hd|star utsav|sun neo hd|sun marathi|zee tv hd|zee marathi hd|zee yuva|zee café hd|zing|&pictures|&pictures hd|&xplore hd|&flix hd|&privé hd|zee anmol cinema|colors cineplex|colors cineplex bollywood|colors cineplex hd|colors cineplex superhit|shemaroo marathibana|sony max sd|sony max hd|sony max1|sony max2|sony yay|sonic hindi|cartoon network hindi|pogo hindi|discovery kids hindi|nickelodeon jr|nick hindi|cartoon network hd\\+ hindi|power kids tv|super hungama|hungama|disney international hd|disney junior|disney channel|nick hd\\+|animax"
    }
    /^#EXTINF/ {
        extinf=$0
        getline url
        if (extinf ~ wanted) {
            if (!seen[url]++) {
                print extinf
                print url
            }
        }
    }' >> build/master.m3u
