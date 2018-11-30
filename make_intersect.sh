#!/usr/bin/env bash

ocamlfind ocamlopt -package cairo2 -linkpkg intersect.ml -o intersect
./intersect
open intersect.png
