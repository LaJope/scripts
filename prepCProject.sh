function cprep() {
    name=""
    if [[ "$#" == 1 ]]; then
        name=$1
    fi

    if [[ $name != "" ]]; then
        mkdir "$name" || { echo "Failed mkdir" ; return; };
        cd "$name" || { echo "Failed cd" ; return; };
    fi

    [[ -f ./tasks.py ]] || ln -s ~/.custom/invoke/tasks.py ./tasks.py;
    inv cmakePrep;
}
