#!/bin/bash

[ -n "$SKEL_FINISHED" ] && return

# use windows shortcuts as symlinks
export CYGWIN="${CYGWIN}${CYGWIN:+ }winsymlinks"

# bind user profile directory
#[ ! -e "$HOME/.userprofile" ] && mount -fo user "$USERPROFILE" ~/.userprofile

# ensure skeleton files are updated for new packages
for bone in `find /etc/skel -type f -printf "%P\n"`; do
    if [ ! -e $HOME/$bone ]; then
        mkdir -p `dirname $HOME/$bone`
        cp /etc/skel/$bone $HOME/$bone
    fi
done

# bind cygdrive to /media
#for sd in `ls /cygdrive/`; do
#	if [ ! -e "/media/$sd" ]; then
#		mount -f "$(cygpath -w /cygdrive/$sd)" /media/$sd
#	fi
#done

# bind windows user-dirs to home folder
#if which xdg-user-dirs-update >/dev/null 2>&1; then
#    xdg-user-dirs-update --force
#fi
#for d in DESKTOP DOCUMENTS DOWNLOAD MUSIC PICTURES PUBLICSHARE TEMPLATES VIDEOS; do
#	ud="$(xdg-user-dir $d)"
#	upd="$(cygpath $USERPROFILE/$(basename $ud))"
#	if [ -e "$upd" ] && ! find "$ud" -mindepth 1 -print -quit 2>/dev/null | grep -q . ; then
#		mount -fo user $(cygpath -w $(readlink -f $upd)) $ud
#	fi
#done

export SKEL_FINISHED=1

