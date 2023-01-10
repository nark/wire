#!/bin/bash
#
#
#### Put this file into your .wire home directory
#### Make sure to make a "chmod +x cmd.sh" before.

####################################################
#### Switch desired function on or off (0 or 1).####
####################################################
user_join=1
user_leave=1
wordpolice=1
greeting=1
####################################################
watchdir="/mnt/filez/00 Upload Folders/Mac"
####################################################

SELF=$(SELF=$(dirname "$0") && bash -c "cd \"$SELF\" && pwd")
cd "$SELF"

out_file="cmd.txt"

nick=$( cat "$out_file" | sed 's/-###.*//g' | xargs )
nick_low=$( echo "$nick" | tr '[:upper:]' '[:lower:]' )
command=$( cat "$out_file" | sed 's/.*-###-//g' | xargs )

function print_msg {
  /usr/bin/screen -S wirebot -p0 -X stuff "$say"^M
}

function rnd_answer {
  size=${#answ[@]}
  index=$(($RANDOM % $size))
  say=$( echo ${answ[$index]} )
  print_msg
}

function watcher_def {
  inotifywait -m -e create,moved_to "$watchdir" | while read DIRECTORY EVENT FILE; do
    say=$( echo "$FILE" |sed -e 's/.*CREATE\ //g' -e 's/.*MOVED_TO\ //g' -e 's/.*ISDIR\ //g' )
    say=$( echo "New Mac Stuff has arrived: $say" )
    print_msg
  done
}

function watcher_start {
  /usr/bin/screen -S wirebot -x -X screen -t watcher bash -c "bash "$SELF"/cmd.sh watcher_def; exec bash"
}

function watcher_stop {
  pkill -f inotifywait
}


if [ -f cmd.stop ]; then
  if [ "$command" = "!start" ]; then
        rm cmd.stop
  elif [ "$command" = "!stop" ]; then
    say="/afk"
    print_msg
    exit
  fi
elif [ ! -f cmd.stop ]; then
  if [ "$command" = "!start" ]; then
        exit
  fi
fi

if [[ "$command" == *"Using timestamp"* ]]; then
  rm cmd.stop
fi

#### User join server (user_join) ####
if [ $user_join = 1 ]; then
  if [[ "$command" == *" has joined" ]]; then
    nick=$( cat "$out_file" | sed -e 's/.*\]\ //g' -e 's/\ has\ joined//g' -e 's/;0m//g' | xargs )
    say="Hi $nick :grinning:"
    print_msg
  fi
fi

#### User leave server (user_leave) ####
if [ $user_leave = 1 ]; then
  if [[ "$command" == *" has left" ]]; then
    nick=$( cat "$out_file" | sed -e 's/.*\]\ //g' -e 's/\ has\ left//g' -e 's/;0m//g' | xargs )
    say="Bye $nick :worried:".
    print_msg
  fi
fi

#### Wordpolice (wordpolice)####
if [[ "$command" == *"Hey, why did you"* ]]; then
  exit
fi

if [ $wordpolice = 1 ]; then
  if [ "$command" = "shit" ] || [[ "$command" = *"fuck"* ]] || [ "$command" = "asshole" ] || [ "$command" = "ass" ] || [ "$command" = "dick" ]; then
    answ[0]="$nick, don't be rude please... :thumbsdown:"
    answ[1]="Very impolite! :angry:"
    answ[2]="Hey, why did you say \"$command\" ? :anguished: :pensive:"
    rnd_answer
    exit
  fi
fi

#### Greetings (greeting) ####
if [ $greeting = 1 ]; then
  if [ "$command" = "hello" ] || [ "$command" = "hey" ] || [ "$command" = "hi" ]; then
    answ[0]="Hey $nick. :-)"
    answ[1]="Hello $nick. :wave:"
    answ[2]="Hi $nick. :-)"
    answ[3]="Yo $nick. :-)"
    answ[4]="Yo man ... whazzup? :v:"
    rnd_answer
  fi
fi

#### Admin functions ####
if [[ "$nick_low" == *"luigi"* ]]; then
  if [ "$command" = "!test" ]; then
    say="Weeeeeeeee :blush:"
    print_msg
  fi
  if [ "$command" = "!sleep" ]; then
    answ[0]=":zzz:"
    answ[1]=":sleeping: … Time for a nap."
    rnd_answer
    say="/afk"
    print_msg
  fi
  if [ "$command" = "!start" ]; then
    answ[0]="Yes, my lord."
    answ[1]="I need more blood."
    answ[2]="Ready to serve."
    rnd_answer
  fi

  if [ "$command" = "!stop" ]; then
    answ[0]="Ping me when you need me. :-)"
    answ[1]="I jump :exclamation:"
    rnd_answer
    say="/afk"
    print_msg
    touch cmd.stop
  fi
  if [ "$command" = "!watcher_start" ]; then
    say="Watcher started"
    print_msg
    watcher_start
  fi
  if [ "$command" = "!watcher_stop" ]; then
    say="Watcher stopped"
    print_msg
    watcher_stop
  fi
fi

$1
