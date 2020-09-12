# ==================================================================
#       S. Thewessen
#       Personal: ~/.bash_aliases

#       Last modified: Fri 25 Jan 2019
# ==================================================================

# =================================
#             General
# =================================

alias c='clear' # Clear the screen
alias j='jobs' # Current running jobs

# =================================
#            History
# =================================

alias h='history' # Bash history

# a history grep function
hg() {
    # Make sure a whitespace excludes a command from history
    if [ -z "$HISTCONTROL" ]; then
        echo "Adding \$HISTCONTROL=ignoreboth\n"
        HISTCONTROL=ignoreboth
    fi
    history | grep $1
}

# =================================
#  Show all 256 colors in terminal
# =================================

colors256() {
    for i in {0..255}; do 
        printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"; 
    done
}

# =================================
#          System-Monitor
# =================================

# Watch the current temps of core and fanspeed. Usefull for stresstesting.
#alias wtch='watch -t -n1 "(lscpu | grep MHz | cut -c '"'"'1-10 19-31'"'"') && echo && (sensors | grep Core | cut -c 1-25) && echo && (sensors | grep fan | cut -c '"'"'1-5 14-31'"'"') && echo && (free -m | grep '"'"'total\|Mem\|Swap'"'"' | cut -c 1-40) && echo && (df -h | grep '"'"'Filesystem\|sdb8\|sda1'"'"')"' 
alias wtch='watch -t -n1 "printf '"'"'GPU MHz:       '"'"' && (nvidia-settings -tq GPUCurrentClockFreqs | head -1) && echo && ((printf '"'"'GPU Temp:      +\c'"'"' && nvidia-settings -tq GPUCoreTemp) | head -1) && printf '"'"'.0°C'"'"' && echo && (lscpu | grep MHz | cut -c '"'"'1-10 19-31'"'"') && echo && (sensors | grep Core | cut -c 1-25) && echo && (sensors | grep fan | cut -c '"'"'1-5 14-31'"'"') && echo && (free -m | grep '"'"'total\|Mem\|Swap'"'"' | cut -c 1-40) && echo && (df -h | grep '"'"'Filesystem\|sdb8\|sda1'"'"')"'
