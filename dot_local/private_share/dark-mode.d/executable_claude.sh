#!/bin/sh

tmp=$(mktemp)
jq '.theme = "dark"' ~/.claude.json > "$tmp" && mv "$tmp" ~/.claude.json
