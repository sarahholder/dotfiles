alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

## EASY ADD ALIASES
## ex. `add-alias spv "spotify vol"` will be `alias spv="spotify vol"` in zsh file
add-alias() {
  # you can specify a 3rd arg as new location in ~/.dotfiles if you so desire
  DEFAULT=$HOME/.dotfiles/aliases/aliases.symlink
  echo "alias $1=\"$2\"" >>${3:-$DEFAULT}
  source ~/.zshrc
}
