#!/usr/bin/env bash

ocamlfind ocamlopt -package cairo2 funs.ml -linkpkg $1.ml -o $1
./$1
open $1.png
