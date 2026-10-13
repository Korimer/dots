#! /usr/bin/env bash

kdots="/tmp/korimer-dots"
tmpunused="/tmp/old-dots"

git clone git@github.com:Korimer/dots "$kdots" 2>/dev/null
result=$?
if [ $result -ne 0 ]; then
  echo "Warning: Git directory $kdots already populated."
fi

shopt -s dotglob
folders=("$kdots"/*)
shopt -u dotglob

cd "$HOME/.config" || exit 1
echo "this will modify the following files:"

for file in "${folders[@]}"; do
  echo "  $PWD/$(basename "$file")"
done

if [ "$1" != "-f" ]; then
  read -p "Press Enter to Continue..."
  hasinput=$?
  if [ $hasinput -ne 0 ]; then
    echo "Error: Not running from an interactive terminal."
    exit 1
  fi
fi

mkdir -p "$tmpunused"
mv "${folders[@]}" "$tmpunused"

shopt -s dotglob
mv /tmp/korimer-dots/* .
shopt -u dotglob

rm -rf "$kdots"
