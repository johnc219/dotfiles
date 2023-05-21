#!/bin/bash

dir=$(dirname $(realpath $0))

echo "regenerating installed packages"
pacman -Qe > installed_packages.txt

