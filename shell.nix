{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "python";
    buildInputs = [ python36
                    python36Packages.matplotlib
                    python36Packages.numpy
                    python36Packages.pylint
                    fzf
                    tmux
                  ];
    shellHook = ''
        copyfile() { cat $1 | pbcopy; }
        pylin()    { pylint -s n $1; }
        strcd()    { cd "$(dirname $1)"; }
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }
        alias cpyfzf="withfzf copyfile"
        alias  cdfzf="withfzf strcd"
        alias pylfzf="withfzf pylin"
        alias runfzf="withfzf python3"
        alias vimfzf="withfzf vim"
        export -f copyfile
        export -f pylin
        export -f withfzf
    '';
}
