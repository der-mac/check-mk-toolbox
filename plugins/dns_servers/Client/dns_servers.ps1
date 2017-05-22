################################################################################
#
# title             : dns_servers.ps1
# description       : Check_mk-Plugin, dass die aktuell eingetragenen DNS-Server
#                     ausliest und im Check_mk-Plugin-Format ausgibt
# author            : Martin Schneider (martin@dermac.de)
# date              : 20160211
# version           : 0.3
# usage             : In Plugin-Verzeichnis des Clients kopieren/verteilen
#                     Default: "%ProgramFiles(x86)%\check_mk\plugins"
# notes             : ...
# licence           : Apache License 2.0
#
################################################################################


$IPsets = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | Select DNSServerSearchOrder
$i = 1

Write-Output "<<<dns_servers>>>"
foreach ($IPset in $IPsets) {
  foreach ($DNS_Addresses in $IPset.DNSServerSearchOrder) {
    if ($DNS_Addresses -ne $null) {
      Write-Output "ip$i : $DNS_Addresses"
      $i = $i +1
    }
  }
}

