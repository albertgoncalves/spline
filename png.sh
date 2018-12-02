#!/usr/bin/env bash

ocamlfind ocamlopt \
    -package cairo2 \
        ~/Projects/spline/drawing.ml \
        ~/Projects/spline/helpers.ml \
        ~/Projects/spline/deboor.ml \
    -linkpkg $1.ml -o $1
./$1
open $1.png
