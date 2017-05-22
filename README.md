# check-mk-toolbox
Verschiedene Scripte fuer die tägliche Arbeit mit Check_mk

==== hosts_wo_service.sh ====

Zeigt Hosts, denen ein bestimmter Service fehlt.

USAGE hosts_wo_service.sh [OPTIONS]

OPTIONS -h Zeigt die Hilfe an -d Name der OMD-Site, wenn nicht im Script festgelegt -s Check_mk Service-Description

BEISPIEL hosts_wo_service.sh -s 'fs_C:/' -d mysite

==== tabularasa_all_failed.sh ====

Fuehrt ein komplettes Re-Inventory von Hosts mit fehlerhaften Services durch. Gilt nicht fuer acknowledged/downtimed services/hosts.

USAGE tabularasa_all_failed.sh [OPTIONS]

OPTIONS -h Zeigt die Hilfe an.
