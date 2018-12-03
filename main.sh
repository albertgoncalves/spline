#!/usr/bin/env bash

cd src

ocamlfind ocamlopt \
    -package cairo2 generators.ml helpers.ml drawing.ml deboor.ml \
    -linkpkg $1.ml -o $1
./$1
open ../output/$1.png
