#!/bin/sh

COLOR_FG_BLACK="\033[00;30m"
COLOR_FG_RED="\033[00;31m"
COLOR_FG_GREEN="\033[00;32m"
COLOR_FG_YELLOW="\033[00;33m"
COLOR_FG_BLUE="\033[00;34m"
COLOR_FG_MAGENTA="\033[00;35m"
COLOR_FG_CYAN="\033[00;36m"
COLOR_FG_WHITE="\033[00;37m"
COLOR_FG_BRIGHT_BLACK="\033[01;30m"
COLOR_FG_BRIGHT_RED="\033[01;31m"
COLOR_FG_BRIGHT_GREEN="\033[01;32m"
COLOR_FG_BRIGHT_YELLOW="\033[01;33m"
COLOR_FG_BRIGHT_BLUE="\033[01;34m"
COLOR_FG_BRIGHT_MAGENTA="\033[01;35m"
COLOR_FG_BRIGHT_CYAN="\033[01;36m"
COLOR_FG_BRIGHT_WHITE="\033[01;37m"
COLOR_FG_DEFAULT="\033[0m"

append_git_branch() {
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ $? == 0 ]; then
        printf "${COLOR_FG_BRIGHT_YELLOW}${BRANCH}${COLOR_FG_BRIGHT_BLUE} "
    fi
}

append_debian_git_branch() {
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ $? == 0 ]; then
        printf "${COLOR_FG_DEFAULT}:${COLOR_FG_BRIGHT_YELLOW}${BRANCH}${COLOR_FG_BRIGHT_BLUE}"
    fi
}

append_debian_root_git_branch() {
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ $? == 0 ]; then
        printf ":${BRANCH}"
    fi
}

PS1_STYLE="gentoo"
PS1_STYLE_ROOT="no"
PS1_STYLE_GIT="yes"

PS1_STYLE_ROOT=$(echo "${PS1_STYLE_ROOT}" | tr '[:upper:]' '[:lower:]')
if [ "${PS1_STYLE_ROOT}" == "1" -o "${PS1_STYLE_ROOT}" == "y" -o "${PS1_STYLE_ROOT}" == "yes" ]; then
    PS1_STYLE_ROOT="yes"
else
    PS1_STYLE_ROOT="no"
fi
PS1_STYLE_GIT=$(echo "${PS1_STYLE_GIT}" | tr '[:upper:]' '[:lower:]')
if [ "${PS1_STYLE_GIT}" == "1" -o "${PS1_STYLE_GIT}" == "y" -o "${PS1_STYLE_GIT}" == "yes" ]; then
    PS1_STYLE_GIT="yes"
else
    PS1_STYLE_GIT="no"
fi

if [ "${PS1_STYLE}" == "gentoo" ]; then
    if [ "${PS1_STYLE_ROOT}" == "no" -a "${PS1_STYLE_GIT}" == "no" ]; then
        export PS1="\[${COLOR_FG_BRIGHT_GREEN}\]\u@\h\[${COLOR_FG_BRIGHT_BLUE}\] \w \$\[${COLOR_FG_DEFAULT}\] "
    elif [ "${PS1_STYLE_ROOT}" == "yes" -a "${PS1_STYLE_GIT}" == "no" ]; then
        export PS1="${COLOR_FG_BRIGHT_RED}\h\[${COLOR_FG_BRIGHT_BLUE}\] \w \$\[${COLOR_FG_DEFAULT}\] "
    elif [ "${PS1_STYLE_ROOT}" == "no" -a "${PS1_STYLE_GIT}" == "yes" ]; then
        export -f append_git_branch
        export PS1="\[${COLOR_FG_BRIGHT_GREEN}\]\u@\h\[${COLOR_FG_BRIGHT_BLUE}\] \w "'$(append_git_branch)'"\$\[${COLOR_FG_DEFAULT}\] "
    else
        export -f append_git_branch
        export PS1="${COLOR_FG_BRIGHT_RED}\h\[${COLOR_FG_BRIGHT_BLUE}\] \w "'$(append_git_branch)'"\$\[${COLOR_FG_DEFAULT}\] "
    fi
elif [ "${PS1_STYLE}" == "debian" ]; then
    if [ "${PS1_STYLE_ROOT}" == "no" -a "${PS1_STYLE_GIT}" == "no" ]; then
        export PS1="\[${COLOR_FG_BRIGHT_GREEN}\]\u@\h\[${COLOR_FG_DEFAULT}\]:\[${COLOR_FG_BRIGHT_BLUE}\]\w\[${COLOR_FG_DEFAULT}\]\$ "
    elif [ "${PS1_STYLE_ROOT}" == "yes" -a "${PS1_STYLE_GIT}" == "no" ]; then
        export PS1="\u@\h:\w\$ "
    elif [ "${PS1_STYLE_ROOT}" == "no" -a "${PS1_STYLE_GIT}" == "yes" ]; then
        export -f append_debian_git_branch
        export PS1="\[${COLOR_FG_BRIGHT_GREEN}\]\u@\h\[${COLOR_FG_DEFAULT}\]:\[${COLOR_FG_BRIGHT_BLUE}\]\w"'$(append_debian_git_branch)'"\[${COLOR_FG_DEFAULT}\]\$ "
    else
        export -f append_debian_root_git_branch
        export PS1="\u@\h:\w"'$(append_debian_root_git_branch)'"\$ "
    fi
else
    export PS1="\u@\h:\w\$ "
fi
