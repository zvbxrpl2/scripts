#!/usr/bin/env bash
# Download whole YouTube channels/playlists into per-playlist folders.
# Dedupes across all runs via a shared archive file.
# Format (1080p mp4/mp3), --ignore-errors, and metadata come from
# ~/.config/yt-dlp.conf — do not duplicate them here.

base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
archive="$base_dir/archive.txt"

dl() {
  local url="$1"
  yt-dlp --download-archive "$archive" \
    -o "%(playlist,channel)s/%(title,id)s.%(ext)s" \
    "$url"
}

dl https://www.youtube.com/@WelchLabs/videos

dl https://www.youtube.com/@WoodenToby/videos
dl https://www.youtube.com/@hoff._world/videos
# dl https://www.youtube.com/@ThisisAutomation/videos
dl https://www.youtube.com/@computablesecrets/videos

# Digikey
dl https://www.youtube.com/playlist?list=PLEBQazB0HUyTpoJoZecRK6PpDG31Y7RPB
dl https://www.youtube.com/playlist?list=PLEBQazB0HUyQ4hAPU1cJED6t3DU0h34bz
dl https://www.youtube.com/playlist?list=PLEBQazB0HUyRYuzfi4clXsKUSgorErmBv
dl https://www.youtube.com/playlist?list=PLEBQazB0HUyT1WmMONxRZn9NmQ_9CIKhb
dl https://www.youtube.com/playlist?list=PLEBQazB0HUyTmK2zdwhaf8bLwuEaDH-52

# Rohde and Schwarz
dl https://www.youtube.com/playlist?list=PLKxVoO5jUTlvsVtDcqrVn0ybqBVlLj2z8


dl https://www.youtube.com/@em3755/videos
dl https://www.youtube.com/@parinaznaseri/videos
dl https://www.youtube.com/@nandland/videos
dl https://www.youtube.com/@FPGAsforBeginners/videos

dl https://www.youtube.com/@kanepixels/videos
dl https://www.youtube.com/@BrianBDouglas/videos
dl https://www.youtube.com/@youngmoo-kim/videos
dl https://www.youtube.com/@Wendoverproductions/videos
dl https://www.youtube.com/TechnologyConnections/videos
dl https://www.youtube.com/@TheEfficientEngineer/videos
dl https://www.youtube.com/@BobbyBroccoli/videos
dl https://www.youtube.com/@veritasium/videos
dl https://www.youtube.com/@theserialport/videos
dl https://www.youtube.com/@OldLegoGuy/videos
dl https://www.youtube.com/@mathemaniac/videos
dl https://www.youtube.com/@braintruffle/videos
dl https://www.youtube.com/@2swap/videos
dl https://www.youtube.com/@EggyBricks/videos
dl https://www.youtube.com/@3blue1brown/videos

dl https://www.youtube.com/@VisualElectric_/videos
dl https://www.youtube.com/@SheafificationOfG/videos
dl https://www.youtube.com/@JCS/videos

dl https://www.youtube.com/@Aleph0/videos
dl https://www.youtube.com/@AndrejKarpathy/videos
dl https://www.youtube.com/@Asianometry/videos
dl https://www.youtube.com/@BatteryPoweredBricks/videos
dl https://www.youtube.com/@DavesGarage/videos
dl https://www.youtube.com/@EngineeringMindset/videos
dl https://www.youtube.com/@hoe_math/videos
dl https://www.youtube.com/@knitronics/videos
dl https://www.youtube.com/@lauriewired/videos
dl https://www.youtube.com/@lemmino/videos
dl https://www.youtube.com/@MattKC/videos
dl https://www.youtube.com/@Mutual_Information/videos
dl https://www.youtube.com/@naohah/videos
dl https://www.youtube.com/@NickonPlanetRipple/videos
dl https://www.youtube.com/@PolylogCS/videos
dl https://www.youtube.com/@RRSlugger/videos
dl https://www.youtube.com/@TrikBrix/videos
dl https://www.youtube.com/@Unbrickme/videos
dl https://www.youtube.com/@upandatom/videos
dl https://www.youtube.com/@vintagebricks/videos
dl https://www.youtube.com/@VK3FS/videos
dl https://www.youtube.com/@ylraisa/videos
dl https://www.youtube.com/@YTomS/videos



# dl https://www.youtube.com/@formula6033/videos
# dl https://www.youtube.com/@videogameflashback/videos
# dl https://www.youtube.com/@RockinPixieGaming/videos
# dl -x https://www.youtube.com/@WeicheWotanWeiche/videos
# dl https://www.youtube.com/@drspock888/videos
# dl https://www.youtube.com/@dodoid/videos

# https://www.youtube.com/@SoundcircusJM/videos

# # dl https://www.youtube.com/playlist?list=PLywxmTaHNUNzbZAAHdpAr3vL4ByyaEsSi
# # dl https://www.youtube.com/playlist?list=PLywxmTaHNUNz2cHKw9uFaIidmxykVceBI
# # dl https://www.youtube.com/playlist?list=PLywxmTaHNUNyKmgF70q8q3QHYIw_LFbrX
# # dl https://www.youtube.com/playlist?list=PLUl4u3cNGP63ZWyJMdWIVtyweopUN3xt3
# # dl https://www.youtube.com/playlist?list=PLUl4u3cNGP62UTc77mJoubhDELSC8lfR0
# # dl https://www.youtube.com/playlist?list=PLKxVoO5jUTlvsVtDcqrVn0ybqBVlLj2z8
# # dl https://www.youtube.com/playlist?list=PLbtm7s7Q26xPmLbnvEoU13RqO1Up9wu5r
