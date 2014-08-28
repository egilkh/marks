# marks

Create marks around your file system and easily jump around.
The marks are stored as (sym) links in the $MARKPATH directory ($HOME/.marks).

Based/stolen from:
http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html

## Usage

Source the file: `source marks.sh` and your should be ready to use it.

    jump FOO
      jump to a mark named FOO or list all marks (no argument)
    mark FOO
      create a mark named FOO
    unmark FOO
      delete a mark
    marks
      lists all marks
