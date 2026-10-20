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

mkdir -p "$tmpunused"

for file in "${folders[@]}"; do
  leaf=$(basename  "$file")
  echo "moving  $PWD/$leaf to $tmpunused/$leaf"
  mv "$PWD/$leaf" "$tmpunused/$leaf" 2>/dev/null
done

shopt -s dotglob
mv "$kdots"/* .
shopt -u dotglob


git update-index --assume-unchanged install.sh
git update-index --assume-unchanged README.md

git submodule init
git submodule update --remote --no-fetch

rm install.sh
rm README.md

rm -rf "$kdots"

echo "Done!"
echo "Your old/moved dotfiles are present in $tmpunused".
