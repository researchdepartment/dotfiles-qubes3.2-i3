#!/usr/bin/env bash

# Download lucy-tewi
git clone https://github.com/lucy/tewi-font
cd tewi-font
make
mv out/ ../tewi/
