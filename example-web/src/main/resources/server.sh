#!/bin/sh
export BUILD_ID=cds

#----------------------------------------------↓变量区↓----------------------------------------------#
#操作类型：start/stop/restart/status
OPERATION=$1
#执行文件名，例如：example_server.jar
#JAR_NAME=""时，自动搜索当前目录下唯一jar包
JAR_NAME="example_server.jar"
#虚拟机参数，例如：-Xms256m -Xmx256m
VM_OPTIONS="-Xms256m -Xmx256m"
#springboot 配置文件指定
#例如：dev/test/pro等，对应application-dev.yml/application-test.yml/application-pro.yml
#不指定则不是springboot项目或直接使用application.yml
PROFILE_ACTIVE=""
#颜色定义
RESTORE=$(echo -en '\033[0m')
BLACK=$(echo -en '\033[00;30m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
T_GREEN=$(echo -en '\033[1;32m')
#----------------------------------------------↑变量区↑----------------------------------------------#


#----------------------------------------------↓方法区↓----------------------------------------------#
#设置参数
function setOpt() { 
	
	if [ -n "${1}" ] ; then
		#从第0个字符起，取3个字符
		opt=${1:0:3}
		value=${1:3}
		case $opt in
		    -j=)
		    	JAR_NAME=${value}
		        ;;
		    -v=)
		    	VM_OPTIONS=${value}
		        ;;
		    -p=)
		    	PROFILE_ACTIVE=${value}
		        ;;
		esac
	fi
}

#检查程序是否在运行
function status() { 
	#初始化参数
	#进程ID
	PID=`ps -ef|grep 'java'|grep ${JAR_NAME}|grep -v 'grep'|head -1|awk '{print $2}'`
	#启动时间
	START_DATE=`ps -ef|grep 'java'|grep ${JAR_NAME}|grep -v 'grep'|head -1|awk '{print $5}'`
	#运行时长
	DURATION=`ps -ef|grep 'java'|grep ${JAR_NAME}|grep -v 'grep'|head -1|awk '{print $7}'`
	#启动命令
	COMMOND=`ps -ef|grep 'java'|grep ${JAR_NAME}|grep -v 'grep'|head -1|awk -F " " '{for (i=8;i<=NF;i++)printf("%s ", $i);print ""}' `
	
	#如果进程存在
	if [ -n "${PID}" ] ; then
		echo -e "▫当前文件：${BLUE}${JAR_NAME}${RESTORE}"
		echo -e "▫当前进程：${BLUE}${PID}${RESTORE}"
		echo -e "▫启动时间：${BLUE}${START_DATE}${RESTORE}"
		echo -e "▫运行时长：${BLUE}${DURATION}${RESTORE}"
		echo -e "▫启动命令：${BLUE}${COMMOND}${RESTORE}"
	else
		echo -e "▫当前文件：${BLUE}${JAR_NAME}${RESTORE}"
		echo -e "▫执行结果：${RED}进程未启动！${RESTORE}"
	fi
}

#停止方法
function stop() {
	#初始化参数
	timeNow=$(date "+%Y-%m-%d %H:%M:%S")
	echo -e "▫开始停止：${BLUE}${JAR_NAME}${RESTORE}"
	echo -e "▫执行时间：${BLUE}${timeNow}${RESTORE}"
	#获取PID
	PID=`ps -ef|grep 'java'|grep ${JAR_NAME}|grep -v 'grep'|head -1|awk '{print $2}'`
	#运行中
	if [ -n "${PID}" ] ; then
		echo -e "▫当前进程：${BLUE}${PID}${RESTORE}"
		echo -e "▫停止进程：${BLUE}${PID}${RESTORE}"
		#杀死进程
		kill -9 "$PID"
		#等待结束
		sleep 5s
		#确认是否成功停止
		PID=`ps -ef|grep 'java'|grep ${JAR_NAME}|grep -v 'grep'|head -1|awk '{print $2}'`
		if [ -z "${PID}" ] ; then
			echo -e "▫执行结果：${GREEN}停止成功！${RESTORE}"
		else
			echo -e "▫执行结果：${RED}停止失败！${RESTORE}"
			exit 1
		fi
	else
		echo -e "▫执行结果：${RED}进程未启动！${RESTORE}"
	fi
}

