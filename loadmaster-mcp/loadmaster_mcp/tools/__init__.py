"""
Live Query Tools

Tools for querying the current state of a LoadMaster appliance.
"""

from mcp.server.fastmcp import FastMCP

from ..config import require_client


def register(mcp: FastMCP) -> None:
    """Register live query tools with the MCP server."""

    @mcp.tool()
    def lm_get_parameter(param: str) -> str:
        """Get a single LoadMaster parameter value.

        Args:
            param: The parameter name (e.g., 'hostname', 'ntphost', 'hamode',
                   'WUITLSProtocols', 'sessioncontrol')
        """
        client = require_client()
        resp = client.get("get", param=param)
        return resp.to_text()

    @mcp.tool()
    def lm_get_all_parameters() -> str:
        """Get all LoadMaster parameters at once.

        Returns the complete configuration state of the LoadMaster.
        This is a large response - use lm_get_parameter for specific values.
        """
        client = require_client()
        resp = client.get("getall")
        return resp.to_text()

    @mcp.tool()
    def lm_list_virtual_services() -> str:
        """List all virtual services configured on the LoadMaster.

        Returns a summary of all VS entries including their IP, port,
        protocol, status, and nickname.
        """
        client = require_client()
        resp = client.get("listvs")
        return resp.to_text()

    @mcp.tool()
    def lm_show_virtual_service(
        vs: str = "",
        port: str = "",
        prot: str = "",
        vs_index: str = "",
    ) -> str:
        """Get detailed configuration of a specific virtual service.

        Identify the VS by either vs+port+prot OR vs_index.

        Args:
            vs: Virtual service IP address
            port: Virtual service port
            prot: Protocol (tcp or udp)
            vs_index: VS index number (alternative to vs+port+prot)
        """
        client = require_client()
        params = {}
        if vs_index:
            params["vs"] = vs_index
        else:
            if vs:
                params["vs"] = vs
            if port:
                params["port"] = port
            if prot:
                params["prot"] = prot
        resp = client.execute("showvs", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_show_real_server(
        vs: str = "",
        port: str = "",
        prot: str = "",
        rs: str = "",
        rsport: str = "",
        vs_index: str = "",
    ) -> str:
        """Get configuration of a specific real server within a virtual service.

        Args:
            vs: Virtual service IP address
            port: Virtual service port
            prot: Protocol (tcp or udp)
            rs: Real server IP address
            rsport: Real server port
            vs_index: VS index number (alternative to vs+port+prot)
        """
        client = require_client()
        params = {}
        if vs_index:
            params["vs"] = vs_index
        else:
            if vs:
                params["vs"] = vs
            if port:
                params["port"] = port
            if prot:
                params["prot"] = prot
        if rs:
            params["rs"] = rs
        if rsport:
            params["rsport"] = rsport
        resp = client.execute("showrs", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_list_api() -> str:
        """List all available API commands on the LoadMaster.

        Returns the full list of supported API endpoints and the API version.
        """
        client = require_client()
        resp = client.get("listapi")
        return resp.to_text()

    @mcp.tool()
    def lm_test_connection() -> str:
        """Test connectivity to the configured LoadMaster.

        Verifies that the MCP server can reach the LoadMaster and
        authenticate successfully.
        """
        client = require_client()
        resp = client.test_connection()
        if resp.success:
            return f"Connection successful to {client.host}:{client.port}\n\n{resp.to_text()}"
        else:
            return f"Connection FAILED to {client.host}:{client.port}\n\n{resp.to_text()}"

    @mcp.tool()
    def lm_connection_info() -> str:
        """Show the current LoadMaster connection configuration.

        Displays the configured host, port, auth method, and connection status.
        Does NOT reveal passwords or API keys.
        """
        from ..config import connection_status
        return connection_status()
