"""
VPN (IPsec) Tools

Tools for managing VPN connections on the LoadMaster.
"""

from mcp.server.fastmcp import FastMCP

from ..config import require_client


def register(mcp: FastMCP) -> None:
    """Register VPN tools with the MCP server."""

    @mcp.tool()
    def lm_vpn_get_status() -> str:
        """Get the IKE daemon status and all VPN connections."""
        client = require_client()
        resp = client.get("getvpnstatus")
        return resp.to_text()

    @mcp.tool()
    def lm_vpn_list_connections() -> str:
        """List all configured VPN connections."""
        client = require_client()
        resp = client.get("listvpns")
        return resp.to_text()

    @mcp.tool()
    def lm_vpn_get_connection(name: str) -> str:
        """Get detailed configuration of a VPN connection.

        Args:
            name: VPN connection name
        """
        client = require_client()
        resp = client.execute("showvpn", params={"name": name})
        return resp.to_text()

    @mcp.tool()
    def lm_vpn_add_connection(
        name: str,
        local_ip: str = "",
        local_subnets: str = "",
        remote_ip: str = "",
        remote_subnets: str = "",
        psk: str = "",
        ike_version: str = "",
        extra_params: str = "",
    ) -> str:
        """Create a new VPN connection.

        Args:
            name: VPN connection name
            local_ip: Local IP address for the VPN tunnel
            local_subnets: Local subnets (comma-separated CIDR)
            remote_ip: Remote peer IP address
            remote_subnets: Remote subnets (comma-separated CIDR)
            psk: Pre-shared key
            ike_version: IKE version ('1' or '2')
            extra_params: Additional params as 'key1=val1&key2=val2'
        """
        client = require_client()
        params: dict = {"name": name}
        if local_ip:
            params["localip"] = local_ip
        if local_subnets:
            params["localsubnets"] = local_subnets
        if remote_ip:
            params["remoteip"] = remote_ip
        if remote_subnets:
            params["remotesubnets"] = remote_subnets
        if psk:
            params["psk"] = psk
        if ike_version:
            params["ikeversion"] = ike_version

        if extra_params:
            for pair in extra_params.split("&"):
                if "=" in pair:
                    k, v = pair.split("=", 1)
                    params[k.strip()] = v.strip()

        resp = client.execute("addvpn", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_vpn_modify_connection(
        name: str,
        local_ip: str = "",
        local_subnets: str = "",
        remote_ip: str = "",
        remote_subnets: str = "",
        psk: str = "",
        ike_version: str = "",
        extra_params: str = "",
    ) -> str:
        """Modify an existing VPN connection.

        Args:
            name: VPN connection name to modify
            local_ip: Local IP address
            local_subnets: Local subnets (comma-separated CIDR)
            remote_ip: Remote peer IP address
            remote_subnets: Remote subnets (comma-separated CIDR)
            psk: Pre-shared key
            ike_version: IKE version ('1' or '2')
            extra_params: Additional params as 'key1=val1&key2=val2'
        """
        client = require_client()
        params: dict = {"name": name}
        if local_ip:
            params["localip"] = local_ip
        if local_subnets:
            params["localsubnets"] = local_subnets
        if remote_ip:
            params["remoteip"] = remote_ip
        if remote_subnets:
            params["remotesubnets"] = remote_subnets
        if psk:
            params["psk"] = psk
        if ike_version:
            params["ikeversion"] = ike_version

        if extra_params:
            for pair in extra_params.split("&"):
                if "=" in pair:
                    k, v = pair.split("=", 1)
                    params[k.strip()] = v.strip()

        resp = client.execute("modvpn", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_vpn_delete_connection(name: str) -> str:
        """Delete a VPN connection.

        WARNING: This removes the VPN tunnel configuration.

        Args:
            name: VPN connection name to delete
        """
        client = require_client()
        resp = client.execute("delvpn", params={"name": name})
        return resp.to_text()

    @mcp.tool()
    def lm_vpn_start_connection(name: str) -> str:
        """Start/activate a VPN connection.

        Args:
            name: VPN connection name to start
        """
        client = require_client()
        resp = client.execute("startvpn", params={"name": name})
        return resp.to_text()

    @mcp.tool()
    def lm_vpn_stop_connection(name: str) -> str:
        """Stop/deactivate a VPN connection.

        Args:
            name: VPN connection name to stop
        """
        client = require_client()
        resp = client.execute("stopvpn", params={"name": name})
        return resp.to_text()
