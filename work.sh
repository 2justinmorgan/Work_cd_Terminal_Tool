
function print_help_message() {
	jq .help_message[] ~/.work/work.json > message_output.temp;
	while read line; do
		line="${line:1:-1}";
		line="${line/\\}";
		echo "$line";
	done < message_output.temp;
	rm message_output.temp;
	printf "%12s\n" "[key]:";
	work get all;
	echo;
}

function get_cmd_num() {
	cmd_key=$1;
	cmd_num=1;
	i=0;
	for cmd in ${all_cmd_keys_arr[@]}; do
		i=$((i+1));
		if [[ $cmd == $cmd_key ]]; then
			cmd_num=$i;
		fi
	done
	echo $cmd_num;
}

function get_key_value() {
	key=$1;
	if [[ $key == "all" ]]; then
		all_cmd_keys_arr=($(jq -r .commands[] ~/.work/work.json));
		for ((cmd_num=1; cmd_num<=${#all_cmd_keys_arr[@]}; cmd_num++)); do
			key=${all_cmd_keys_arr[$((cmd_num-1))]};
			printf "%12s   %s\n" $key "$(sed -n ${cmd_num}p ~/.work/commands)";
		done
		return;
	fi
	cmd_num=$(get_cmd_num $cmd_key);
	cmd=$(sed -n ${cmd_num}p ~/.work/commands);
	printf "%12s   %s\n" $key "$cmd";
}

function set_key_value() {
	key=$1;
	history_line=($(history 2 | sed -n 1p));
	value="${history_line[@]:1}";
	echo $value >> ~/.work/commands;
	cat <<< $(jq ".commands |= . + [\"$key\"]" ~/.work/work.json) > ~/.work/work.json;
}

function execute_cmd () {
	cmd_key=$1;
	all_cmd_keys_arr=($(jq -r .commands[] ~/.work/work.json));

	cmd_num=$(get_cmd_num $cmd_key);
	cmd=$(sed -n ${cmd_num}p ~/.work/commands);
	history -s $cmd;
	# tried to reference history instead of using eval
	eval $cmd;
}

case $1 in 
	"")
		print_help_message;
		;;
	"get")
		get_key_value $2;
		;;
	"set")
		set_key_value $2;
		;;
	*)
		execute_cmd $1;
		;;
esac

