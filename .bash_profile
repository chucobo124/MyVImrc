export VIMINIT='source $MYVIMRC'
export MYVIMRC='~/.vim/vimrc' 

eval "$(rbenv init -)"

export PATH="$HOME/.bin:$PATH"

export HOMEBREW_PREFIX="/usr/local"

# recommended by brew doctor
export PATH="/usr/local/opt/python@2/bin:/usr/local/bin:$PATH"
# terminal color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
PS1="\[\033[32m\]\h \[\033[35m\]\w$ \[\033[37m\]"
# Add go path
export GOPATH=$HOME/go
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export PATH="$HOME/.gotools:$PATH"
export PROTOBUF_PREFIX=$(brew --prefix protobuf)
export MONETIZEPATH=$GOPATH/src/github.com/carousell/monetize
export PATH="$PATH:$MONETIZEPATH/commons/tools"
alias django="cd /Users/lucaschen/WorkingSpace/carousell-compose/Carousell-Django"
alias gorepo="cd $GOPATH/src/github.com/carousell"
alias work="cd /Users/lucaschen/WorkingSpace"
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

_ssh() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/lucaschen/Documents/google-cloud-sdk/path.bash.inc' ]; then source '/Users/lucaschen/Documents/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/lucaschen/Documents/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/lucaschen/Documents/google-cloud-sdk/completion.bash.inc'; fi

# Better Json formate
 alias json="python -mjson.tool"
 alias xml="xmllint --format -"

# Git Branch Display
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
txtyel="\[\033[33m\]"
txtgrn="\[\033[32m\]"
txtcyn="\[\033[36m\]"
txtrst="\[\033[0m\]"
export PS1="\[$txtyel\]\u@\h \[$txtgrn\]\W\[$txtcyn\]\$(parse_git_branch) \[$txtrst\]\$ "
