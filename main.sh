#!/usr/bin/env bash

set -e

cd src

ocamlfind ocamlopt \
    -package cairo2 \
    -linkpkg generators.ml helpers.ml drawing.ml deboor.ml $1.ml \
    -o $1
./$1

output=../out/$1.png

if [ $(uname -s) = "Darwin" ]; then
    open $output
else
    xdg-open $output
fi
