# Brew Auto Installer

This is a bash script to automate the install of [brew](https://github.com/Homebrew/brew) and install apps from a json file.

Requires [jq](https://github.com/stedolan/jq).

Written to work with macOS tho should work with [Homebrew](https://github.com/Homebrew/brew) on Linux.

## Install

Clone this repo move the script into your path.
Or download it from [here](https://raw.githubusercontent.com/chimbosonic/brew-auto-installer/main/brew-auto-installer.sh).

```bash
mkdir -p ~/bin/
cd ~/bin/
curl -fsSL https://raw.githubusercontent.com/chimbosonic/brew-auto-installer/main/brew-auto-installer.sh -o ~/bin/brew-auto-installer.sh
chmod +x ~/bin/brew-auto-installer.sh
echo "export PATH=$HOME/bin:$PATH" >> ~/{{your shell rc file}}
```

## Usage

```bash
$ ./brew-auto-installer.sh -h
usage: ./brew-auto-installer.sh [flags]
./brew-auto-installer.sh installs tools found in a json file with Brew
-f str    path to the json file that contains the list tools (required)
-u        force update existing tools
-h        print usage of the tool
```

## Notes

The script will check if [brew](https://github.com/Homebrew/brew) and [jq](https://github.com/stedolan/jq) are available.
If not it will install them.

If you would rather install them yourself just do it before running the script.

The script also relies on bash existing.
