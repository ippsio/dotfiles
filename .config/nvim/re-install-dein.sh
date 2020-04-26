#!/bin/sh

CD=~/.cache/dein
CDDT=${CD}_$(date +'%Y%m%d_%H%M%S')
mkdir -p ${CDDT}
rm -r ${CD} && ln -sF ${CDDT} ${CD}
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o ${CD}/installer.sh
sh ${CD}/installer.sh ${CD}

