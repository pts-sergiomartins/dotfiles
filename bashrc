# My stuff

function parse_git_dirty {
  output=$(git status --porcelain 2> /dev/null)
  echo "$output" | grep -q -e "^ *D" && echo -n "-"
  echo "$output" | grep -q -e "^ *M" -e "^ *R" && echo -n "*"
  echo "$output" | grep -q -e "^ *A" && echo -n "+"
}
function parse_git_stash {
  [[ $(git stash list 2> /dev/null | tail -n1) != "" ]] && echo "^"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty)$(parse_git_stash))/"
}

# export PS1='${debian_chroot:+($debian_chroot)}\u:\w$(parse_git_branch)\$ '
export PS1='\[\e]0;\u: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\$ '

# Docker stuff
alias dstop="docker ps -q | xargs docker stop"
alias dps="docker ps -q | head -n1"
alias dx='docker exec -it $(dps) /bin/bash'
alias dimg="docker images | head -n 2 | tail -n 1 | awk '{print \$3}'"

# git stuff
alias glog='git log --graph --color --decorate'
alias glof="git log --color --all --date-order --decorate --dirstat=lines,cumulative --stat | sed 's/\([0-9] file[s]\? .*)$\)/\1\n_______\n-------/g' | less -R"
alias com='git checkout master'
alias gl='git pull --ff-only'
alias gp='git push'
alias upush='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias rmb='git remote prune origin && git branch | grep -v -e "master" -e "*"| xargs -L 1 git branch -d'

# Development stuff
export CHROME_BIN=/usr/lib/chromium-browser/chromium-browser
export EDITOR=vim
alias pe='pipenv'
alias eform='black -l 120 *.py'
alias uj='echo -n $1 > /home/sergio.martins/.config/autokey/data/Day-to-day/jcode.txt'

# Misc stuff
alias vash='vim ~/.bashrc'
alias ethip='ip a | grep -e enp -e enx | awk "/inet /{print $2}" | cut -d/ -f1'
alias count_files_in_dirs='for x in $(ls); do echo ${x}: $(find "${x}" -type f | wc -l); done'
alias rm_nodemodules='find . -maxdepth 2 -name "node_modules" -type d -exec rm -rf "{}" \;'
alias valt='vagrant halt'
alias uv='nmcli c up vpn'
alias dv='nmcli c down vpn'
alias n='nmcli'

