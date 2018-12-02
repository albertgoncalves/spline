#!/usr/bin/env bash

cd src

ocamlfind ocamlopt \
    -package cairo2 \
        ~/Projects/spline/src/drawing.ml \
        ~/Projects/spline/src/helpers.ml \
        ~/Projects/spline/src/deboor.ml \
    -linkpkg spline.ml -o spline
./spline
open spline.png
