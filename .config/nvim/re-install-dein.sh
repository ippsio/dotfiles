#!/bin/sh

CD=~/.cache/dein
CDDT=${CD}_$(date +'%Y%m%d_%H%M%S')

echo "rm -r mkdir -p ${CDDT}"
mkdir -p ${CDDT}

echo "rm -r ${CD}"
rm -rf ${CD}

echo "ln -sF ${CDDT} ${CD}"
ln -sF ${CDDT} ${CD}

echo "curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o ${CD}/installer.sh"
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o ${CD}/installer.sh

echo "sh ${CD}/installer.sh ${CD}"
sh ${CD}/installer.sh ${CD}

