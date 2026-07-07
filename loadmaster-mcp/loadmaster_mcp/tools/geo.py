"""
GEO/GSLB Tools

Tools for managing Global Server Load Balancing (GEO) on the LoadMaster.
"""

from mcp.server.fastmcp import FastMCP

from ..config import require_client


def register(mcp: FastMCP) -> None:
    """Register GEO/GSLB tools with the MCP server."""

    @mcp.tool()
    def lm_geo_is_enabled() -> str:
        """Check if GEO load balancing is enabled on the LoadMaster."""
        client = require_client()
        resp = client.get("get", param="geoenabled")
        return resp.to_text()

    # --- FQDN Management ---

    @mcp.tool()
    def lm_geo_list_fqdns() -> str:
        """List all GEO FQDNs configured on the LoadMaster."""
        client = require_client()
        resp = client.get("listfqdns")
        return resp.to_text()

    @mcp.tool()
    def lm_geo_add_fqdn(
        fqdn: str,
        selection_criteria: str = "rr",
        site_failure_delay: str = "",
        failover: str = "",
        public_request: str = "",
        private_request: str = "",
    ) -> str:
        """Create a new GEO FQDN entry.

        Selection Criteria:
          rr = RoundRobin
          wrr = WeightedRoundRobin
          fw = FixedWeighting
          rsr = RealServerLoad
          prx = Proximity
          lb = LocationBased
          all = AllAvailable

        Args:
            fqdn: The fully qualified domain name
            selection_criteria: Load balancing method (default: rr)
            site_failure_delay: Delay before marking site as failed (seconds)
            failover: Enable failover - 'Y' or 'N'
            public_request: Public request URI
            private_request: Private request URI
        """
        client = require_client()
        params: dict = {"fqdn": fqdn, "SelectionCriteria": selection_criteria}
        if site_failure_delay:
            params["SiteFailureDelay"] = site_failure_delay
        if failover:
            params["Failover"] = failover
        if public_request:
            params["PublicRequest"] = public_request
        if private_request:
            params["PrivateRequest"] = private_request
        resp = client.execute("addfqdn", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_geo_modify_fqdn(
        fqdn: str,
        selection_criteria: str = "",
        site_failure_delay: str = "",
        failover: str = "",
        public_request: str = "",
        private_request: str = "",
    ) -> str:
        """Modify a GEO FQDN configuration.

        Args:
            fqdn: The FQDN to modify
            selection_criteria: Load balancing method (rr, wrr, fw, rsr, prx, lb, all)
            site_failure_delay: Delay before marking site failed (seconds)
            failover: Enable failover - 'Y' or 'N'
            public_request: Public request URI
            private_request: Private request URI
        """
        client = require_client()
        params: dict = {"fqdn": fqdn}
        if selection_criteria:
            params["SelectionCriteria"] = selection_criteria
        if site_failure_delay:
            params["SiteFailureDelay"] = site_failure_delay
        if failover:
            params["Failover"] = failover
        if public_request:
            params["PublicRequest"] = public_request
        if private_request:
            params["PrivateRequest"] = private_request
        resp = client.execute("modfqdn", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_geo_delete_fqdn(fqdn: str) -> str:
        """Delete a GEO FQDN entry.

        WARNING: This removes the FQDN and all associated site mappings.

        Args:
            fqdn: The FQDN to delete
        """
        client = require_client()
        resp = client.execute("delfqdn", params={"fqdn": fqdn})
        return resp.to_text()

    @mcp.tool()
    def lm_geo_show_fqdn(fqdn: str) -> str:
        """Get detailed configuration of a GEO FQDN.

        Args:
            fqdn: The FQDN to query
        """
        client = require_client()
        resp = client.execute("showfqdn", params={"fqdn": fqdn})
        return resp.to_text()

    # --- Cluster Management ---

    @mcp.tool()
    def lm_geo_list_clusters() -> str:
        """List all GEO clusters."""
        client = require_client()
        resp = client.get("listclusters")
        return resp.to_text()

    @mcp.tool()
    def lm_geo_add_cluster(
        cluster: str,
        ip: str,
        site: str = "",
    ) -> str:
        """Create a new GEO cluster.

        Args:
            cluster: Cluster name
            ip: Cluster IP address
            site: Site name for the cluster
        """
        client = require_client()
        params: dict = {"clust": cluster, "ip": ip}
        if site:
            params["site"] = site
        resp = client.execute("addcluster", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_geo_delete_cluster(cluster: str) -> str:
        """Delete a GEO cluster.

        Args:
            cluster: Cluster name to delete
        """
        client = require_client()
        resp = client.execute("delcluster", params={"clust": cluster})
        return resp.to_text()

    @mcp.tool()
    def lm_geo_modify_cluster(
        cluster: str,
        ip: str = "",
        site: str = "",
    ) -> str:
        """Modify a GEO cluster.

        Args:
            cluster: Cluster name to modify
            ip: New cluster IP address
            site: New site name
        """
        client = require_client()
        params: dict = {"clust": cluster}
        if ip:
            params["ip"] = ip
        if site:
            params["site"] = site
        resp = client.execute("modcluster", params=params)
        return resp.to_text()

    # --- Site Mappings ---

    @mcp.tool()
    def lm_geo_set_site_address(fqdn: str, site: str, address: str) -> str:
        """Map a site address to a GEO FQDN.

        Args:
            fqdn: The FQDN to map
            site: Site name
            address: Site IP address
        """
        client = require_client()
        resp = client.execute(
            "addfqdnmap",
            params={"fqdn": fqdn, "site": site, "addr": address},
        )
        return resp.to_text()

    @mcp.tool()
    def lm_geo_delete_site_address(fqdn: str, site: str, address: str) -> str:
        """Remove a site address mapping from a GEO FQDN.

        Args:
            fqdn: The FQDN
            site: Site name
            address: Site IP address to remove
        """
        client = require_client()
        resp = client.execute(
            "delfqdnmap",
            params={"fqdn": fqdn, "site": site, "addr": address},
        )
        return resp.to_text()

    # --- Custom Locations & IP Ranges ---

    @mcp.tool()
    def lm_geo_list_custom_locations() -> str:
        """List all custom GEO locations."""
        client = require_client()
        resp = client.get("listcustomlocation")
        return resp.to_text()

    @mcp.tool()
    def lm_geo_add_custom_location(location: str) -> str:
        """Add a custom GEO location.

        Args:
            location: Location name
        """
        client = require_client()
        resp = client.execute("addcustomlocation", params={"location": location})
        return resp.to_text()

    @mcp.tool()
    def lm_geo_delete_custom_location(location: str) -> str:
        """Delete a custom GEO location.

        Args:
            location: Location name to delete
        """
        client = require_client()
        resp = client.execute("removecustomlocation", params={"location": location})
        return resp.to_text()

    @mcp.tool()
    def lm_geo_add_ip_range(ip_range: str, location: str) -> str:
        """Add an IP range to a GEO location.

        Args:
            ip_range: IP range (e.g., '192.168.1.0-192.168.1.255')
            location: Location to assign the range to
        """
        client = require_client()
        resp = client.execute(
            "addiprange",
            params={"iprange": ip_range, "location": location},
        )
        return resp.to_text()

    @mcp.tool()
    def lm_geo_delete_ip_range(ip_range: str) -> str:
        """Remove an IP range.

        Args:
            ip_range: IP range to remove
        """
        client = require_client()
        resp = client.execute("removeiprange", params={"iprange": ip_range})
        return resp.to_text()

    # --- GEO Misc ---

    @mcp.tool()
    def lm_geo_get_misc_params() -> str:
        """Get miscellaneous GEO parameters (SOA, zone, nameserver, email)."""
        client = require_client()
        resp = client.get("getgeomisc")
        return resp.to_text()

    @mcp.tool()
    def lm_geo_get_statistics() -> str:
        """Get GEO load balancing statistics."""
        client = require_client()
        resp = client.get("geostatistics")
        return resp.to_text()

    @mcp.tool()
    def lm_geo_get_partner_status() -> str:
        """Get GEO partner status."""
        client = require_client()
        resp = client.get("geopartnerstatus")
        return resp.to_text()
