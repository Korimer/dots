#! /usr/bin/env bash

kdots="/tmp/korimer-dots"

git clone git@github.com:Korimer/dots "$kdots" 2>/dev/null
result=$?
if [ $result -ne 0 ]; then
  echo "Warning: Git directory $kdots already populated."
fi

shopt -s dotglob
folders=("$kdots"/*)
shopt -u dotglob

pushd "$HOME/.config.bak" || exit 1
echo "this will delete the following files:"

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

rm -rf "${folders[@]}"

shopt -s dotglob
mv /tmp/korimer-dots/* .
shopt -u dotglob

rm -rf "$kdots"

popd || exit 1
