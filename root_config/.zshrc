##### OH-MY-ZSH #####
export ZSH="$HOME/.oh-my-zsh"
export LC_CTYPE=en_US.UTF-8

ZSH_THEME=""
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  autojump
  git-prompt
)

##### PROMPT #####
setopt PROMPT_SUBST
PROMPT="(%n@%m) %3~
%F{blue}>%f "

source $ZSH/oh-my-zsh.sh

##### KEYS #####
[ -f ~/.keys ] && source ~/.keys

##### ALIAS #####
alias ls="eza"
alias ll="eza -lhF"
alias lla="eza -alhF"
alias lt="eza -lhTF"
alias lta="eza -alhTF"
alias nn="nvim -c 'lua require(\"utils.new_note\").new_note()'"
alias ipy="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

##### Configuration File Shortcuts #####
alias zshss="nvim $HOME/.zshrc"
alias alacss="nvim $HOME/.config/alacritty/alacritty.toml"
alias kittyss="nvim $HOME/.config/kitty/kitty.conf"
alias wezss="nvim $HOME/.config/wezterm/wezterm.lua"
alias tmuxss="nvim $HOME/.tmux.conf"
alias vimss="nvim $HOME/.config/nvim/init.lua"
alias gitss="nvim $HOME/.gitconfig"
alias ghosttyss="nvim $HOME/.config/ghostty/config"

##### TMUX ALIAS #####
alias tmux="env TERM=tmux-256color tmux" # tmux with certain terminfo
alias tls="tmux ls"
alias tn="tmux new -s"
alias ta="tmux source ~/.tmux.conf && tmux a -t"
alias tk="tmux kill-session -t"

##### NEOVIM ALIAS #####
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"

##### GIT ALIAS #####
alias gitlog="git log --oneline --graph --all"

##### NEOVIM EDITOR #####
export EDITOR=nvim

if [[ "$OS" == "mac" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"

  alias obsidian="nvim ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian"

  #### Oracle AILAS ####
  alias ostart="oci compute instance action --action START --instance-id ocid1.instance.oc1.us-chicago-1.anxxeljrqbo6i4icbcfgambxtakvjg5o7opueq3m2zwcd2b6ozi4hiczfpgq"
  alias ostop="oci compute instance action --action STOP --instance-id ocid1.instance.oc1.us-chicago-1.anxxeljrqbo6i4icbcfgambxtakvjg5o7opueq3m2zwcd2b6ozi4hiczfpgq"
fi

if [[ "$OS" == "linux" ]]; then
  alias nvim="$HOME/nvim-linux-arm64.appimage"
fi
