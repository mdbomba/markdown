"""
High Availability Tools

Tools for managing HA configuration on the LoadMaster.
"""

from mcp.server.fastmcp import FastMCP

from ..config import require_client


def register(mcp: FastMCP) -> None:
    """Register HA management tools with the MCP server."""

    @mcp.tool()
    def lm_get_ha_status() -> str:
        """Get the current HA mode and configuration."""
        client = require_client()
        resp = client.get("get", param="hamode")
        mode = resp.to_text()
        resp2 = client.get("get", param="haprefered")
        preferred = resp2.to_text()
        resp3 = client.get("get", param="partner")
        partner = resp3.to_text()
        return f"HA Mode:\n{mode}\n\nPreferred Host:\n{preferred}\n\nPartner:\n{partner}"

    @mcp.tool()
    def lm_set_ha_mode(
        hamode: str,
        partner: str = "",
        hcp: str = "",
        health_check_port: str = "",
        preferred: str = "",
    ) -> str:
        """Configure High Availability mode.

        HA Modes:
          0 = No HA (single unit)
          1 = First HA
          2 = Second HA

        Args:
            hamode: HA mode (0, 1, or 2)
            partner: Partner IP address
            hcp: Health check port for HA
            health_check_port: Alternative health check port parameter
            preferred: Preferred host (0=no preference, 1=prefer first, 2=prefer second)
        """
        client = require_client()
        results = []

        resp = client.execute("set", params={"param": "hamode", "value": hamode})
        results.append(f"HA Mode: {resp.to_text()}")

        if partner:
            resp = client.execute("set", params={"param": "partner", "value": partner})
            results.append(f"Partner: {resp.to_text()}")
        if hcp:
            resp = client.execute("set", params={"param": "hcp", "value": hcp})
            results.append(f"Health Check Port: {resp.to_text()}")
        if health_check_port:
            resp = client.execute("set", params={"param": "HealthCheckPort", "value": health_check_port})
            results.append(f"Health Check Port: {resp.to_text()}")
        if preferred:
            resp = client.execute("set", params={"param": "haprefered", "value": preferred})
            results.append(f"Preferred: {resp.to_text()}")

        return "\n".join(results)

    @mcp.tool()
    def lm_ha_failover() -> str:
        """Trigger an HA failover to the partner unit.

        WARNING: This will cause a brief service interruption during failover.
        """
        client = require_client()
        resp = client.get("haprefered", value="1")
        return resp.to_text()

    @mcp.tool()
    def lm_get_azure_ha() -> str:
        """Get Azure HA configuration (for Azure-deployed LoadMasters)."""
        client = require_client()
        resp = client.get("getazurehaconfig")
        return resp.to_text()

    @mcp.tool()
    def lm_set_azure_ha(
        subscription_id: str = "",
        resource_group: str = "",
        client_id: str = "",
        client_secret: str = "",
        tenant_id: str = "",
    ) -> str:
        """Configure Azure HA parameters.

        Args:
            subscription_id: Azure subscription ID
            resource_group: Azure resource group name
            client_id: Azure AD application client ID
            client_secret: Azure AD application client secret
            tenant_id: Azure AD tenant ID
        """
        client = require_client()
        results = []
        if subscription_id:
            resp = client.execute("set", params={"param": "azuresubscriptionid", "value": subscription_id})
            results.append(f"Subscription ID: {resp.to_text()}")
        if resource_group:
            resp = client.execute("set", params={"param": "azureresourcegroup", "value": resource_group})
            results.append(f"Resource Group: {resp.to_text()}")
        if client_id:
            resp = client.execute("set", params={"param": "azureclientid", "value": client_id})
            results.append(f"Client ID: {resp.to_text()}")
        if client_secret:
            resp = client.execute("set", params={"param": "azureclientsecret", "value": client_secret})
            results.append(f"Client Secret: set")
        if tenant_id:
            resp = client.execute("set", params={"param": "azuretenantid", "value": tenant_id})
            results.append(f"Tenant ID: {resp.to_text()}")
        return "\n".join(results) if results else "No Azure HA parameters specified."

    @mcp.tool()
    def lm_get_aws_ha() -> str:
        """Get AWS HA configuration (for AWS-deployed LoadMasters)."""
        client = require_client()
        resp = client.get("getawshaconfig")
        return resp.to_text()
