function fkill --description "Fuzzy find a program and kill it"
  ps -e --format pid,comm,args | fzf --header-lines=1 | awk '{print $1}' | xargs -r kill
end
