#!/bin/bash
################################################################################
#
# title             : tabularasa_all_failed.sh
# description       : Fuehrt ein komplettes Re-Inventory von Hosts mit
#                     fehlerhaften Services durch.
#                     Gilt nicht fuer acknowledged/downtimed services/hosts
# author            : Martin Schneider
# date              : 20161201
# version           : 0.1
# usage             : ./tabularasa_all_failed.sh -h
# notes             : ...
# licence           : Apache License 2.0
#
################################################################################

# Pfad zu den OMD-Sites
SITEPATH='/opt/omd/sites/'
# Unterverzeichnis des LiveStatus-Socket
LIVEPATH='/tmp/run/live'
# Vorgabe fuer Site-Name
SITEDIR=$OMD_SITE

while getopts "h" Option
  do
    case $Option in
      h )
         echo ""
         echo "Fuehrt ein komplettes Re-Inventory von Hosts mit"
         echo "fehlerhaften Services durch."
         echo "Gilt nicht fuer acknowledged/downtimed services/hosts"
         echo ""
         echo "Usage $0"
         echo ""
         echo "   -h                  Zeigt diese Hilfe an."
         echo ""
         exit
         ;;
    esac
done
shift $(($OPTIND - 1))

LIVESTATUS="${SITEPATH}${SITEDIR}${LIVEPATH}"

# Ohne Livestatus-Socket nicht weitermachen
if [ ! -S ${LIVESTATUS} ]; then
  echo "LiveStatus not found or not a socket! (${LIVESTATUS})"
  exit 1
fi

# Livestatus-Filter
FILTER='Filter: state > 0\nFilter: acknowledged = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0'
# Benoetigte Spalten
COLUMNS='Columns: host_name'

for maschine in `echo -e "GET services\n${COLUMNS}\n${FILTER}\n" | unixcat ${LIVESTATUS} | sort | uniq`; do
  cmk -vII $maschine;
done
