#!/usr/bin/env bash

cd src

for f in generators helpers drawing deboor; do
    ocamlfind ocamlc -c $f.ml -package cairo2
done

ocamlfind ocamlopt \
    -package cairo2 generators.ml helpers.ml drawing.ml deboor.ml \
    -linkpkg $1.ml -o $1
./$1
open ../output/$1.png
