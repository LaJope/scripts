function cprep() {
  arg_flags=""

  for arg in "$@";
  do
    if [[ $arg = -* ]];
    then
      arg_flags="${arg_flags}${arg#-}"
    else
      name=$arg
    fi
  done

  if [[ $arg_flags != "" ]];
  then
    arg_flags="-${arg_flags}"
  fi

  if [[ $name != "" ]];
    then
      mkdir "$name" || { echo "Failed mkdir" ; exit; };
      cd "$name" || { echo "Failed cd" ; exit; };
  fi

  [[ -f ./tasks.py ]] || ln -s ~/.custom/invoke/tasks.py ./tasks.py;
  inv cmakePrep ${arg_flags};
}
