# custom prompt
export CLICOLOR=1
export LSCOLORS=dxFxCxDxBxegedabagacad

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# remove the right prompt after command execution
setopt TRANSIENT_RPROMPT

# Use wildcard in history search
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

# Use zman for the manualpage of zsh and search
zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Path to dotfiles bin
PATH="$PATH:$HOME/bin"
# Path to cargo bin
PATH="$PATH:$HOME/.cargo/bin"
#path to python packages bin
PATH="$PATH:$HOME/.local/bin"
#path to ruby gem packages bin
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"

# Default browser
export BROWSER="firefox"

# Some (nicer) dircolors
export LS_COLORS='rs=0:di=00;33:ln=01;36:mh=00:pi=00;34:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=01;31:mi=00:su=00;37:sg=00;37:ca=00;37:ex=04;37:*.sh=01;32:*.SH=01;32:*.csh=01;32:*.CSH=01;32:*.zsh=01;32:*.ZSH=01;32:*.tar=01;33:*.TAR=01;33:*.tgz=01;33:*.TGZ=01;33:*.arc=01;33:*.ARC=01;33:*.arj=01;33:*.ARJ=01;33:*.taz=01;33:*.TAZ=01;33:*.lha=01;33:*.LHA=01;33:*.lz4=01;33:*.LZ4=01;33:*.lzh=01;33:*.LZH=01;33:*.lzma=01;33:*.LZMA=01;33:*.tlz=01;33:*.TLZ=01;33:*.txz=01;33:*.TXZ=01;33:*.tzo=01;33:*.TZO=01;33:*.t7z=01;33:*.T7Z=01;33:*.zip=01;33:*.ZIP=01;33:*.z=01;33:*.Z=01;33:*.Z=01;33:*.z=01;33:*.dz=01;33:*.DZ=01;33:*.gz=01;33:*.GZ=01;33:*.lrz=01;33:*.LRZ=01;33:*.lz=01;33:*.LZ=01;33:*.lzo=01;33:*.LZO=01;33:*.xz=01;33:*.XZ=01;33:*.zst=01;33:*.ZST=01;33:*.tzst=01;33:*.TZST=01;33:*.bz2=01;33:*.BZ2=01;33:*.bz=01;33:*.BZ=01;33:*.tbz=01;33:*.TBZ=01;33:*.tbz2=01;33:*.TBZ2=01;33:*.tz=01;33:*.TZ=01;33:*.deb=01;33:*.DEB=01;33:*.rpm=01;33:*.RPM=01;33:*.jar=01;33:*.JAR=01;33:*.war=01;33:*.WAR=01;33:*.ear=01;33:*.EAR=01;33:*.sar=01;33:*.SAR=01;33:*.rar=01;33:*.RAR=01;33:*.alz=01;33:*.ALZ=01;33:*.ace=01;33:*.ACE=01;33:*.zoo=01;33:*.ZOO=01;33:*.cpio=01;33:*.CPIO=01;33:*.7z=01;33:*.7Z=01;33:*.rz=01;33:*.RZ=01;33:*.cab=01;33:*.CAB=01;33:*.wim=01;33:*.WIM=01;33:*.swm=01;33:*.SWM=01;33:*.dwm=01;33:*.DWM=01;33:*.esd=01;33:*.ESD=01;33:*.jpg=01;35:*.JPG=01;35:*.jpeg=01;35:*.JPEG=01;35:*.mjpg=01;35:*.MJPG=01;35:*.mjpeg=01;35:*.MJPEG=01;35:*.gif=01;35:*.GIF=01;35:*.bmp=01;35:*.BMP=01;35:*.pbm=01;35:*.PBM=01;35:*.pgm=01;35:*.PGM=01;35:*.ppm=01;35:*.PPM=01;35:*.tga=01;35:*.TGA=01;35:*.xbm=01;35:*.XBM=01;35:*.xpm=01;35:*.XPM=01;35:*.tif=01;35:*.TIF=01;35:*.tiff=01;35:*.TIFF=01;35:*.png=01;35:*.PNG=01;35:*.svg=01;35:*.SVG=01;35:*.svgz=01;35:*.SVGZ=01;35:*.mng=01;35:*.MNG=01;35:*.pcx=01;35:*.PCX=01;35:*.mov=01;35:*.MOV=01;35:*.mpg=01;35:*.MPG=01;35:*.mpeg=01;35:*.MPEG=01;35:*.m2v=01;35:*.M2V=01;35:*.mkv=01;35:*.MKV=01;35:*.webm=01;35:*.WEBM=01;35:*.ogm=01;35:*.OGM=01;35:*.mp4=01;35:*.MP4=01;35:*.m4v=01;35:*.M4V=01;35:*.mp4v=01;35:*.MP4V=01;35:*.vob=01;35:*.VOB=01;35:*.qt=01;35:*.QT=01;35:*.nuv=01;35:*.NUV=01;35:*.wmv=01;35:*.WMV=01;35:*.asf=01;35:*.ASF=01;35:*.rm=01;35:*.RM=01;35:*.rmvb=01;35:*.RMVB=01;35:*.flc=01;35:*.FLC=01;35:*.avi=01;35:*.AVI=01;35:*.fli=01;35:*.FLI=01;35:*.flv=01;35:*.FLV=01;35:*.gl=01;35:*.GL=01;35:*.dl=01;35:*.DL=01;35:*.xcf=01;35:*.XCF=01;35:*.xwd=01;35:*.XWD=01;35:*.yuv=01;35:*.YUV=01;35:*.cgm=01;35:*.CGM=01;35:*.emf=01;35:*.EMF=01;35:*.3gp=01;35:*.3GP=01;35:*.heic=01;35:*.HEIC=01;35:*.ogv=01;35:*.OGV=01;35:*.ogx=01;35:*.OGX=01;35:*.aac=00;36:*.AAC=00;36:*.au=00;36:*.AU=00;36:*.flac=00;36:*.FLAC=00;36:*.m4a=00;36:*.M4A=00;36:*.mid=00;36:*.MID=00;36:*.midi=00;36:*.MIDI=00;36:*.mka=00;36:*.MKA=00;36:*.mp3=00;36:*.MP3=00;36:*.mpc=00;36:*.MPC=00;36:*.ogg=00;36:*.OGG=00;36:*.ra=00;36:*.RA=00;36:*.wav=00;36:*.WAV=00;36:*.oga=00;36:*.OGA=00;36:*.opus=00;36:*.OPUS=00;36:*.spx=00;36:*.SPX=00;36:*.xspf=00;36:*.XSPF=00;36:*.dvi=00;31:*.DVI=00;31:*.pdf=00;31:*.PDF=00;31:*.ppt=00;31:*.PPT=00;31:*.pptx=00;31:*.PPTX=00;31:*.doc=01;34:*.DOC=01;34:*.docx=01;34:*.DOCX=01;34:*.odt=01;34:*.ODT=01;34:*.ott=01;34:*.OTT=01;34:*.ods=00;32:*.ODS=00;32:*.xls=00;32:*.XLS=00;32:*.xlsm=00;32:*.XLSM=00;32:';

# Use the dir stack!
setopt autopushd pushdminus pushdsilent pushdtohome
DIRSTACKSIZE=11

# Keep the dirstack saved
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

# term colors
# export COLOR_MODE=light

# Add some aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
elif [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# compinit configs
[ -f ~/.zsh.compinit ] && source ~/.zsh.compinit

# autoload functions found in .zsh_functions
if [ -d ${ZDOTDIR:-~}/.zsh_functions ] && [ ${ZDOTDIR:-~}/.zsh_functions/.(NF) ]
then
  fpath+=${ZDOTDIR:-~}/.zsh_functions
  autoload -U ${ZDOTDIR:-~}/.zsh_functions/*(.:t)
fi

# Use bat as the default command for piping
if type bat >/dev/null; then
  NULLCMD=bat 
  READNULLCMD=bat
fi
