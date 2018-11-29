#!/usr/bin/env bash

ocamlfind ocamlopt -package cairo2 tmp.ml funs.ml -linkpkg demo.ml -o demo
./demo
open demo.png
