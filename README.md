# Drawing with Camel

Needed things
---
  * [Nix](https://nixos.org/nix/)

---
To [compile](https://ocaml.org/learn/tutorials/compiling_ocaml_projects.html) with required packages and modules:
```
$ ocamlfind ocamlopt -packages LIBRARY1,LIBRARY2 MODULE1.ml MODULE2.ml -linkpkg MAIN.ml -o MAIN
```

---
To load modules into the REPL on the fly:
```bash
$ ocamlc -c MODULE.ml
```
```utop
utop # #load "MODULE.cmo";;
utop # #use "MAIN.ml";;
```
