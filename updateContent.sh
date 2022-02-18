#!/bin/sh
SUBDIRS='reg chat adult php'
cd /web/content
## Disable the timestamp if [ -f /tmp/timestamp ]
if [ -f imestamp ]
then
	touch /tmp/timestamp
	find $SUBDIRS -type f -name "*.php" -newer /tmp/timestamp -print >/tmp/contentList
	find php -type f -name "*.phpi" -newer /tmp/timestamp -print >>/tmp/contentList
	find $SUBDIRS -type f -name "*.html" -newer /tmp/timestamp -print >>/tmp/contentList
	find $SUBDIRS -type f -name "*.txt" -newer /tmp/timestamp -print >>/tmp/contentList
else
	touch /tmp/timestamp
	find $SUBDIRS -type f -name "*.php" -print >/tmp/contentList
	find php -type f -name "*.phpi" -print >>/tmp/contentList
	find $SUBDIRS -type f -name "*.html" -print >>/tmp/contentList
	find $SUBDIRS -type f -name "*.txt" -print >>/tmp/contentList
fi
for i in `cat /tmp/contentList`
do
	cp $i /web/$i.tmp
	mv /web/$i.tmp /web/$i
done
rm -f /tmp/contentList
