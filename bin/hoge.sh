#!/bin/bash

hoge="git "\
"aaa"\
"bbb"

echo "${hoge}"| perl -pe "s/[\r\n]//g"
