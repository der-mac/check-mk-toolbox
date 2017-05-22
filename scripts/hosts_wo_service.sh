#!/bin/bash
################################################################################
#
# title             : hosts_wo_service.sh
# description       : Zeigt Hosts, denen ein bestimmter Service fehlt.
# author            : Martin Schneider (martin@dermac.de)
# date              : 20160324
# version           : 0.2
# usage             : ./hosts_wo_service.sh -h
# notes             : ...
# licence           : Apache License 2.0
#
################################################################################

# Pfad zu den OMD-Sites
SITEPATH='/opt/omd/sites/'
# Unterverzeichnis des LiveStatus-Socket
LIVEPATH='/tmp/run/live'
# Vorgabe fuer Site-Name, oder leer (wenn leer, dann per Option '-d' angegeben)
SITEDIR=$OMD_SITE

while getopts "hd:s:" Option
  do
    case $Option in
      d )
         SITEDIR=${OPTARG}
         ;;
      s )
         SERVICE=${OPTARG}
         ;;
      h )
         echo ""
         echo "Zeigt Hosts, denen ein bestimmter Service fehlt."
         echo ""
         echo "Usage $0 -s '<service_description>' [-d <site_name>]"
         echo ""
         echo "   -h                  Zeigt diese Hilfe an"
         echo "   -d                  Name der OMD-Site, wenn nicht im Script festgelegt"
         echo "   -s                  Check_mk Service-Description"
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

# Ohne Servicename nicht weitermachen
if [ -z ${SERVICE} ]; then
  echo "Kein Service angegeben!"
  exit 1
fi

# Alle Hosts einlesen
for host in `echo -e "GET hosts\nColumns: host_name" | unixcat /opt/omd/sites/haba_global/tmp/run/live | sort`; do
  # Alle Services eines Hosts einlesen und nach dem gewuenschten Service suchen
  if ( ! echo -e "GET hosts\nColumns: services\nFilter:host_name = ${host}\nLimit: 1" | unixcat /opt/omd/sites/haba_global/tmp/run/live | grep "${SERVICE}" >/dev/null 2>&1 ); then
    echo "${host}"
  fi
done
