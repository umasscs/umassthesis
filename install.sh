#!/bin/sh
set -e

NAME=umassthesis
WHEREAMI=`cd $(dirname $0) && pwd -P`

TEXVAR=${TEXMFVAR:-$(texconfig conf | grep TEXMFVAR | sed -e 's,.*=,,')}
if [ -n "$TEXVAR" ]; then
	echo "Will put symlinks in $TEXVAR (autodetected)"
else
	TEXVAR="$HOME/.texlive$(date '+%Y')/texmf-var"
	echo "WARNING: Could not autodetect \$TEXMFVAR; will put symlinks in default directory $TEXVAR" 1>&2
fi

LATEXDIR="$TEXVAR/tex/latex/$NAME"
BSTDIR="$TEXVAR/bibtex/bst/$NAME"

mkdir -p "$LATEXDIR" "$BSTDIR"

cd "$BSTDIR" && ln -fs "$WHEREAMI"/*.bst .
cd "$LATEXDIR" && ln -fs "$WHEREAMI"/*.cls "$WHEREAMI"/*.clo .

cd "$TEXVAR" && mktexlsr .
