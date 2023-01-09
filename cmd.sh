#!/bin/bash
#
#
#### Put this file into your .wire home directory

SELF=$(SELF=$(dirname "$0") && bash -c "cd \"$SELF\" && pwd")
cd "$SELF"

out_file="cmd.txt"

nick=$( cat "$out_file" | sed 's/-###.*//g' | xargs )
nick_low=$( echo "$nick" | tr '[:upper:]' '[:lower:]' )
command=$( cat "$out_file" | sed 's/.*-###-//g' | xargs )

function print_msg {
  /usr/bin/screen -S wirebot -X stuff "$say"^M
}

function rnd_answer {
  size=${#answ[@]}
  index=$(($RANDOM % $size))
  say=$( echo ${answ[$index]} )
  print_msg
}

if [[ "$command" == *"Hey, why did you"* ]]; then
  exit
fi

if [[ "$command" == *" has joined" ]]; then
  nick=$( cat "$out_file" | sed -e 's/.*\]\ //g' -e 's/\ has\ joined//g' -e 's/;0m//g' | xargs )
  say="Hi $nick (-:"
fi

if [[ "$command" == *" has left" ]]; then
  nick=$( cat "$out_file" | sed -e 's/.*\]\ //g' -e 's/\ has\ left//g' -e 's/;0m//g' | xargs )
  say="Bye $nick ☹️".
fi

if [[ "$nick_low" == *"luigi"* ]]; then
  if [ "$command" = "!test" ]; then
    say="Weeeeeeeee :-)"
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
    answ[1]="I jump."    
    rnd_answer
    say="/afk"
    print_msg
  fi
fi

if [ "$command" = "shit" ] || [[ "$command" = *"fuck"* ]] || [ "$command" = "asshole" ] || [ "$command" = "ass" ] || [ "$command" = "dick" ]; then
  answ[0]="$nick, don't be rude please..."
  answ[1]="Very impolite!"
  answ[2]="Hey, why did you say \"$command\" ?"
  rnd_answer
  exit
fi

if [ "$command" = "hello" ] || [ "$command" = "hey" ] || [ "$command" = "hi" ]; then
  answ[0]="Hey $nick. :-)"
  answ[1]="Hello $nick. :-)"
  answ[2]="Hi $nick. :-)"
  answ[2]="Yo $nick. :-)"
  rnd_answer
fi