#启动方法
function start() {
	timeNow=$(date "+%Y-%m-%d %H:%M:%S")
	echo -e "▫开始启动：${BLUE}${JAR_NAME}${RESTORE}"
	echo -e "▫执行时间：${BLUE}${timeNow}${RESTORE}"
	
	#echo "▫参数："${VM_OPTIONS} ${JAR_NAME} ${PROFILE_ACTIVE}
	#运行
	nohup java -jar ${VM_OPTIONS} ${JAR_NAME} ${PROFILE_ACTIVE}>>/dev/null  2>&1  &
	#等待进程启动
	sleep 5s	
	
	PID=`ps -ef|grep 'java'|grep ${JAR_NAME}|grep -v 'grep'|head -1|awk '{print $2}'`
	if [ -n "${PID}" ] ; then
		echo -e "▫执行结果：${GREEN}启动成功！${RESTORE}"
	else
		echo -e "▫执行结果：${RED}启动失败！${RESTORE}"
	fi
}

#使用说明，用来提示输入参数
function usage() {
	echo -e "使用方法：sh server.sh [${GREEN}start${RESTORE}|${GREEN}stop${RESTORE}|${GREEN}restart${RESTORE}|${GREEN}status${RESTORE}] [${YELLOW}-j${RESTORE},${BLUE}-v${RESTORE},${PURPLE}-p${RESTORE}]"
	echo -e "精简命令：sh server.sh ${GREEN}start${RESTORE}"
	echo -e "精简命令：sh server.sh ${GREEN}status${RESTORE}"
	echo -e "精简命令：sh server.sh ${GREEN}start${RESTORE} ${PURPLE}-p=dev${RESTORE}"
	echo -e "精简命令：sh server.sh ${GREEN}start${RESTORE} ${PURPLE}-p=dev${RESTORE} ${YELLOW}-j=name.jar${RESTORE}"
	echo -e "                     [${GREEN}操作类型${RESTORE}]                     [${BLUE}虚拟机参数，可选${RESTORE}]"
	echo -e "                         ↓                                    ↓ "
	echo -e "完整命令：sh server.sh ${GREEN}start${RESTORE} ${YELLOW}-j=example_server.jar${RESTORE} ${BLUE}-v='-Xms512m -Xmx512m'${RESTORE} ${PURPLE}-p=dev${RESTORE}"
	echo -e "                                     ↑                                       ↑                   "
	echo -e "                         [${YELLOW}文件名，无则搜索当前目录${RESTORE}]              [${PURPLE}springboot配置选择，可选]${RESTORE}"
	exit 1
}
#----------------------------------------------↑方法区↑----------------------------------------------#


#----------------------------------------------↓执行区↓----------------------------------------------#
#1.获取所有参数
for key in "$@"
	do	setOpt "${key}"
done


#2.初始化，如果未指定参数值，则按默认处理
#如果未指定可执行文件
if [ -z "${JAR_NAME}" ] ; then
#如果未指定，则在本目录下查找
	path=`pwd`
	jarName=`find . -name '*.jar'`
	count=`find . -name '*.jar'|wc -l`
	if [ ${count} -gt "1" ] ; then
		echo -e '在'${path}'下找到多个jar文件，请指定可执行文件名称！'
		exit 1
	elif [ ${count} -eq "1" ] ; then
		JAR_NAME=${jarName:2}
	else 
		echo -e '在'${path}'下未找到可执行jar文件！'
		exit 1 
	fi
fi

#如果指定springboot配置文件
if [ -n "${PROFILE_ACTIVE}" ] ; then
	PROFILE_ACTIVE="--spring.profiles.active="${PROFILE_ACTIVE}
fi 

#3.根据输入参数，选择执行对应方法，不输入则执行使用说明
case "${OPERATION}" in
	"start")
		stop
		start
	;;
	"stop")
		stop
	;;
	"status")
		status
	;;
	"restart")
		stop
		start
	;;
	*)
		usage
	;;
esac
#----------------------------------------------↑执行区↑----------------------------------------------#
