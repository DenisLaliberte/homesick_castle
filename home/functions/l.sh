# logbook
export lb=$HOME/Google\ Drive\ \(denis.laliberte@gmail.com\)/logbook
export y=$lb/$(date +%Y)
export q="$y/$(ruby -e 'require "date"; w=DateTime.now.strftime("%W").to_i; puts "Q#{(w/13)+1}"')"
export nq="$y/$(ruby -e 'require "date"; w=(Date.today + 90).to_datetime.strftime("%W").to_i; puts "Q#{(w/13)+1}"')"
export w=$q/w$(date +%W)
export nw="$y/$(ruby -e 'require "date"; w=(Date.today + 7).to_datetime.strftime("%W").to_i; puts "Q#{(w/13)+1}/w#{w}"')"
export d=$w/$(date +%d)

# el -> Edit logbook
# el logbook -> Edit logbook 
function el(){
  mkdir -p "$w/$1"
  rmdir "$w/$1"
  ${2:-vim} "$w/${1:-readme}.md"
}

# eld -> Edit Logbook Daily notes
function eld() {
  el "$(date +%d)/${1:-readme}" ${2:-vim}
}

# lw -> List LogBook
# lw 30 -> List LogBook week 30
function lw(){
  tree "$q/w${1:-$(date +%W)}"
}

# llc -> Logbook: List Comand in logbook test
function llc() {
  grep -n '\$' "$w/${1:-readme}.md"  | grep ${2:-.} | grep '\$'
}

# lec test 12 -> Logbook: Execute Command at Line 12 of logbook test
function lec () {
  command=$(sed "$2!d" "$w/${1:-readme}.md" | sed -n -e 's/^.*\$//p')
  echo $command
  eval $command
}


