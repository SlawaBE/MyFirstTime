#!/bin/bash

REPOSITORY='git@github.com:SlawaBE/MyFirstTime.git'
TMPLOG=/tmp/tmplog
ORIGINLOG=/var/lib/cicd/originlog

pushd /tmp

git clone $REPOSITORY
cd MyFirstTime

git log > $TMPLOG

diff $TMPLOG $ORIGINLOG > /dev/null

if [ $? != 0 ] ; then
	
	/usr/bin/ansible-playbook /root/my_playbooks/cicd.yml

	cp $TMPLOG $ORIGINLOG
fi

popd

rm -rf /tmp/MyFirstTime
rm -f $TMPLOG

exit
