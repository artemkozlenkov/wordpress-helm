#!/bin/bash -e

#copy-paste in terminal

sudo mkdir challenge
sudo tar -zxvf challenge.tar.gz -C challenge

sudo chown -R $USER:$USER ./challenge
