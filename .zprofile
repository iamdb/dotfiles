#!/bin/zsh
[[ -f ~/.config/user-dirs.dirs ]] && source ~/.config/user-dirs.dirs
[[ -f ~/.config/zsh/.zshenv ]] && source ~/.config/zsh/.zshenv

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
fi
