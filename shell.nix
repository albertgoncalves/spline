{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "Cairo";
    buildInputs = [
        (with ocaml-ng.ocamlPackages_4_07; [
            ocaml
            cairo2
            findlib
            ocp-indent
            utop
        ])
        (python37.withPackages(ps: with ps; [
            matplotlib
            numpy
            flake8
        ]))
        fzf
        tmux
    ];
    shellHook = ''
        if [ $(uname -s) = "Darwin" ]; then
            alias ls='ls --color=auto'
            alias ll='ls -al'
        fi

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
