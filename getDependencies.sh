#!/bin/bash
set -ex
cd "$(dirname "${0}")/.."

sudo apt-get update

sudo apt-get install -y  \
	rsync \
	wget \
	unzip \
	zstd \
	git \
	imagemagick \
	xclip \
	libglu1-mesa-dev \
	libgl1-mesa-dev \
	libsdl1.2-dev \
	mingw-w64 \
	build-essential \
	libfreetype-dev \
	libbrotli-dev \


mkdir -p dependencies
cd dependencies

# Getting SDL
if [ ! -d SDL* ]; then
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
fi

# Getting zlib
if [ ! -d zlib* ]; then
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
fi

# Getting libpng
if [ ! -d l*png* ]; then
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
fi

# Getting discord_game_sdk
if [ ! -d discord_game_sdk ]; then
	wget https://github.com/X-Lives/EasierOLCompile/releases/download/Releases/discord_game_sdk.zip
	unzip -d discord_game_sdk discord_game_sdk.zip
	rm discord_game_sdk.zip
fi

# freetype lib for linux-windows cross compile
if [ ! -d freetype* ]; then
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
fi