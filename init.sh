#!/bin/sh
local=`pwd`
vimPath="$HOME/.vim"
vimrc="$HOME/.vimrc"
if [ -d "$vimPath" ]; then
    rm -r $vimPath
    echo "delete  $vimPath"
fi

if [ -f $vimrc ]; then
    rm -r $vimrc
    echo "delete $vimrc"
fi

ln -s $local/vimrc $vimrc
ln -s $local/vim $vimPath

exit 0
