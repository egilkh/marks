# marks.sh
#
# Based/stolen from:
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
#
# Done some minor things to clean up/fix to work in my shell.
#
# jump FOO: jump to a mark named FOO or list all marks (no argument)
# mark FOO: create a mark named FOO
# unmark FOO: delete a mark
# marks: lists all marks

# Set where to save the marks.
export MARKPATH=$HOME/.marks

function jump {
  # If no jump is given: output all marks.
  if [ -z $1 ]; then
    marks
    return
  fi

  # Jump to folder.
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

# Create a mark for "pwd/$1".
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

# Reamove a mark.
function unmark {
    rm -i "$MARKPATH/$1"
}

# Linux function.
function marks {
  \ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# OS X function.
if [ $(uname) == "Darwin" ]; then
  function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
  }
fi

# Bash completion.
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -exec basename {} \;)
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

# Add auto complete for jump and unmark
complete -F _completemarks jump unmark
