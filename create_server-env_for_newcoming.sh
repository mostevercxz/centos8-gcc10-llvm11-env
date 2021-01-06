#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

SCRIPT_DIR=./run_server

username=`whoami`
echo -e "${green}欢迎 ${yellow}${username} 使用${green}启动容器${plain}"

tmpdate=`date +%s`

get_user_name() {
	echo -e "请输入 你的公司昵称(非英文昵称的，输入汉字对应拼音), 按 Enter 键结束"
	read -e -p ":" user_name
	[ -z "${user_name}" ]
	echo
	echo "用户名字=${user_name}"
	echo
}

get_choosen_port() {

	echo -e "请指定 端口(不允许使用已占用的), 按 Enter 键结束"
	read -e -p ":" dev_port
	[ -z "${dev_port}" ]
	echo
	echo "指定端口=${dev_port}"
	echo

	echo -e "请指定第1个网关端口(不允许使用已占用的), 按 Enter 键结束"
	read -e -p ":" gate1_port
	[ -z "${gate1_port}" ]
	echo
	echo "指定端口=${gate1_port}"
	echo

	echo -e "请指定第2个网关端口(不允许使用已占用的), 按 Enter 键结束"
	read -e -p ":" gate2_port
	[ -z "${gate2_port}" ]
	echo
	echo "指定端口=${gate2_port}"
	echo
}

get_user_name
get_choosen_port
echo "docker run --network=bridge --privileged --rm -d -it -p ${dev_port}:22 -p ${gate1_port}:6667 -p ${gate2_port}:6668 -v /home/${user_name}/:/home/dev:Z --name=${user_name}_dev --hostname=${user_name}-linux serverdev" > run_$user_name.sh
mkdir -p $SCRIPT_DIR && mv run_$user_name.sh $SCRIPT_DIR
chmod +x $SCRIPT_DIR/run_$user_name.sh
sudo bash $SCRIPT_DIR/run_$user_name.sh
if [ $? -ne 0 ]; then
        echo "failed"
	rm -f $SCRIPT_DIR/run_$user_name.sh
fi
