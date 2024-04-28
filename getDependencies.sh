#!/bin/bash
set -e
if [[ $1 == "" ]];then
    GETD_SET=""
else
    GETD_SET=$1
fi
if [[ ${GETD_SET} == "" ]]; then
    # This if means that if this file is executed alone, with no arguments passed in, this default argument will be used.
    SPEEDEDUP_LINK=""
fi
if [[ ${GETD_SET} == "" ]]; then
    echo "--------GETD-SETUP--------"
    read -p "Use SPEEDEDUP_LINK?[Y/N]" SPEEDEDUP_LINK_read
    SPEEDEDUP_LINK_read=$(echo $SPEEDEDUP_LINK_read | tr '[:upper:]' '[:lower:]')
    if [[ $SPEEDEDUP_LINK_read == *y* ]];then
        read -p "SPEEDEDUP_LINK: " SPEEDEDUP_LINK
    fi
	echo "--------------------------"
fi

set -ex
cd "$(dirname "${0}")/.."

if [[ ${ELOC_install} != 1 ]];then
	echo -e "\033[43;37m --- apt-get update --- \033[0m"
	sudo apt-get update
	echo -e "\033[42;37m --- Done to update --- \033[0m"
fi

echo -e "\033[43;37m --- apt-get runlib --- \033[0m"
sudo apt-get install -y  \
	rsync \
	wget \
	zip \
	unzip \
	zstd \
	git \
	imagemagick \
	xclip \
	pv \
	libglu1-mesa-dev \
	libgl1-mesa-dev \
	libsdl1.2-dev \
	mingw-w64 \
	build-essential \
	libfreetype-dev \
	libbrotli-dev \

echo -e "\033[42;37m --- Done to runlib --- \033[0m"

echo -e "\033[43;37m --- Dowload depend --- \033[0m"
mkdir -p dependencies
cd dependencies

# Getting SDL
if [ ! -d SDL* ]; then
	echo ""
	echo -e "\033[32m SDL \033[0m"
	pushd .
	wget https://www.libsdl.org/release/SDL-1.2.15.tar.gz -O- | tar xfz -
	cd SDL*
	./configure \
		--bindir=/usr/i686-w64-mingw32/bin \
		--libdir=/usr/i686-w64-mingw32/lib \
		--includedir=/usr/i686-w64-mingw32/include \
		--host=i686-w64-mingw32 \
		--prefix=/usr/i686-w64-mingw32 \
		CPPFLAGS="-I/usr/i686-w64-mingw32/include" \
		LDFLAGS="-L/usr/i686-w64-mingw32/lib"
	make
	sudo make install
	popd
	echo -e "\033[32m Done \033[0m"
fi

# Getting zlib
if [ ! -d zlib* ]; then
	echo ""
	echo -e "\033[32m ZLIB \033[0m"
	pushd .
	wget http://zlib.net/fossils/zlib-1.2.12.tar.gz -O- | tar xfz -
	cd zlib*
	host="i686-w64-mingw32"
	prefixdir="/usr/i686-w64-mingw32"
	sudo make -f win32/Makefile.gcc \
		BINARY_PATH=$prefixdir/bin \
		INCLUDE_PATH=$prefixdir/include \
		LIBRARY_PATH=$prefixdir/lib \
		SHARED_MODE=1 \
		PREFIX=$host- \
		install
	popd
	echo -e "\033[32m Done \033[0m"
fi

# Getting libpng
if [ ! -d l*png* ]; then
	echo ""
	echo -e "\033[32m LIBPNG \033[0m"
	pushd .
	wget http://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.gz -O- | tar xfz -
	cd l*png*
	./configure \
		--host=i686-w64-mingw32 \
		--prefix=/usr/i686-w64-mingw32 \
		CPPFLAGS="-I/usr/i686-w64-mingw32/include" \
		LDFLAGS="-L/usr/i686-w64-mingw32/lib"
	make
	sudo make install
	popd
	echo -e "\033[32m Done \033[0m"
fi

# Getting discord_game_sdk
if [ ! -d discord_game_sdk ]; then
	echo ""
	echo -e "\033[32m DISCORD_GAME_SDK \033[0m"
	wget ${SPEEDEDUP_LINK}https://github.com/X-Lives/EasierOLCompile/releases/download/Releases/discord_game_sdk.zip
	unzip -d discord_game_sdk discord_game_sdk.zip
	rm discord_game_sdk.zip
	echo -e "\033[32m Done \033[0m"
fi

# freetype lib for linux-windows cross compile
if [ ! -d freetype* ]; then
	echo ""
	echo -e "\033[32m FREETYPE \033[0m"
	pushd .
	wget https://sourceforge.net/projects/freetype/files/freetype2/2.13.2/freetype-2.13.2.tar.gz/download -O- | tar xfz -
	cd freetype*
	./configure \
		--host=i686-w64-mingw32 \
		--prefix=/usr/i686-w64-mingw32 \
		--with-bzip2=no \
		--with-brotli=no \
		CPPFLAGS="-I/usr/i686-w64-mingw32/include" \
		LDFLAGS="-L/usr/i686-w64-mingw32/lib"
	make
	sudo make install
	popd
	echo -e "\033[32m Done \033[0m"
fi

echo -e "\033[42;37m --- Done to depend --- \033[0m"