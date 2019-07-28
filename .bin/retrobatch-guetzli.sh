#!/usr/bin/env bash

set -euo pipefail

/usr/local/bin/guetzli --quality 86 "$1" "$1"
