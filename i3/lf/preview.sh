#!/bin/bash

filetype=$(file -Lb --mime-type "$1")

case "$filetype" in
  image/*)
    img2txt "$1" ;;  # ASCII art preview of image

  application/pdf)
    pdftotext -layout "$1" - | head -n 40 || echo "[Failed to preview PDF]" ;;

  text/*)
    bat --style=plain --color=always "$1" ;;

  *)
    echo "$filetype" && file "$1" ;;
esac

