#!/usr/bin/env bash

ocamlc -c funs.ml
ocamlc -c tmp.ml
ocamlfind ocamlopt -package cairo2 tmp.ml funs.ml -linkpkg demo.ml -o demo
./demo
open demo.png
