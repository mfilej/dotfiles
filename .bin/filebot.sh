#!/usr/bin/env bash

set -euo pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cmd="/opt/homebrew/bin/filebot"

outdir="/Users/miha/Movies/Plex"

interactive=""

if [ "-i" = "$1" ]; then
        interactive="--mode interactive -non-strict"
        shift
fi

mode="$1"
source="$2"
shift 2

case "$mode" in
        "movie")
                $cmd -rename "$source" --db TheMovieDB --format "$outdir/movies-archive/{plex.name}" "$@" $interactive
                ;;
        "show")
                $cmd -rename "$source" --db TheTVDB --format "$outdir/tv-archive/{plex.tail}" --lang en "$@" $interactive
                ;;
        "subtitle")
                $cmd -get-subtitles "$source" --output srt --encoding utf8 "$@"
                ;;
        *)
                echo "Usage: $0 <movie|show|subtitle> [args]" >&2
                exit 65
        ;;
esac
