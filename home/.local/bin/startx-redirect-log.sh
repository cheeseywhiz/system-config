#!/bin/bash
# prompt for password before opening tty
sudo true
cd
startx |& sudo tee /dev/tty7 > /dev/null
