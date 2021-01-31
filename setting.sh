#!/bin/bash

ANSIBLE_PATH=~/workspace/settings/setup-mac
NODE_VERSION=14.15.4

## command line tools
xcode-select --install

## install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## install ansible
brew install ansible

## clone repo
git clone -b master https://github.com/akky-xxxx/setup-mac.git ${ANSIBLE_PATH}

## ansible
cd ${ANSIBLE_PATH}
ansible-playbook -i inventory/localhost localhost.yml

# use zsh
chsh /usr/bin/zsh

# install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

exec $SHELL -l

# install latest Node.js of LTS
nodebrew install-binary v${NODE_VERSION}
nodebrew use v${NODE_VERSION}

# install avn
npm innstall -g avn avn-nodebrew
avn setup
