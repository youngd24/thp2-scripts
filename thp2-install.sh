#!/bin/bash
###############################################################################
# thp2-install.sh
#
# The Hackers Playbook 2 Installer Script
#
###############################################################################
#
# USAGE:
#
###############################################################################
#
# KNOWN ISSUES:
#
###############################################################################

# "Global" variables
LOGFILE=""
DEBUG="false"

###############################################################################
#                           F U N C T I O N S 
###############################################################################

###
debug()
{
    message=$1
    if [ $DEBUG == "true" ]; then
        echo "DEBUG: $message"
    fi
    return
}

###
usage()
{
    echo "Usage:"
    echo ""
    echo "  -d            - enable debug"
    echo "  -h            - get help (this screen)"
    echo "  -l <logfile>  - log to file <logfile>"
    echo ""
    return
}


###############################################################################
#                  O S   D E T E C T I O N   &   S E T U P 
###############################################################################
OS=$(uname -s)
case $OS in
    "Linux")
        debug "Running on Linux"
        ;;
    "Darwin")
        debug "Running on OS/X"
        ;;
    *)
        echo "Unsupported OS ($OS), exiting"
        exit 0
esac


###############################################################################
#              C O M M A N D   L I N E   A R G U M E N T S 
###############################################################################
while getopts dhl: option
do
 case "$option" in
    d)  DEBUG="true"
        debug "Debugging enabled"
        ;;
    h)  usage
        exit 1
        ;;
    l)  LOGFILE=$OPTARG
        debug "Logfile set to $LOGFILE"
        ;;
    *)
        echo "Invalid argument"
        echo ""
        usage
        exit
        ;;
     esac
done



### See if the necessary commands are present

exit


git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /opt/recon-ng 

git clone https://github.com/leebaird/discover.git /opt/discover

cd /opt/discover
./update.sh 



###############################################################################
# B e E F
###############################################################################

###
# Install RVM for beef (https://rvm.io/)
# not mentioned in the book and is necessary for some of the packages to be installed correctly
curl -sSL https://get.rvm.io | bash -s stable
export PATH=$PATH:/usr/local/rvm/bin

###
#cd /opt/
#wget https://raw.github.com/beefproject/beef/a6a7536e/install-beef
#chmod +x install-beef
#./install-beef
cd /opt
wget https://raw.githubusercontent.com/beefproject/beef/master/install-beef
cat install-beef | sed -e 's/libreadline6//' > install-beef.new
chmod +x install-beef.new
