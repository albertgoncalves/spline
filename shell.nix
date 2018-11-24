{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "python";
    buildInputs = [ python36
                    python36Packages.matplotlib
                    python36Packages.numpy
                    python36Packages.pylint
                    fzf
                    ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.cairo2
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.ocp-indent
                    ocaml-ng.ocamlPackages_4_07.utop
                    rlwrap
                    tmux
                  ];
    shellHook = ''
        pylin()    { pylint -s n $1; }
        strcd()    { cd "$(dirname $1)"; }
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }
        alias  cdfzf="withfzf strcd"
        alias pylfzf="withfzf pylin"
        alias runfzf="withfzf python3"
        alias vimfzf="withfzf vim"
        export -f pylin
        export -f withfzf
    '';
}
