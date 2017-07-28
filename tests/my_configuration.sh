#!/bin/sh

logit ""
info "My Configuration"

source ./check.cfg

# 01
docker_version_check(){
	target_docker_version=$1
	check_01="01  - Ensure docker version >= $target_docker_version"
	docker_version=$(docker version | grep -i -A1 '^server' | grep -i 'version:' \
  	| awk '{print $NF; exit}' | tr -d '[:alpha:]-,')
  
	do_version_check "$target_docker_version" "$docker_version"
	if [ $? -eq 11 ]; then
  	info "$check_01"
  	error "    * Using $docker_version, verify is it up to date as deemed necessary"
  	info "     * Your operating system vendor may provide support and security maintenance for Docker"
	else
  	pass "$check_01"
  	info "     * Using $docker_version which is current"
  	info "     * Check with your operating system vendor for support and security maintenance for Docker"
	fi
}
docker_version_check "$docker_version"


# 02
kernel_version_check(){
	target_kernel_version=$1
	check_02="02  - Ensure kernel version equal to $target_kernel_version"

	kernel_version=$(uname -r)
	
	do_version_check "$target_kernel_version" "$kernel_version"
	if [ $? -eq 11 ];then
		info "$check_02"
		warn "     * Using $kernel_version, verify is it up to date as deemed necessary"
		info "     * Your operating system vendor may provide support and security maintenance for Docker"
	else
		pass "$check_02"
		info "     * Using $kernel_version which is current"
  	info "     * Check with your operating system vendor for support and security maintenance for Docker"
	fi
}
kernel_version_check "$kernel_version"

# 03
path_check(){
	target_path=$1
	check_03="03  - Ensure $target_path exist"
	if [ -d "$target_path" ]; then  
¡¡	pass "$check_03"
		info "     * $target_path exist"
	else
		info "$check_03"
		warn "     * $target_path doesn't exist, verify does it need to install as deemed necessary"
	fi  
}
path_check "$jdk_path"

# 04
proc_check(){
	target_proc=$1
	check_04="04  - Ensure process $target_proc is running"
	ps -ef|grep $target_proc|grep -v grep >/dev/null 2>&1;
	if [ $? -eq 0 ]; then
		pass '$check_04'
		info "     * $target_proc is running"
	else
		info "$check_04"
		warn "     * $target_proc is not running, verify does it need to start as deemed necessary"
	fi
}

proc_check '$proc'