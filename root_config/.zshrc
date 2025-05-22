##### PATH TO YOUR OH-MY-ZSH INSTALLATION #####
export ZSH="/Users/chanhyuk/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"

##### THEMES #####
ZSH_THEME=""
DISABLE_AUTO_TITLE="true"

##### PLUGINS #####
ENABLE_CORRECTION="true" # enable command auto-correction
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    autojump
    git-prompt
    )
source $ZSH/oh-my-zsh.sh

##### Keys #####
source ~/.keys

##### SHELL ALIAS #####
alias ls="eza"
alias ll="eza -lhF"
alias lla="eza -alhF"
alias lt="eza -lhTF"
alias lta="eza -alhTF"
# alias ll="ls -lthOF"
# alias lla="ls -AlthOF"
alias obsidian="nvim ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian"
alias nn="nvim -c ':lua new_note()'"
alias ipy="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

##### Configuration File Shortcuts #####
alias zshss="nvim ~/.zshrc"
alias alacss="nvim ~/.config/alacritty/alacritty.toml"
alias kittyss="nvim ~/.config/kitty/kitty.conf"
alias wezss="nvim ~/.config/wezterm/wezterm.lua"
alias tmuxss="nvim ~/.tmux.conf"
alias vimss="nvim ~/.config/nvim/init.vim"
alias gitss="nvim ~/.gitconfig"

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

#### GIT ALIAS #####
alias gitlog="git log --oneline --graph --all"

#### Oracle AILAS ####
alias ostart="oci compute instance action --action START --instance-id ocid1.instance.oc1.us-chicago-1.anxxeljrqbo6i4icbcfgambxtakvjg5o7opueq3m2zwcd2b6ozi4hiczfpgq"
alias ostop="oci compute instance action --action STOP --instance-id ocid1.instance.oc1.us-chicago-1.anxxeljrqbo6i4icbcfgambxtakvjg5o7opueq3m2zwcd2b6ozi4hiczfpgq"

##### START WITH VIM SESSION #####
vis() {
    nvim -S ~/.vim/session/$1 -c "source ~/.config/nvim/init.vim | noh"
}

# bindkey -v # vim keybinding on zsh

##### PROMPT #####
setopt PROMPT_SUBST # enable substitution in the prompt for the function output
PROMPT="(%n@%m) %3~
%F{blue}>%f "
