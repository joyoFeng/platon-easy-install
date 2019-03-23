#!/usr/bin/bash
# this script is for setting up PlatON MPC development environment 


# install third-part toolkit
function install_deps()
{
	# install g++, cmake
	echo ">>>>>> install dependencies ..."
	sudo apt-get install gcc g++ cmake wget tar tree
	echo ">>>>>> install dependencies success."
}

# download mpc associate packages
function download_packages()
{
	# downloading
	echo ">>>>>>  downloading packagaes..."
	# pwam
	if [ ! -e pwasm-linux-amd64-0.4.0.tar.gz ]; then
		echo "downloading pwasm-linux-amd64-0.4.0.tar.gz"
		sudo wget https://download.platon.network/0.4/pwasm-linux-amd64-0.4.0.tar.gz
	fi

	# mpc
	#sudo wget https://download.platon.network/0.5/platon-ubuntu-amd64-mpc-toolkit.tar.gz
	if [ ! -e platon-ubuntu-amd64-mpc-toolkit.tar.gz ]; then
		echo "downloading platon-ubuntu-amd64-mpc-toolkit.tar.gz"
		#sudo wget https://download.platon.network/0.5/platon-ubuntu-amd64-mpc-toolkit.tar.gz
	fi
	echo ">>>>>> downloading success."
}


# create workspace
function create_workspace()
{
	# create workspace directory
	echo ">>>>>> create mpc workspace..."
	if [ -e platon-mpc ]; then
		rm platon-mpc -rf
		mkdir platon-mpc
	fi

	# distract packages to workspace
	tar -xzvf pwasm-linux-amd64-0.4.0.tar.gz > /dev/null
	mv pwasm-linux-amd64-0.4.0 ./platon-mpc/pwasm
	
	tar -xvzf platon-ubuntu-amd64-mpc-toolkit.tar.gz
	mv platon-ubuntu-amd64-mpc-compiler mpc
	
	mv mpc pwasm ./platon-mpc/ -f
	echo ">>>>>>  workspace list."
	tree ./platon-mpc -L 2
}

function main()
{
	echo ">>> starting to setup the mpc workspace..."
	install_deps
	download_packages
	create_workspace
	echo ">>> OK."
	
}

main
