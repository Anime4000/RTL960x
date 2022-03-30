#!/bin/sh


find . -type f -exec sed -i 's/<html>/<!DOCTYPE html>\n<html>/g' {} +
find . -type f -exec sed -i 's/<!DOCTYPE HTML PUBLIC "-\/\/W3C\/\/DTD HTML 4.0 Transitional\/\/EN">/<!DOCTYPE html>/g' {} +

find . -type f -exec sed -i 's/HEAD>/head>/g' {} +
find . -type f -exec sed -i 's/CENTER/center/g' {} +
find . -type f -exec sed -i 's/<IMG/<img/g' {} +
find . -type f -exec sed -i 's/TABLE/table/g' {} +
find . -type f -exec sed -i 's/TR/tr/g' {} +
find . -type f -exec sed -i 's/TD/td/g' {} +
find . -type f -exec sed -i 's/TBODY/tbody/g' {} +
find . -type f -exec sed -i 's/BR/br/g' {} +
find . -type f -exec sed -i 's/DIV/div/g' {} +
find . -type f -exec sed -i 's/FONT/font/g' {} +
find . -type f -exec sed -i 's/<INPUT/<input/g' {} +
find . -type f -exec sed -i 's/WEIGHT/weight/g' {} +
find . -type f -exec sed -i 's/<SCRIPT/<script/g' {} +
find . -type f -exec sed -i 's/SCRIPT>/script>/g' {} +
find . -type f -exec sed -i 's/BODY>/body>/g' {} +
find . -type f -exec sed -i 's/HTML>/html>/g' {} +
find . -type f -exec sed -i 's/FRAMESET/frameset/g' {} +
find . -type f -exec sed -i 's/FRAME/frame/g' {} +
find . -type f -exec sed -i 's/NOFRAME/noframe/g' {} +
find . -type f -exec sed -i 's/TITLE>/title>/g' {} +
find . -type f -exec sed -i 's/<META/<meta/g' {} +
find . -type f -exec sed -i 's/<STYLE/<style/g' {} +
find . -type f -exec sed -i 's/<\/STYLE>/<\/style>/g' {} +

find . -type f -exec sed -i 's/<! Copyright/<!-- Copyright/g' {} +
find . -type f -exec sed -i 's/Reserved. ->/Reserved. -->/g' {} +
find . -type f -exec sed -i 's/<!-->/<!-- html syntax update by Anime4000 -->/g' {} +
find . -type f -exec sed -i '1N;$!N;s/<style type=text\/css>\n@import url(..\/style\/default.css);\n<\/style>//I;P;D' {} +
find . -type f -exec sed -i '1N;$!N;s/<style type=text\/css>\n@import url(\/style\/default.css);\n<\/style>//I;P;D' {} +
find . -type f -exec sed -i 's/<\/title>/<\/title>\n<style type=text\/css>@import url(\/style\/default.css);<\/style>/g' {} +

find . -type f -exec sed -i '/^$/d' {} +
