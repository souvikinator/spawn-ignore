#!/bin/bash
TEMPLATE_DIR="$HOME/.gitignore_template"

read -r -d '' _usage <<- EOF

spawnignore v1.0.0
Generate gitignore file in seconds.

Usage:
./spawnignore.sh [options...] [languages...]

Eptions:
-h --help      to display usage
-d --dir       directory where gitignore needs to be generated[default: current dir]
-l --list      lists all available gitignores

Examples:
> Generating gitignore file of a single language
   ./spawnignore.sh C++
> Generating gitignore file of a multiple languages
   ./spawnignore.sh C++ C Fortran
> Listing all available gitignores
   ./spawnignore.sh -l
> Generate gitignore in a specific directory
   ./spawnignore.sh -d "path/to/dir" C++ C Fortran

EOF

#function to list all existing gitignore files
list_gitignores(){
   for entry in "$TEMPLATE_DIR"/*.gitignore
   do
      file=$(basename -- "$entry")
		echo "${file%.*}"
   done
}

#create template dir if doesn't exist
if [ ! -d $TEMPLATE_DIR ];then
   echo "Downloading templates..."
   mkdir $TEMPLATE_DIR
   git clone "https://github.com/github/gitignore.git" $TEMPLATE_DIR
   echo "------------------------"
fi

#parse command line options
dir="."
languages=()

#if no args is passed
if [[ "$#" == 0 ]]; then
   echo "$_usage"
   exit 0
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
       -h|--help)
          echo "$_usage"
          exit 0
          ;;
       -d|--dir)
          dir=$2
          shift 2
          ;;
       -l|--list)
          list_gitignores
          exit 0
          ;;
       *)
          languages+=($1)
          shift
          ;;
    esac
done

gitignore_dir="$dir/.gitignore"
# check if certain gitignore file exists
# if so then append the contents
for lang in "${languages[@]}"
do
   gitignore=$(find "$TEMPLATE_DIR/" -iname "$lang.gitignore")
   #if file exists
   if [ "${#gitignore}" -gt 0 ]; then
      cat "$gitignore" >> "$gitignore_dir"
      echo "[~] $lang"
   else
      echo "[x] $lang: no template found"
   fi
done
echo "All set ;)"
