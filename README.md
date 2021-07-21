# spawnignore

## Usage

1) `mv spawnignore.sh /usr/local/bin/`

2) `chmod +x /usr/local/bin/spawnignore.sh`

**How to run?**

`spawnignore.sh`

```
spawnignore v1.0.0
Generate gitignore file in seconds.

Usage:
spawnignore.sh [options...] [languages...]

Eptions:
-h --help      to display usage
-d --dir       directory where gitignore needs to be generated[default: current dir]
-l --list      lists all available gitignores

Examples:
> Generating gitignore file of a single language
   spawnignore.sh C++
> Generating gitignore file of a multiple languages
   spawnignore.sh C++ C Fortran
> Listing all available gitignores
   spawnignore.sh -l
> Generate gitignore in a specific directory
   spawnignore.sh -d "path/to/dir" C++ C Fortran
```
