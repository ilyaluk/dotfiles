#!/bin/sh

tmp=$(mktemp)
jq '.theme = "light"' ~/.claude.json > "$tmp" && mv "$tmp" ~/.claude.json
