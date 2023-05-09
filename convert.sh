#! /bin/bash

# convert "college" to "newcollege", or whatever
# the user wants

#---- check usage; give helpful message if wrong ------
PROG=`basename ${0}` 
USAGE="Usage: ./${PROG} <newcollege>"
if [ $# -ne 1 ] ; then 
  echo "Incorrect number of command-line arguments."
  echo ${USAGE}
  exit 1 
fi 
# set NEWC to be whatever the args are
NEWC=$@
#------------------------------------------------------

echo ">> converting ldif files to cs.$NEWC.edu <<"
files=("access.ldif" "addpsinfo.ldif" "base.ldif" \
    "groupofnames.ldif" "ldapbackup" "ldapgroup.sh" \
    "ldapuser.sh" "pwappGROUP.ldif" "ssl.ldif")
for f in ${files[*]};
do
    echo $f
    sed -i 's/college/$NEWC/g' $f
done

