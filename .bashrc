PATH=~/scripts:$PATH
if [[ $- =~ "i" ]];
then
  HISTFILESIZE=1000000
  HISTSIZE=1000000
  shopt -s histappend
  HISTTIMEFORMAT='%F %T '
  alias gvim='gvim --remote-tab'
  alias ssha='ssh -A -C'
  alias sshr='ssh -l root'
  alias s=ssh_with_title
  alias vimhosts='sudo vim /etc/hosts'
  alias x509='openssl x509 -text -noout -in'
  # settings for nice vim
  export TERM=xterm-256color
  source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
  #add last RC
  export PSORIG=$PS1
  export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

  function __prompt_command() {
      
      local EXIT="$?"             # This needs to be first
      local RCol='\[\e[0m\]'

      local Red='\[\e[0;31m\]'
      local Gre='\[\e[0;32m\]'
      local BYel='\[\e[1;33m\]'
      local BBlu='\[\e[1;34m\]'
      local Pur='\[\e[0;35m\]'

      PS1="╓─${BYel}(`date +%H:%M`)${RCol}$PSORIG"
      if [ $EXIT != 0 ]; then
          PS1+="${Red}[$EXIT]${RCol}"      # Add red if exit code non 0
      fi
      PS1+="\n╙─: "
      title "$HOSTNAME: ${PWD/#$HOME/\~}"
  }
  # export string to the terminal label
  function title() {
      echo -ne "\033]0;$@\007"
  }
  function ssh_with_title() {
      title $1
      LANG=en_US.utf8 ssh -A -C -l root $@
  }
  function wttr()
  {
        # change Paris to your default location
            curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Prague}"
  }
  function ipython()
  {
    args="$*"
    python -i -c "`cat ~/.pythonstartup ${args%% *}`" ${args#* }
  }

  export PYTHONSTARTUP=$HOME/.pythonstartup
  export ANSIBLE_NOCOWS=1


  PERL_MB_OPT="--install_base \"/home/dosmanak/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=/home/dosmanak/perl5"; export PERL_MM_OPT;
fi
