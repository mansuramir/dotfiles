#!/bin/sh

### os and platform identification
platform='unknown'
linux_distro='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
    export HOSTOS="macos"
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
fi

if [[ $platform == 'linux' ]]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "${ID}" == 'arch' ]]; then
            linux_distro='arch'
	    export HOSTOS="linuxarch"
        elif [["${ID}" == "fedora*" ]]; then
            linux_distro='fedora'
	    export HOSTOS="linuxfedora"
        fi
    fi
fi
