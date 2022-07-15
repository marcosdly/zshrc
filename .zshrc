# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
# .zshrc config by marcosdly.
# Check marcosdly/dotfiles on GitHub.

# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=10000
# bindkey -v
# End of lines configured by zsh-newuser-install

# |=====================|
#     Setting prompt
# |=====================|

autoload -Uz promptinit && promptinit
autoload -U add-zsh-hook
setopt prompt_subst

# Define the theme
prompt_nothing_setup() {
  NT_PROMPT_SYMBOL="->"

  if [[ "$NT_HIDE_COUNT" == '1' ]]; then
  	command_count=''
  else
  	command_count="%F{gray}%i %f"
  fi

  PROMPT='${command_count}%(?.%F{green}${NT_PROMPT_SYMBOL}%f.%F{red}${NT_PROMPT_SYMBOL}%f) '

  if [[ "$NT_HIDE_EXIT_CODE" == '1' ]]; then
  	RPROMPT=''
  else
  	RPROMPT='%(?..%F{red}%B%S  $?  %s%b%f)'
  fi
}

# Add the theme to promptsys
prompt_themes+=( nothing )

# Load the theme
prompt nothing

# |=====================|
#       Completion
# |=====================|

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# |=====================|
#         Aliases
# |=====================|

alias ls="ls --color"
alias v="vim"

# |=====================|
#      Key bindings
# |=====================|

bindkey  "^[[H"    beginning-of-line  # Fix Home key
bindkey  "^[[F"    end-of-line        # Fix End key
bindkey  "^[[3~"   delete-char        # Fix Delete key
bindkey  "^H"      backward-kill-word # Delete word backwards
bindkey  "^[[3;5~" kill-word          # Delete word forward
bindkey "^[[1;5C"  forward-word       # Move to next word
bindkey "^[[1;5D"  backward-word      # Move to previous word

# |=====================|
#          Hooks
# |=====================|

# None at the moment

# |=====================|
#         Plugins
# |=====================|

source $HOME/.zplugins/zsh-nvm/zsh-nvm.plugin.zsh
source $HOME/.zplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source $HOME/.zplugins/zshrc/zshrc.plugin.zsh
# source $HOME/.zplugins/setenv/setenv.plugin.zsh
source $HOME/.zplugins/zsh-auto-notify/auto-notify.plugin.zsh
source $HOME/.zplugins/zsh-sudo/sudo.plugin.zsh

# |=====================|
#    Plugins' configs
# |=====================|

# zsh-auto-notify configuration
export AUTO_NOTIFY_THRESHOLD=10
export AUTO_NOTIFY_TITLE="\"%command\" has just finished running."
export AUTO_NOTIFY_BODY="(Total time: %elapsed) (Exit code: %exit_code)"

# |=====================|
#         Others
# |=====================|

# None, for now
