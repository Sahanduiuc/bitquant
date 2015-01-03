#!/bin/bash
# sudo portion of r package installations

echo "Running r installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh

SCRIPT_DIR=$1
ME=$2
R_PKGS="IRdisplay IRkernel Quandl R6 RCurl base64 bitops caTools devtools digest evaluate formatR highr httr jsonlite knitr htmltools httpuv markdown memoise mime Rcpp RJSONIO rmarkdown rstudioapi rzmq stringr uuid whisker xtable xts shiny yaml zoo"
if [ `uname -m` = "x86_64" -o `uname -m` = " x86-64" ]; then
LIBDIR="lib64"
else
LIBDIR="lib"
fi

# Without this the installation will try to put the R library in the
# system directories where it does not have permissions

R_VERSION=$(R --version | head -1 | cut -d \  -f 3 | awk -F \. {'print $1"."$2'})
pushd $SCRIPT_DIR > /dev/null
LOCAL_R_DIR=/home/$ME/R/`uname -m`-mageia-linux-gnu-library/$R_VERSION

echo "Installing new modules"
for i in $R_PKGS ; do
  mv -f $LOCAL_R_DIR/$i /usr/$LIBDIR/R/library ;
done
popd > /dev/null

echo "Installing shiny server"
make -C /home/$ME/git/shiny-server install
ln -s -f  ../lib/shiny-server/bin/shiny-server /usr/bin/shiny-server
#Create shiny user. On some systems, you may need to specify the full path to 'useradd'
useradd -r shiny -s /bin/false -M

# Create log, config, and application directories
mkdir -p /var/log/shiny-server
mkdir -p /var/www/shiny-server
mkdir -p /var/lib/shiny-server
chown shiny /var/log/shiny-server
mkdir -p /etc/shiny-server
cp -r /usr/$LIBDIR/R/library/shiny/examples/*  /var/www/shiny-server

