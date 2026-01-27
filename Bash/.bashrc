#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias refreshScreen='~/.config/hypr/scripts/monitor-switch.sh'
alias proxyon='export HTTP_PROXY=http://127.0.0.1:2080 HTTPS_PROXY=http://127.0.0.1:2080 ALL_PROXY=socks5://127.0.0.1:2080'
alias proxyoff='unset HTTP_PROXY HTTPS_PROXY ALL_PROXY'
PS1='[\u@\h \W]\$ '

export EDITOR='nvim'
alias vim='nvim'
alias vi='nvim'
export PATH="$HOME/.local/bin:$PATH"

winboot() {
    sudo grub-reboot "Windows Boot Manager (on /dev/nvme0n1p1)"
    sudo reboot
}
