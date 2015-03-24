# umassthesis
a LaTeX2e class file for preparing doctoral dissertations or dissertation proposals
in the required form for submission to the University of Massachusetts Graduate School.

## Quick Start
To add the required files to your tex environment, run the installer:

    ./install.sh
    
If you want to use [LyX](http://www.lyx.org/), copy the layout file after installing the class files:

    cp lyx/umassthesis.layout ~/.lyx/layouts/

Once installed, you should be able to work with the example files in `example/`:

    cd example/
    # Compile with pdflatex + bibtex:
    pdflatex umthsmpl
    bibtex umthsmpl
    pdflatex umthsmpl
    # Edit with LyX:
    lyx umthsmpl.lyx

## Class Options
**umassthesis** is based on the LaTeX2e report class and accepts all of the options of that class.
It also introduces several new ones:

* `doublespace` -- the default, indicates double spacing as per U.Mass.
  requirements. You will need this when you do your final copy.
* `singlespace` -- for earlier work, not acceptable to the Grad school.
* `condensed` -- for earlier work, not acceptable to the Grad school, creates
  condensed versions of the frontmatter. Condensed implies singlespace.
* `uncondensed` -- the default.
* `dissertation` -- the default, indicates that this document is a dissertation.
* `thesis` -- indicates that this document is a Master's thesis rather than a
  dissertation.
* `proposal` -- indicates that this document is a thesis or dissertation
  proposal, rather than a thesis or dissertation. This will only change the
  wording on the title and signature pages.
* `allowlisthypenation` -- (the default), allows hyphenation of words in the
  table of contents, the list of figures, and the list of tables. Believed
  to be acceptable to the Graduate School.
* `nolisthyphenation` -- disallows hyphenation of words in the table of contents
  and the list of figures and tables. Use this option if the Grad School
  doesn't like your hyphenation.
* `nicerdraft` -- relaxes some of the Grad School's rules for working with
  drafts; has no effect when doublespace is in effect
* `nonicerdraft` -- the default, leaves things in draft as they will be in the
  final version

This class adds the following commands and environments to the report class,
upon which it is based:

* `\degree{name}{abbrv}` -- Sets the name and abbreviation for the degree. These
  default to "Doctor of Philosopy" and "Ph.D.", respectively.
* `\copyrightyear{year}` -- for the copyright page.
* `\bachelors{degree}{institution}` -- for the abstract
* `\masters{degree}{institution}` -- for the abstract
* if you have other degrees you may use
  * `\secondbachelors{degree}{institution}`
  * `\thirdbachelors{degree}{institution}`
  * `\secondmasters{degree}{institution}`
  * `\thirdmasters{degree}{institution}`
  * `\priordoctorate{degree}{institution}`
* `\committeechair{name}` -- for the signature page
* or, if you have two co-chairs: `\cochairs{first name}{second name}`
* `\firstreader{name}` -- for the signature page
* `\secondreader{name}`
* `\thirdreader{name}`
* `\fourthreader{name}`
* `\fifthreader{name}`
* `\sixthreader{name}`
* `\departmentchair{name}` -- to use a different title than `Department Chair`, use `\departmentchair[title]{name}`.
* `\departmentname{name}`
* `\copyrightpage` -- produces the copyright page
* `\signaturepage` -- produces the signature page
* `\frontmatter` -- these are required in their various
* `\mainmatter` -- appropriate locations
* `\backmatter` --
* `\unnumberedchapter[toc]{name}` -- like `\chapter`, except that it produces an
  unnumbered chapter; alternatively, like `\chapter*`, except that it lists the
  chapter in the table of contents.

New environments:

* `dedication` -- for the dedication
* `abstract` -- for the abstract
* `frontispiece` -- for a decorative [frontispiece](http://en.wikipedia.org/wiki/Book_frontispiece)

## See also

[pdflatex-makefile](https://github.com/ransford/pdflatex-makefile), a succinct,
revision-control-aware Makefile for pdflatex documents.
