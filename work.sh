
options=("--help" "set" "show");

function usage () {
	echo;
	echo -e "  Usage: work [option]\n";
	echo -e "   This is a cd shortcut tool that allows you to save a directory";
	echo -e "   for which work is regularly done, with the following options:";
	echo;
	echo -e "     [none]   changes directory to WORK_DIR"' via cd $WORK_DIR';
	echo -e "     --help   displays this message";
	echo -e "        set   sets WORK_DIR to current working dir"' via $(pwd)';
	echo -e "       show   shows value of WORK_DIR\n";
}

function get_bashrc_work_dir () {
	# only gets the last occurrence of "export WORK_DIR="
	lines=($(cut -d':' -f1 <<< $(grep -n "export WORK_DIR=" ~/.bashrc)));
	line=${lines[$((${#lines[@]}-1))]};
	WORK_DIR=$(cut -d'"' -f2 <<< $(sed -n $line","$line"p" ~/.bashrc));
}

if [[ ! ${options[@]} =~ $@ ]]; then
	echo -e "\n    \"$@\" invalid option";
	usage;
fi

if [[ $@ == "--help" ]]; then
	usage;
fi

if [[ $@ == "set" ]]; then
	get_bashrc_work_dir;
	pwd="\"$(pwd)\"";
	l=${#pwd};

	# insert "\" before every "/" in pwd
	for ((i=0; i<$l; i++)); do
		if [[ ${pwd:$i:1} == "/" ]]; then 
			pwd=${pwd:0:$i}'\'${pwd:$i}; 
			i=$((i+1)); 
		fi; 
	done

	sed -i "${line}s/.*/export WORK_DIR=$pwd/" ~/.bashrc;
	WORK_DIR=$(cut -d'"' -f2 <<< $(sed -n $line","$line"p" ~/.bashrc));
	echo set $WORK_DIR;
fi

if [[ $@ == "show" ]]; then
	get_bashrc_work_dir;
	echo $WORK_DIR;
fi

if [[ $# -le 0 ]]; then
	get_bashrc_work_dir;
	cd $WORK_DIR;
fi





