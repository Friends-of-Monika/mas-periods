#!/bin/sh

dir="$(dirname "$(CDPATH="" cd -- "$(dirname -- "$0")" && pwd)")"
temp="$(mktemp -d)"

build="$dir/build"
mkdir -p "$build"

name="$(perl -ne 'if (/^.*name="([^"]*)"/) { print $1; exit }' "$dir/mod/aa_header.rpy")"
version="$(perl -ne 'if (/^.*version="([^"]*)"/) { print $1; exit }' "$dir/mod/aa_header.rpy")"
package="$(echo "$name" | tr "[:upper:]" "[:lower:]" | tr "[:blank:]" "-")"

mod="$temp/game/Submods/$name"
mkdir -p "$mod"

cp -r "$dir/mod"/* "$mod"

(cd "$temp/game" || exit 1; find . | zip -9@q "$build/$package-$version.zip" && rm -rf "$temp")