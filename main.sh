#!/usr/bin/env bash

cd src

ocamlfind ocamlopt \
    -package cairo2 \
        ~/Projects/spline/src/drawing.ml \
        ~/Projects/spline/src/helpers.ml \
        ~/Projects/spline/src/deboor.ml \
    -linkpkg $1.ml -o $1
./$1
open ~/Projects/spline/output/$1.png
