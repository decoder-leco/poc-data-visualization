#!/bin/bash

export PATH="$PATH:$HOME/.cargo/bin"

pwd

cargo --version

# jupyter notebook --unstable
jupyter notebook --ip 0.0.0.0 --allow-root