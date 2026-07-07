"""
Content Rules Tools

Tools for managing Layer 7 content rules on the LoadMaster.
"""

from mcp.server.fastmcp import FastMCP

from ..config import require_client


def register(mcp: FastMCP) -> None:
    """Register content rules tools with the MCP server."""

    @mcp.tool()
    def lm_list_rules() -> str:
        """List all content rules configured on the LoadMaster."""
        client = require_client()
        resp = client.get("showrule")
        return resp.to_text()

    @mcp.tool()
    def lm_get_rule(rule: str) -> str:
        """Get the details of a specific content rule.

        Args:
            rule: The rule name
        """
        client = require_client()
        resp = client.execute("showrule", params={"name": rule})
        return resp.to_text()

    @mcp.tool()
    def lm_add_rule(
        name: str,
        rule_type: str = "0",
        pattern: str = "",
        replacement: str = "",
        header: str = "",
        only_on_flag: str = "",
    ) -> str:
        """Create a new content rule.

        Rule types:
          0 = MatchContentRule (matches header/URL pattern)
          1 = AddHeaderRule (adds a header to request/response)
          2 = DeleteHeaderRule (removes a header)
          3 = ReplaceHeaderRule (replaces header content)
          4 = ModifyUrlRule (modifies the URL)
          5 = ReplaceBodyRule (replaces body content)

        Args:
            name: Rule name (unique identifier)
            rule_type: Rule type number (0-5, see above)
            pattern: Match pattern (regex for match rules)
            replacement: Replacement string (for replace rules)
            header: Header name (for header rules)
            only_on_flag: Only apply when flag is not set - 'Y' or 'N'
        """
        client = require_client()
        params: dict = {"name": name, "type": rule_type}
        if pattern:
            params["Pattern"] = pattern
        if replacement:
            params["Replacement"] = replacement
        if header:
            params["Header"] = header
        if only_on_flag:
            params["OnlyOnNoFlag"] = only_on_flag
        resp = client.execute("addrule", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_modify_rule(
        name: str,
        pattern: str = "",
        replacement: str = "",
        header: str = "",
        only_on_flag: str = "",
    ) -> str:
        """Modify an existing content rule.

        Args:
            name: Rule name to modify
            pattern: New match pattern
            replacement: New replacement string
            header: New header name
            only_on_flag: Only apply when flag is not set - 'Y' or 'N'
        """
        client = require_client()
        params: dict = {"name": name}
        if pattern:
            params["Pattern"] = pattern
        if replacement:
            params["Replacement"] = replacement
        if header:
            params["Header"] = header
        if only_on_flag:
            params["OnlyOnNoFlag"] = only_on_flag
        resp = client.execute("modrule", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_delete_rule(name: str) -> str:
        """Delete a content rule.

        WARNING: Ensure the rule is not assigned to any virtual service.

        Args:
            name: Rule name to delete
        """
        client = require_client()
        resp = client.execute("delrule", params={"name": name})
        return resp.to_text()

    @mcp.tool()
    def lm_assign_rule_to_vs(
        rule: str,
        vs: str = "",
        port: str = "",
        prot: str = "",
        vs_index: str = "",
    ) -> str:
        """Assign a content rule to a virtual service.

        Args:
            rule: Rule name to assign
            vs: Virtual service IP address
            port: Virtual service port
            prot: Protocol (tcp or udp)
            vs_index: VS index number (alternative to vs+port+prot)
        """
        client = require_client()
        params: dict = {"rule": rule}
        if vs_index:
            params["vs"] = vs_index
        else:
            if vs:
                params["vs"] = vs
            if port:
                params["port"] = port
            if prot:
                params["prot"] = prot
        resp = client.execute("addrsrule", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_remove_rule_from_vs(
        rule: str,
        vs: str = "",
        port: str = "",
        prot: str = "",
        vs_index: str = "",
    ) -> str:
        """Remove a content rule from a virtual service.

        Args:
            rule: Rule name to remove
            vs: Virtual service IP address
            port: Virtual service port
            prot: Protocol (tcp or udp)
            vs_index: VS index number (alternative to vs+port+prot)
        """
        client = require_client()
        params: dict = {"rule": rule}
        if vs_index:
            params["vs"] = vs_index
        else:
            if vs:
                params["vs"] = vs
            if port:
                params["port"] = port
            if prot:
                params["prot"] = prot
        resp = client.execute("delrsrule", params=params)
        return resp.to_text()
