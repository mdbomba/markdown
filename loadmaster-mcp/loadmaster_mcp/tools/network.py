"""
Network Management Tools

Tools for managing network interfaces, routes, VLANs, DNS, and SNMP on the LoadMaster.
"""

from mcp.server.fastmcp import FastMCP

from ..config import require_client


def register(mcp: FastMCP) -> None:
    """Register network management tools with the MCP server."""

    # --- Interfaces ---

    @mcp.tool()
    def lm_get_interfaces() -> str:
        """Get all network interface configurations on the LoadMaster."""
        client = require_client()
        resp = client.get("showiface")
        return resp.to_text()

    @mcp.tool()
    def lm_set_interface(
        iface: str,
        addr: str = "",
        mtu: str = "",
        gw: str = "",
        admin_wui: str = "",
        geo_traffic: str = "",
        ha_iface: str = "",
    ) -> str:
        """Configure a network interface.

        Args:
            iface: Interface ID (e.g., '0', '1', '2')
            addr: IP address with CIDR (e.g., '10.0.0.10/24')
            mtu: MTU size
            gw: Default gateway
            admin_wui: Enable admin WUI on this interface - 'yes' or 'no'
            geo_traffic: Enable GEO traffic on interface - 'yes' or 'no'
            ha_iface: Use as HA interface - 'yes' or 'no'
        """
        client = require_client()
        params: dict = {"iface": iface}
        if addr:
            params["addr"] = addr
        if mtu:
            params["mtu"] = mtu
        if gw:
            params["gw"] = gw
        if admin_wui:
            params["adminwui"] = admin_wui
        if geo_traffic:
            params["geotraffic"] = geo_traffic
        if ha_iface:
            params["haiface"] = ha_iface
        resp = client.execute("modiface", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_add_additional_address(iface: str, addr: str) -> str:
        """Add an additional IP address to an interface.

        Args:
            iface: Interface ID
            addr: IP address with CIDR (e.g., '192.168.1.100/24')
        """
        client = require_client()
        resp = client.execute("addadditional", params={"iface": iface, "addr": addr})
        return resp.to_text()

    @mcp.tool()
    def lm_delete_additional_address(iface: str, addr: str) -> str:
        """Remove an additional IP address from an interface.

        Args:
            iface: Interface ID
            addr: IP address to remove
        """
        client = require_client()
        resp = client.execute("deladditional", params={"iface": iface, "addr": addr})
        return resp.to_text()

    # --- Routes ---

    @mcp.tool()
    def lm_list_routes() -> str:
        """List all static routes configured on the LoadMaster."""
        client = require_client()
        resp = client.get("showroute")
        return resp.to_text()

    @mcp.tool()
    def lm_add_route(dest: str, mask: str, gw: str) -> str:
        """Add a static route.

        Args:
            dest: Destination network (e.g., '192.168.2.0')
            mask: Subnet mask (e.g., '255.255.255.0')
            gw: Gateway IP address
        """
        client = require_client()
        resp = client.execute("addroute", params={"dest": dest, "mask": mask, "gw": gw})
        return resp.to_text()

    @mcp.tool()
    def lm_delete_route(dest: str, mask: str, gw: str) -> str:
        """Delete a static route.

        Args:
            dest: Destination network
            mask: Subnet mask
            gw: Gateway IP address
        """
        client = require_client()
        resp = client.execute("delroute", params={"dest": dest, "mask": mask, "gw": gw})
        return resp.to_text()

    # --- VLANs ---

    @mcp.tool()
    def lm_add_vlan(iface: str, vlan_id: str, addr: str = "") -> str:
        """Add a VLAN to a network interface.

        Args:
            iface: Parent interface ID
            vlan_id: VLAN ID (1-4094)
            addr: Optional IP address for the VLAN interface
        """
        client = require_client()
        params: dict = {"iface": iface, "vlanid": vlan_id}
        if addr:
            params["addr"] = addr
        resp = client.execute("addvlan", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_delete_vlan(iface: str, vlan_id: str) -> str:
        """Remove a VLAN from a network interface.

        Args:
            iface: Parent interface ID
            vlan_id: VLAN ID to remove
        """
        client = require_client()
        resp = client.execute("delvlan", params={"iface": iface, "vlanid": vlan_id})
        return resp.to_text()

    # --- VxLANs ---

    @mcp.tool()
    def lm_add_vxlan(iface: str, vni: str, addr: str = "") -> str:
        """Add a VxLAN to a network interface.

        Args:
            iface: Parent interface ID
            vni: VxLAN Network Identifier (VNI)
            addr: Optional IP address for the VxLAN interface
        """
        client = require_client()
        params: dict = {"iface": iface, "vni": vni}
        if addr:
            params["addr"] = addr
        resp = client.execute("addvxlan", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_delete_vxlan(iface: str, vni: str) -> str:
        """Remove a VxLAN from a network interface.

        Args:
            iface: Parent interface ID
            vni: VxLAN Network Identifier to remove
        """
        client = require_client()
        resp = client.execute("delvxlan", params={"iface": iface, "vni": vni})
        return resp.to_text()

    # --- Bonding ---

    @mcp.tool()
    def lm_add_bond(iface: str, bond_mode: str = "0") -> str:
        """Create a bonded interface.

        Args:
            iface: Interface ID for the bond
            bond_mode: Bonding mode (0=balance-rr, 1=active-backup, 2=balance-xor,
                       3=broadcast, 4=802.3ad, 5=balance-tlb, 6=balance-alb)
        """
        client = require_client()
        resp = client.execute("addbond", params={"iface": iface, "mode": bond_mode})
        return resp.to_text()

    @mcp.tool()
    def lm_delete_bond(iface: str) -> str:
        """Remove a bonded interface.

        Args:
            iface: Bond interface ID to remove
        """
        client = require_client()
        resp = client.execute("delbond", params={"iface": iface})
        return resp.to_text()

    # --- DNS ---

    @mcp.tool()
    def lm_get_dns() -> str:
        """Get the DNS configuration (nameservers)."""
        client = require_client()
        resp = client.get("get", param="nameserver")
        return resp.to_text()

    @mcp.tool()
    def lm_set_dns(nameserver: str) -> str:
        """Set the DNS nameserver(s).

        Args:
            nameserver: Comma-separated nameserver IPs (e.g., '8.8.8.8,8.8.4.4')
        """
        client = require_client()
        resp = client.execute("set", params={"param": "nameserver", "value": nameserver})
        return resp.to_text()

    # --- Hosts ---

    @mcp.tool()
    def lm_list_hosts() -> str:
        """List all /etc/hosts entries on the LoadMaster."""
        client = require_client()
        resp = client.get("showhosts")
        return resp.to_text()

    @mcp.tool()
    def lm_add_host(ip: str, hostname: str) -> str:
        """Add a hosts entry.

        Args:
            ip: IP address
            hostname: Hostname to associate
        """
        client = require_client()
        resp = client.execute("addhosts", params={"ip": ip, "hostname": hostname})
        return resp.to_text()

    @mcp.tool()
    def lm_delete_host(ip: str, hostname: str) -> str:
        """Remove a hosts entry.

        Args:
            ip: IP address
            hostname: Hostname to remove
        """
        client = require_client()
        resp = client.execute("delhosts", params={"ip": ip, "hostname": hostname})
        return resp.to_text()

    # --- SNMP ---

    @mcp.tool()
    def lm_get_snmp() -> str:
        """Get SNMP configuration."""
        client = require_client()
        resp = client.get("get", param="snmpenable")
        enabled = resp.to_text()
        resp2 = client.get("get", param="snmpcommunity")
        community = resp2.to_text()
        return f"SNMP Enabled:\n{enabled}\n\nSNMP Community:\n{community}"

    @mcp.tool()
    def lm_set_snmp(enable: str = "", community: str = "", contact: str = "", location: str = "") -> str:
        """Configure SNMP settings.

        Args:
            enable: Enable SNMP - 'yes' or 'no'
            community: SNMP community string
            contact: SNMP contact
            location: SNMP location
        """
        client = require_client()
        results = []
        if enable:
            resp = client.execute("set", params={"param": "snmpenable", "value": enable})
            results.append(f"Enable: {resp.to_text()}")
        if community:
            resp = client.execute("set", params={"param": "snmpcommunity", "value": community})
            results.append(f"Community: {resp.to_text()}")
        if contact:
            resp = client.execute("set", params={"param": "snmpcontact", "value": contact})
            results.append(f"Contact: {resp.to_text()}")
        if location:
            resp = client.execute("set", params={"param": "snmplocation", "value": location})
            results.append(f"Location: {resp.to_text()}")
        return "\n".join(results) if results else "No SNMP parameters specified."
