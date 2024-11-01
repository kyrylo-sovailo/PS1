#!/bin/sh

COLOR_FG_BLACK="\033[01;30m"
COLOR_FG_RED="\033[01;31m"
COLOR_FG_GREEN="\033[01;32m"
COLOR_FG_YELLOW="\033[01;33m"
COLOR_FG_BLUE="\033[01;34m"
COLOR_FG_MAGENTA="\033[01;35m"
COLOR_FG_CYAN="\033[01;36m"
COLOR_FG_WHITE="\033[01;37m"
COLOR_FG_BRIGHT_BLACK="\033[01;90m"
COLOR_FG_BRIGHT_RED="\033[01;91m"
COLOR_FG_BRIGHT_GREEN="\033[01;92m"
COLOR_FG_BRIGHT_YELLOW="\033[01;93m"
COLOR_FG_BRIGHT_BLUE="\033[01;94m"
COLOR_FG_BRIGHT_MAGENTA="\033[01;95m"
COLOR_FG_BRIGHT_CYAN="\033[01;96m"
COLOR_FG_BRIGHT_WHITE="\033[01;97m"
COLOR_FG_DEFAULT="\033[0m"

append_git_branch() {
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ $? == 0 ]; then
        printf "${COLOR_FG_YELLOW}${BRANCH}${COLOR_FG_BLUE} "
    fi
}

append_debian_git_branch() {
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ $? == 0 ]; then
        printf "${COLOR_FG_DEFAULT}:${COLOR_FG_YELLOW}${BRANCH}${COLOR_FG_BLUE}"
    fi
}

append_debian_root_git_branch() {
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ $? == 0 ]; then
        printf ":${BRANCH}"
    fi
}

PS1_STYLE="gentoo-git"
if [ "${PS1_STYLE}" == "gentoo" ]; then
    export PS1="${COLOR_FG_GREEN}\u@\h${COLOR_FG_BLUE} \w \$${COLOR_FG_DEFAULT} "
elif [ "${PS1_STYLE}" == "gentoo-root" ]; then
    export PS1="${COLOR_FG_RED}\h${COLOR_FG_BLUE} \w \$${COLOR_FG_DEFAULT} "
elif [ "${PS1_STYLE}" == "gentoo-git" ]; then
    export PS1="${COLOR_FG_GREEN}\u@\h${COLOR_FG_BLUE} \w "'$(append_git_branch)'"\$${COLOR_FG_DEFAULT} "
elif [ "${PS1_STYLE}" == "gentoo-root-git" ]; then
    export PS1="${COLOR_FG_RED}\h${COLOR_FG_BLUE} \w "'$(append_git_branch)'"\$${COLOR_FG_DEFAULT} "
elif [ "${PS1_STYLE}" == "debian" ]; then
    export PS1="${COLOR_FG_GREEN}\u@\h${COLOR_FG_DEFAULT}:${COLOR_FG_BLUE}\w${COLOR_FG_DEFAULT}\$ "
elif [ "${PS1_STYLE}" == "debian-root" ]; then
    export PS1="\u@\h:\w\$ "
elif [ "${PS1_STYLE}" == "debian-git" ]; then
    export PS1="${COLOR_FG_GREEN}\u@\h${COLOR_FG_DEFAULT}:${COLOR_FG_BLUE}\w"'$(append_debian_git_branch)'"${COLOR_FG_DEFAULT}\$ "
elif [ "${PS1_STYLE}" == "debian-root-git" ]; then
    export PS1="\u@\h:\w"'$(append_debian_root_git_branch)'"\$ "
else
    export PS1="\u@\h:\w\$ "
fi
