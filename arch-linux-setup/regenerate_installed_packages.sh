#!/bin/bash

dir=$(dirname $(realpath $0))

echo "regenerating installed packages"
pacman -Qentq > installed_packages.txt

