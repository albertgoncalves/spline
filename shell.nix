{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "spline";
    buildInputs = [ ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.cairo2
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.ocp-indent
                    ocaml-ng.ocamlPackages_4_07.utop
                    python36
                    python36Packages.matplotlib
                    python36Packages.numpy
                    python36Packages.pylint
                    fzf
                    tmux
                    vim
                  ];
    shellHook = ''
        pylin() { pylint -s n $1; }
        strcd() { cd "$(dirname $1)"; }
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }
        alias  cdfzf="withfzf strcd"
        alias vimfzf="withfzf vim"
        export -f pylin
        export -f withfzf
    '';
}
