# Drawing with the Caml

![](cover.png)

Needed things
---
  * [Nix](https://nixos.org/nix/)

Quick start
---
```bash
$ nix-shell
[nix-shell:path/to/spline]$ sh main.sh [spline|word|sentence]
```

Otherwise
---
To [compile](https://ocaml.org/learn/tutorials/compiling_ocaml_projects.html) with required packages and modules:
```
[nix-shell:path/to/spline]$ ocamlfind ocamlopt -package LIBRARY1,LIBRARY2 -linkpkg MODULE1.ml MODULE2.ml MAIN.ml -o MAIN
```

---
To load these things into the REPL on the fly:
```bash
[nix-shell:path/to/spline]$ ocamlc -c MODULE.ml
```
```utop
utop # #use "topfind";;
utop # #require "LIBRARY";;
utop # #load "MODULE.cmo";;
utop # #use "MAIN.ml";;
```
