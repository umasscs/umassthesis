#!/bin/sh

NAME=umthesis
WHEREAMI=`cd $(dirname $0) && pwd -P`
echo $WHEREAMI
# exit 0

if [ -z "$(tex --version | head -1 | grep MacPorts)" ]; then
	echo "This installation scripts works only with"
	echo "MacPorts-installed TeXLive."
	exit 1
fi

YEAR="$(date '+%Y')"
TEXVAR="$HOME/.texlive${YEAR}/texmf-var"
LATEXDIR="$TEXVAR/tex/latex/$NAME"
BSTDIR="$TEXVAR/bibtex/bst/$NAME"

mkdir -p "$LATEXDIR" "$BSTDIR"

cd "$BSTDIR" && ln -s "$WHEREAMI"/*.bst .
cd "$LATEXDIR" && ln -s "$WHEREAMI"/*.cls "$WHEREAMI"/*.clo .

cd "$TEXVAR" && mktexlsr .
