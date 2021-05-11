#!/bin/bash

# script to convert /etc/group file into LDAP ldif format

SUFFIX='dc=cs,dc=college,dc=edu'
LDIF='ldapgroup.ldif'

# made a copy of the /etc/group file and took out system groups
GRP=./mygroup  

echo -n > $LDIF
for line in `cat $GRP`
do
    CN=`echo $line | cut -d: -f1`
    GID=`echo $line | cut -d: -f3`
    echo "dn: cn=$CN,ou=groups,$SUFFIX" >> $LDIF
    echo "objectClass: posixGroup" >> $LDIF
    echo "cn: $CN" >> $LDIF
    echo "gidNumber: $GID" >> $LDIF
    users=`echo $line | cut -d: -f4 | sed "s/,/ /g"`
    for user in ${users} ; do
        echo "memberUid: ${user}" >> $LDIF
    done
    echo >> $LDIF
done
