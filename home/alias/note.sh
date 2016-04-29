echo "note : $note var : $var"
function asdf(){ sed 's/.Users.TP1/\~/g' }
project_directory="$notes_folder/projects/$(git_root)"
export notes_folder=$HOME/Sites/notes.local/
month=$(date +%m)
year=$(date +%Y)
export mf=$notes_folder/$year/$month # month folder
date=$(date +%Y-week-%V )
export daily=$mf/$date--daily.md
export daily_log=$mf/$date--daily-log.md
function open_firefox() { echo "\n  __open__ http://$1" |tee -a $n && open -a firefox "http://$1" }
alias of="open_firefox"
function en(){ echo $note && echo "\n  $* " | tee -a  $note }
function line_note() {wc -l $note  | awk {'print $1'} }
function date_note(){date +'%Y-%m-%d %H:%M'}
function tdn(){ echo $note && echo "__todo__    |  $*  | **status**  | **détails**   " | tee -a  $note }
function qn(){ echo $note && echo "__question__ |  $*  | **réponse**  | **détails**    " | tee -a  $note }
function hn(){ echo $note && history |tail -1 | tee -a  $note }
function resume_header() { echo '#  | type     | in             | out | comentaire \n---|----------|----------------------|--------|------' }
function resume(){  resume_header | tee $s/resume.md  && grep -n '_question_\|_todo_\|_git_commit_\|_google_search_'  $note  | sed 's/__/  /g' | sed 's/:  / |  /g'| tee -a $s/resume.md }
function todo(){ clear && resume | grep 'plus tard' && echo '\n\n todo \n' ; resume_header && grep \*  $s/resume.md | grep -v 'plus tard'}
alias ngg="cat $note |grep -n '__search_google__\|]('"
alias nga="cat $note |grep -n '^__\|---'" 
alias lig="cat $note |grep -n ']('" 
function vn(){vim_note $@  && vim $note -O $@}
function vim_note() { line_note=$(wc -l $n | awk {'print $1'})  &&  echo "$(date +'%A | %H:%M') | $task | vim | $note $@" >>  $daily_log  &&  echo "$(date +'%Y-%m-%d--%H-%M') | $line_note | $@" >> $note_log }
function v(){vim_note $@  && vim -O $@}
function git_commit_note() { git commit -m $1 && git log -1 --format="$(date +'%Y-%m-%d--%H-%M') | $task | git |  %h  %s" >> $note  &&  git log -1 --format="$(date +'%A | %H:%M') | $task | git |  %h  %s" >> $daily_log  &&  vim $note }
function daily() { daily_log $@  && arg=$(echo " $(pwd) $@" |sed 's/.Users.TP1.Sites.notes.local.//g'  | sed 's/.Users.TP1/\~/g'); echo "$(date +'%A | %H:%M') | $task | daily note | $arg" >>  $daily_log && vim $daily} 
function vim_daily() { arg=$(echo " $(pwd) $@" |sed 's/.Users.TP1.Sites.notes.local.//g'  | sed 's/.Users.TP1/\~/g'); echo "$(date +'%A | %H:%M') | $task | daily note | $arg" >>  $daily_log  &&  vim -O $daily $@ }
function tolog(){  grep -n '^0\|^## ' $daily }
alias dl='daily_log'
function daily_log()  {  echo "0 | $(date +'%m/%d/%Y | %H:%M') | $@"  >> $daily }
alias gdno="git diff |grep \"^+\|^- \|++\" | tee -a $note"
function gac { git add -A :/;git_commit_note " $task $1 " }
alias cn="cat $note" 
alias cng="cat $note |grep -n"
alias tn="tail $note"
alias ta="tee -a $note"
alias vng="vn $(g ls-files -m)"
alias n="vim $note"
alias vno="vim $note -O"
alias gcm="git_commit_note $1"
function add_variable(){ echo "export $1=\"$2\" # $task " |tee -a $var }
#function add_project_alias(){ if [ `alias | grep $1 | wc -l` == 0 ] ; then echo "alias $1='$2' " >> $var ; fi }
#alias apa="add_project_alias"
alias av="add_variable"
function add_alias(){ echo "alias $1=\"$2\" # $task" |tee -a $var }
alias aa="add_alias"
alias cv="cat $var"
alias vv="vim -O $var $note "
alias vg="cat $var |grep"
alias vgt="grep $task $var"
alias sv="source_var"
function git_root() { basename $(git rev-parse --show-toplevel) }
function source_var(){ dir=$(git_root) ; project_directory="$HOME/Sites/notes.local/projects/$dir"; var=$project_directory/var.sh; echo "source $var" && source $var  && source ~/alias/note.sh source && ~/alias/mysql.sh  }
alias np="new_project"
function new_project(){ dir=$(git_root) ; project_directory="$HOME/Sites/notes.local/projects/$dir"; var=$project_directory/var.sh; mkdir -p $project_directory  && touch $var }
function file_map(){ find * -mindepth 1 -maxdepth 2 -name "*.md" | awk 'function folder(file) { n = split(file, a, "/") return a[1] } function basename(file) { sub(".*/", "", file) return file } {printf "[ %s | %s ]( %s ) \n", basename($1), folder($1), $1 }' } 
alias fm="file_map"
function folder_map(){ ls -d1 */ | awk '{printf "  * [ %s ]( %sreadme.md ) \n", $1, $1 }' }
alias fom="folder_map"
alias gn="vim /Users/TP1/notes/git.md"
alias mn="vim /Users/TP1/notes/mysql.md"
alias nn="vim /Users/TP1/notes/note.md"
alias vvn="vim /Users/TP1/notes/vim.md"
alias pmn="vim /Users/TP1/notes/package_manager.md"
alias nt=$HOME/scripts/newtask.sh
export sc="$HOME/scripts"
