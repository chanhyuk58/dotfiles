##### SHELL ALIAS #####
alias ll="ls -lthOF"
alias lla="ls -AlthOF"
alias obsidian="nvim ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian"
alias ipy="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

##### SKIM #####
manp()
{
  man -t "${1}" | open -f -a Skim
}
catskim()
{
  cat "${1}" | enscript -p - | open -f -a Skim
}
##### Configuration File Shortcuts #####
alias zshss="nvim ~/.zshrc"
alias alacss="nvim ~/.config/alacritty/alacritty.toml"
alias kittyss="nvim ~/.config/kitty/kitty.conf"
alias wezss="nvim ~/.config/wezterm/wezterm.lua"
alias tmuxss="nvim ~/.tmux.conf"
alias vimss="nvim ~/.config/nvim/init.vim"
alias gitss="nvim ~/.gitconfig"

##### TMUX ALIAS #####
# alias tmux="env TERM=tmux-256color tmux" # tmux with certain terminfo
alias tls="tmux ls"
alias tn="tmux new -s"
alias ta="tmux source ~/.tmux.conf && tmux a -t"
alias tk="tmux kill-session -t"

##### NEOVIM ALIAS #####
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"
alias bib="nvim -c ':Telescope bibtex'"
alias ff="nvim -c ':Telescope file_browser'"
alias nn="nvim -c ':lua new_note()'"

#### GIT ALIAS #####
# alias ginit="git init"
# alias gstatus="git status"
# alias gadd="git add"
# alias gcom="git commit -a"
alias gitlog="git log --oneline --graph --all"
# alias gremote="git remote"
# alias gradd="git remote add origin https://github.com/chanhyuk58/"
# alias gpull="git pull"
# alias gpush="git push"
# alias gdiff="git difftool HEAD HEAD^"
# alias gsta=""

##### START WITH VIM SESSION #####
vis() {
    nvim -S ~/.vim/session/$1 -c "source ~/.config/nvim/init.vim | noh"
}

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
# bindkey -v # vim keybinding on zsh

##### PROMPT #####
setopt PROMPT_SUBST # enable substitution in the prompt for the function output
PROMPT="(%n@%m) %3~
%F{blue}>%f "

##### Keys #####
source ~/.keys
