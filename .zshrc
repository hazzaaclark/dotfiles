# ----------------------------------
#   Copyright (C) HARRY CLARK 2023
#   ZSH CONFIG FOR LINUX DOTFILES
# ----------------------------------

# ----------------------------------
#   INITIALISE THE CACHE HOME DIR
# ----------------------------------

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10-instant-prompt-${(%):-%n}.zsh" ]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
