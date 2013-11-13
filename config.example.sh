#!/bin/bash
# Change settings in here and save as config.sh
SITES="Marena Elreno Elreno_iGOS_East"

SCRIPTPATH=.

SSHKEY=/home/username/.ssh/some_passwordless_key
RSYNCSOURCE=host.com:/path/to/ftp/dropzone
RSYNCTARGET=/path/to/www/static
CATALOGSERVER=http://production.cybercommons.org/catalog/db_find
NDAYS=3 # Number of days to check for new files

# Cataloging settings
CCDC_USERNAME=cataloguser
CCDC_PASSWORD=catalogpassword
CATALOGWS="http://production.cybercommons.org/catalog/save/"
AUTHLOC="http://test.cybercommons.org/accounts/login/"
