# check-mk-toolbox
Verschiedene Scripte fuer die tägliche Arbeit mit Check_mk


## scripts/hosts_wo_service.sh

Zeigt Hosts, denen ein bestimmter Service fehlt.

### USAGE
    hosts_wo_service.sh [OPTIONS]

### OPTIONS
    -h Zeigt die Hilfe an
    -d Name der OMD-Site, wenn nicht im Script festgelegt
    -s Check_mk Service-Description

### BEISPIEL
    hosts_wo_service.sh -s 'fs_C:/' -d mysite


## scripts/tabularasa_all_failed.sh

Fuehrt ein komplettes Re-Inventory von Hosts mit fehlerhaften Services durch.
Gilt nicht fuer acknowledged/downtimed services/hosts.

### USAGE
    tabularasa_all_failed.sh [OPTIONS]

### OPTIONS
    -h Zeigt die Hilfe an.

## plugins/dns_servers

Check_mk-Plugin, dass die aktuell eingetragenen DNS-Server ausliest und im Check_mk-Plugin-Format ausgibt.
Auf Serverseite werden die ausgegebenen DNS-Server gegen eine Liste zulaessiger IPs geprueft.

### USAGE
    Plugin-Files in die jeweiligen Verzeichnisse kopieren

### PARAMETER
    Im Serverfile kann die IP-Liste 'dns_servers_values' angepasst werden.
	Format: dns_servers_values = ('8.8.8.8', '8.8.4.4' )
