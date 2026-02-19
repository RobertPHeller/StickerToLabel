##-*- makefile -*-############################################################
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : 2026-02-18 07:31:00
#  Last Modified : <260218.0734>
#
#  Description	
#
#  Notes
#
#  History
#	
#  $Log$
#
##############################################################################
#
#    Copyright (C) 2026  Robert Heller D/B/A Deepwoods Software
#			51 Locke Hill Road
#			Wendell, MA 01379-9728
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# 
#
##############################################################################


all: StickerToLabel.kit

SOURCES = StickerToLabel.tcl 


StickerToLabel.kit: $(SOURCES)
	rm -f StickerToLabel.kit
	sdx qwrap StickerToLabel.tcl
	rm -rf StickerToLabel.vfs
	sdx unwrap StickerToLabel.kit
	#mkdir StickerToLabel.vfs/lib/support
	#cp SnitReceiptPrinter.tcl StickerToLabel.vfs/lib/support/
	#echo 'pkg_mkIndex StickerToLabel.vfs/lib/support/'|/usr/bin/tclsh
	ln -s /usr/share/tcltk/tcllib1.21/snit  StickerToLabel.vfs/lib/
	sdx wrap StickerToLabel.kit
	rm -rf StickerToLabel.vfs
