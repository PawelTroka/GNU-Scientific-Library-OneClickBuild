#!/bin/bash
version=2.3
wget "http://ftpmirror.gnu.org/gsl/gsl-$version.tar.gz"

declare -a architectures=( "x86_64-linux" "i686-linux" "x86_64-darwin" "i686-darwin" )
for architecture in "${architectures[@]}"
do
	rm -fdr gsl-$version
	tar -xzvf gsl-$version.tar.gz
	cd gsl-$version && ./configure CFLAGS=-fPIC --enable-host-shared --prefix=/usr/gsl-build-linux/$architecture --host=$architecture
	make
	sudo make install && cd ..
done
