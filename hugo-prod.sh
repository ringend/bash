#!/bin/bash

# Runs Hugo Website Build with the "production" environment set.
# Must be run the the Hugo parent directory for website.

printf '\n'
echo "This script must be run the the Hugo parent directory for website"
echo "Creates Hugo Production Environment"
echo "The output is placed in \"public\" folder and the files are scrubed to remove \"robots=noindex\" meta data"
read -p "Press [ENTER] key to continue..."
printf '\n'
printf '\n'

echo "Deleting exisitng Hugo \"public\" folder files"
read -p "Press [ENTER] key to continue..."
rm -R public/*

echo "Starting Hugo Website Build"
hugo  -e production

printf '\n'
echo "Removing \"robots=noindex\" meta data"
read -p "Press [ENTER] key to continue..."

# Recursively seaches and replaces "noindex" in all files in public folder
walk_dir () {
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            printf '.'
            sed -i 's/content="noindex"/content="index"/g' "$pathname"

        fi
    done
}

CHECKING_DIR=public
walk_dir "$CHECKING_DIR"

# Finishing build
printf '\n'
echo "Hugo Build Complete"
printf '\n'
echo "Double checking for \"robots=noindex\" meta data"
grep -R -i "noindex" "$CHECKING_DIR"
echo "---FINISHED Build Process---"

printf '\n'
echo "Coping dev \"public\" files to prod github directory"
read -p "Press [ENTER] key to continue..."
cp -v -r public/* ../godswill-page-prod
echo "---FINISHED Copy Process---"
