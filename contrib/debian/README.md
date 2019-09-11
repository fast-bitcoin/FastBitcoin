
Debian
====================
This directory contains files used to package fastbitcoind/fastbitcoin-qt
for Debian-based Linux systems. If you compile fastbitcoind/fastbitcoin-qt yourself, there are some useful files here.

## fastbitcoin: URI support ##


fastbitcoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install fastbitcoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your fastbitcoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/fastbitcoin128.png` to `/usr/share/pixmaps`

fastbitcoin-qt.protocol (KDE)

