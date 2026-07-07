# GEO / Global Server Load Balancing

Global DNS-based load balancing (GSLB) for multi-site deployments. Manages FQDNs, clusters, site mappings, IP ranges, custom locations, and DNSSEC.

## Commands (64)

| Command | Description |
|---------|-------------|
| [`access/showdomain`](access-showdomain.md) | Retrieves samldomain |
| [`access/adddomain`](access-adddomain.md) | Creates ssodomain |
| [`access/deldomain`](access-deldomain.md) | Removes ssodomain |
| [`access/moddomain`](access-moddomain.md) | Updates samlspentity |
| [`access/listfqdns`](access-listfqdns.md) | Lists fqdns |
| [`access/addfqdn`](access-addfqdn.md) | Creates GEO FQDN |
| [`access/showfqdn`](access-showfqdn.md) | Shows FQDN |
| [`access/modfqdn`](access-modfqdn.md) | Updates GEO FQDN |
| [`access/delfqdn`](access-delfqdn.md) | Removes GEO FQDN |
| [`access/addmap`](access-addmap.md) | Creates GEO FQDN site address |
| [`access/modmap`](access-modmap.md) | Updates GEO FQDN site address |
| [`access/delmap`](access-delmap.md) | Removes GEO FQDN site address |
| [`access/addrr`](access-addrr.md) | Creates GEO FQDN resource record |
| [`access/modrr`](access-modrr.md) | Updates GEO FQDN resource record |
| [`access/delrr`](access-delrr.md) | Removes GEO FQDN resource record |
| [`access/listips`](access-listips.md) | Lists ips |
| [`access/showip`](access-showip.md) | Shows IP |
| [`access/addip`](access-addip.md) | Creates GEO IP range |
| [`access/delip`](access-delip.md) | Removes GEO IP range |
| [`access/modiploc`](access-modiploc.md) | Updates GEO IP range coordinates |
| [`access/deliploc`](access-deliploc.md) | Removes GEO IP range coordinates |
| [`access/addipcountry`](access-addipcountry.md) | Updates GEO IP range custom location |
| [`access/removeipcountry`](access-removeipcountry.md) | Removes GEO IP range country |
| [`access/addcountry`](access-addcountry.md) | Updates GEO FQDN site country |
| [`access/removecountry`](access-removecountry.md) | Removes GEO FQDN site country |
| [`access/geochangecheckermapping`](access-geochangecheckermapping.md) | Updates GEO FQDN site mapping |
| [`access/changecheckeraddr`](access-changecheckeraddr.md) | Updates GEO FQDN site checker address |
| [`access/changemaploc`](access-changemaploc.md) | Updates GEO FQDN site coordinates |
| [`access/listclusters`](access-listclusters.md) | Lists clusters |
| [`access/showcluster`](access-showcluster.md) | Shows cluster |
| [`access/addcluster`](access-addcluster.md) | Creates GEO cluster |
| [`access/delcluster`](access-delcluster.md) | Removes GEO cluster |
| [`access/modcluster`](access-modcluster.md) | Updates GEO cluster |
| [`access/clustchangeloc`](access-clustchangeloc.md) | Updates GEO cluster coordinates |
| [`access/listparams`](access-listparams.md) | Retrieves GEO misc parameter |
| [`access/modparams`](access-modparams.md) | Updates GEO misc parameter |
| [`access/locdataupdate`](access-locdataupdate.md) | Updates GEO database |
| [`access/getgeopartnerstatus`](access-getgeopartnerstatus.md) | Retrieves GEO partner status |
| [`access/enablegeo`](access-enablegeo.md) | Enables lm GEO pack |
| [`access/disablegeo`](access-disablegeo.md) | Disables lm GEO pack |
| [`access/isgeoenabled`](access-isgeoenabled.md) | Tests lm GEO enabled |
| [`access/geoacl`](access-geoacl.md) | Handles geoacl |
| [`access/geoacl.getsettings`](access-geoacl.getsettings.md) | Retrieves the IP access list settings |
| [`access/geoacl.setautoupdate`](access-geoacl.setautoupdate.md) | Enables or disables automatic IP access list updates |
| [`access/geoacl.setautoinstall`](access-geoacl.setautoinstall.md) | Enables or disables automatic installation of IP access list updates |
| [`access/geoacl.setinstalltime`](access-geoacl.setinstalltime.md) | Sets the time of the automatic installation |
| [`access/geoacl.updatenow`](access-geoacl.updatenow.md) | Downloads the IP access list updates now |
| [`access/geoacl.installnow`](access-geoacl.installnow.md) | Installs downloaded IP access list updates now |
| [`access/geoacl.downloadlist`](access-geoacl.downloadlist.md) | Retrieves the IP access list |
| [`access/geoacl.downloadchanges`](access-geoacl.downloadchanges.md) | Retrieves changes to the IP access list |
| [`access/geoacl.listcustom`](access-geoacl.listcustom.md) | Retrieves the user-defined allow list |
| [`access/geoacl.addcustom`](access-geoacl.addcustom.md) | Adds an IP address or network to the allow list |
| [`access/geoacl.removecustom`](access-geoacl.removecustom.md) | Removes an IP address or network from the allow list |
| [`access/geostats`](access-geostats.md) | Retrieves GEO statistics |
| [`access/geogenerateksk`](access-geogenerateksk.md) | Creates GEO dnsseckey signing key |
| [`access/geoimportksk`](access-geoimportksk.md) | Handles geoimportksk |
| [`access/geodeleteksk`](access-geodeleteksk.md) | Removes GEO dnsseckey signing key |
| [`access/geosetdnssec`](access-geosetdnssec.md) | Updates GEO dnssecstatus |
| [`access/geoshowdnssec`](access-geoshowdnssec.md) | Retrieves GEO dnssecconfiguration |
| [`access/set_geo_failover`](access-set_geo_failover.md) | Sets GEO failover |
| [`access/listcustomlocation`](access-listcustomlocation.md) | Retrieves GEO custom location |
| [`access/addcustomlocation`](access-addcustomlocation.md) | Creates GEO custom location |
| [`access/editcustomlocation`](access-editcustomlocation.md) | Updates GEO custom location |
| [`access/deletecustomlocation`](access-deletecustomlocation.md) | Removes GEO custom location |
