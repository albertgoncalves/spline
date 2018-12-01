#!/usr/bin/env bash

ocamlfind ocamlopt -package cairo2 -linkpkg margin.ml -o margin
./margin
open margin.png
