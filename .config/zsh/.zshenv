typeset -U path

export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
export FLYCTL_INSTALL="/home/iamdb/.config/fly"
export VOLTA_HOME="$HOME/.volta"

export OP_BIOMETRIC_UNLOCK_ENABLED=true
source /home/iamdb/.config/op/plugins.sh

[ -f "/home/iamdb/.local/share/ghcup/env" ] && source "/home/iamdb/.local/share/ghcup/env"

path=($ANDROID_HOME/emulator
      $ANDROID_HOME/tools
      $ANDROID_HOME/platform-tools
      /usr/local/go/bin
      $HOME/.local/bin
      $HOME/Code/go/bin
      /opt/flutter/bin
      $HOME/.local/share/gem/ruby/3.0.0/bin
      $HOME/.local/share/nvim/mason/bin
      $BUN_INSTALL/bin
      $FLYCTL_INSTALL/bin
      $HOME/.cargo/bin
      $VOLTA_HOME/bin
      $HOME/config/emacs/bin
      $path)

fpath=( $HOME/.config/zsh/site-functions/ "${fpath[@]}" )

export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

export EDITOR="nvim"
export BAT_THEME="1337"
export GOPATH=$HOME/Code/go

unset SSH_AGENT_PID

export SSH_AUTH_SOCK=~/.1password/agent.sock
export SSH_AUTH_SOCK_DEFAULT=~/.1password/agent.sock

export ANDROID_HOME=$HOME/Android/Sdk

export XSECURELOCK_PASSWORD_PROMPT=time_hex
export XSECURELOCK_SAVER=saver_blank

export WAKATIME_HOME=$HOME/.config/wakatime/

export GDK_SCALE=1.15
export GDK_DPI_SCALE=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1

export QUTE_QT_WRAPPER=PyQt6
