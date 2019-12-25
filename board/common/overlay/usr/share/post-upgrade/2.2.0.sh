#!/bin/bash

##########################################
#
# Update configuration files for machinery
#

KERBEROS_CONFIG_DIR="/etc/opt/kerberosio/config"
DATA_CONFIG_DIR="/data/machinery/config"
TEMP_CONFIG_DIR="/tmp/config"

# Copy files to tmp folder and overwrite data config files

rm -rf $TEMP_CONFIG_DIR
mkdir -p $TEMP_CONFIG_DIR
cp -r $DATA_CONFIG_DIR/* $TEMP_CONFIG_DIR
cp -r $KERBEROS_CONFIG_DIR/* $DATA_CONFIG_DIR

# Loop over old config files and adjust new configuration
# with previous values.

for oldfile in $TEMP_CONFIG_DIR/*
do
	for newfile in $DATA_CONFIG_DIR/*
	do
		if [ ${oldfile#$TEMP_CONFIG_DIR} == ${newfile#$DATA_CONFIG_DIR} ]
		then
			lineNumber=1
			
			while read p
			do
				name=`echo $p | grep -E "\<(.*?)\>(.*?)<(.*?)\>" | cut -d ">" -f1 | cut -d "<" -f2 | cut -d " " -f1`
				value=`echo $p | grep -E "\<(.*?)\>(.*?)<(.*?)\>" | cut -d ">" -f2 | cut -d "<" -f1`

				if [ -n "$name" ]
				then
					#echo "looking for " $name " in " $newfile " with old value " $value

					 while read -r line ; do 
						number=`echo $line | cut -d ':' -f1`
						if [[ $lineNumber -le $number ]]
						then
							newvalue=`echo $line | sed -e "s/^$number:[ \t]*//"`
							if [[ "$p" != "$newvalue" ]]
							then
								sed $number"s#$newvalue#$p#" $newfile > $newfile"_"
								mv $newfile"_" $newfile
							fi
							lineNumber=$number
							break
						fi
					done <<< "$(grep -n "$name " $newfile)"
				fi

			done < $oldfile
		fi
	done
done

chmod -R 777 $DATA_CONFIG_DIR

##########################################
#
# Update configuration files for web
#

cp /var/www/web/app/config/session.php /data/web/app/config/session.php
cp /var/www/web/app/config/app.php /data/web/app/config/app.php
chmod 777 /data/web/app/config/app.php
cp /var/www/web/app/config/kerberos.php /data/web/app/config/kerberos.php
chmod 777 /data/web/app/config/kerberos.php

rm -rf /data/web/app/storage/views/*
rm -rf /data/web/app/storage/sessions/*
