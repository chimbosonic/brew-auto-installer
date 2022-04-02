#!/bin/bash

function usage() {
  echo "usage: $0 [flags]"
  echo "$0 installs tools found in a json file with Brew"
  echo "-f str    path to the json file that contains the list tools"
  echo "-u        force update existing tools (use with caution)"
  echo "-h        print usage of the tool"
}

upgrade=false
while getopts "huf:" opt; do
  case ${opt} in
  f)
    tool_list_path=${OPTARG}
    ;;
  u)
    upgrade=true
    ;;
  h)
    usage
    exit 0
    ;;
  \?)
    echo "Invalid option: -${OPTARG}" >&2
    usage
    exit 1
    ;;
  esac
done

function install_deps() {
  # Install brew if its missing
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Install jq if its missing
  if ! command -v jq &>/dev/null; then
    brew install jq
  fi
}

function install_tools() {
  for tool in $(cat tools.json | jq -c '.tools[]'); do
    tool_name=$(echo ${tool} | jq -r .name)
    tool_command=$(echo ${tool} | jq -r .command)
    tool_cask=$(echo ${tool} | jq -r .cask)
    if ! command -v ${tool_command} &>/dev/null || ${upgrade}; then
      echo "Installing ${tool_name}"
      brew_param="install ${tool_name}"
      if ${tool_cask}; then
        brew_param="install ${tool_name} --cask"
      fi
      brew ${brew_param}
    else
      echo "${tool_name} already available skipping"
    fi
  done
}

install_brew
install_tools

# Source: https://github.com/chimbosonic/brew-auto-installer
# MIT License

# Copyright (c) 2022 Alexis Lowe

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
