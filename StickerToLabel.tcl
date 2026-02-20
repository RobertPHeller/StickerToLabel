#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : 2026-02-17 10:49:35
#  Last Modified : <260220.1541>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
## @copyright
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
# @file StickerToLabel.tcl
# @author Robert Heller
# @date 2026-02-17 10:49:35
# 
#
#*****************************************************************************


package require snit

snit::type StickerToLabel {
    typevariable _Preamble {%!PS-Adobe-3.0
%%Title: @TITLE@
%%Creator: StickerToLabel
%%CreationDate: @DATE@
%%BoundingBox: 14 14 154 270 
%%DocumentData: Clean7Bit
%%Orientation: Portait
%%Pages: 1
%%PageOrder: Ascend
%%DocumentNeededResources: font Helvetica
%%DocumentProcessColors: Black 
%%EndComments
%%BeginProlog
%%EndProlog
%%BeginSetup
%%EndSetup
%%Page: (1) 1
%%BeginPageSetup
/Helvetica findfont 10 scalefont setfont
90 rotate 0 -164 translate
%%EndPageSetup
}
    typevariable PRINTER {|lp -d Thermal -o media=X48MMY105MM}
    typemethod SendPreamble {title {out stdout}} {
        puts $out [regsub {@TITLE@} [regsub {@DATE@} $_Preamble [clock format [clock seconds]]] $title]
    }
    
    typemethod ShortenVersionInfoLine {line} {
        if {[regexp {^([[:xdigit:]]{7})([[:xdigit:]]+):(.*)$} $line => short unused software] > 0} {
            return "b'$short':$software"
        } else {
            return $line
        }
    }
    
    typemethod Main {filename} {
        set lpfp [open $PRINTER w]
        $type SendPreamble $filename $lpfp
        set fp [open $filename r]
        set y [expr {(164-(14+10))}]
        while {[gets $fp line] >= 0} {
            puts $lpfp "14 $y moveto ([$type ShortenVersionInfoLine $line]) show"
            set y [expr {$y - 10}]
        }
        close $fp
        puts $lpfp "showpage"
        puts $lpfp "%%Trailer"
        puts $lpfp "%%EOF"
        close $lpfp
    }
        
        
}

if {$argc > 0} {
    StickerToLabel Main [lindex $argv 0]
}

