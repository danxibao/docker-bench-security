#!/bin/sh

logit ""
info "My Configuration"
auditrules="/etc/audit/audit.rules"


# 01
target_docker_version='1.11'
check_01="01  - Ensure docker version >= $target_docker_version"
docker_version=$(docker version | grep -i -A1 '^server' | grep -i 'version:' \
  | awk '{print $NF; exit}' | tr -d '[:alpha:]-,')
  
do_version_check "$target_docker_version" "$docker_version"
if [ $? -eq 11 ]; then
  info "$check_01"
  error "     * Using $docker_version, verify is it up to date as deemed necessary"
  info "     * Your operating system vendor may provide support and security maintenance for Docker"
else
  pass "$check_01"
  info "     * Using $docker_version which is up to date"
  info "     * Check with your operating system vendor for support and security maintenance for Docker"
fi


# 02
target_kernel_version='3.10.0-514.16.1.el7.ctrip.x86_64'
check_02="02  - Ensure kernel version equal to $target_kernel_version"

kernel_version=$(uname -r)

if [ "$target_kernel_verison" != "$kernel_verison" ];then
	info "$check_02"
	warn "     * Using $kernel_version, verify is it up to date as deemed necessary"
	info "     * Your operating system vendor may provide support and security maintenance for Docker"

else
	pass "$check_02"
	info "     * Using $docker_version which is up to date"
  info "     * Check with your operating system vendor for support and security maintenance for Docker"
fi

# 03
check_03="03  - Ensure kernel version equal to $target_kernel_version"