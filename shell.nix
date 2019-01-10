{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "Cairo";
    buildInputs = [ ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.cairo2
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.ocp-indent
                    ocaml-ng.ocamlPackages_4_07.utop
                    python36
                    python36Packages.matplotlib
                    python36Packages.numpy
                    python36Packages.flake8
                    fzf
                    tmux
                  ];
    shellHook = ''
        strcd() { cd "$(dirname $1)"; }
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }

        alias cdfzf="withfzf strcd"
        alias vimfzf="withfzf vim"
        alias flake8="flake8 --ignore E124,E128,E201,E203,E241,W503"

        export -f withfzf
    '';
}
