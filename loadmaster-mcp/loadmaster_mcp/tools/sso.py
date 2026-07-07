"""
SSO Domain & Authentication Tools

Tools for managing SSO domains and LDAP endpoints on the LoadMaster.
"""

from mcp.server.fastmcp import FastMCP

from ..config import require_client


def register(mcp: FastMCP) -> None:
    """Register SSO/auth tools with the MCP server."""

    # --- SSO Domains ---

    @mcp.tool()
    def lm_list_sso_domains() -> str:
        """List all SSO domains configured on the LoadMaster."""
        client = require_client()
        resp = client.get("showdomain")
        return resp.to_text()

    @mcp.tool()
    def lm_get_sso_domain(domain: str) -> str:
        """Get detailed configuration of an SSO domain.

        Args:
            domain: SSO domain name
        """
        client = require_client()
        resp = client.execute("showdomain", params={"domain": domain})
        return resp.to_text()

    @mcp.tool()
    def lm_add_sso_domain(
        domain: str,
        auth_type: str = "",
        server_side: str = "",
        logon_fmt: str = "",
        logon_domain: str = "",
        kerberos_domain: str = "",
        kerberos_kdc: str = "",
        max_failed_auths: str = "",
        reset_fail_tout: str = "",
        sess_tout_idle: str = "",
        sess_tout_duration: str = "",
    ) -> str:
        """Create a new SSO domain.

        Auth types: SAML, LDAP, RADIUS, Certificate, KCD, etc.

        Args:
            domain: SSO domain name
            auth_type: Authentication type
            server_side: Server-side auth type
            logon_fmt: Logon format string
            logon_domain: Logon domain
            kerberos_domain: Kerberos realm
            kerberos_kdc: Kerberos KDC address
            max_failed_auths: Max failed authentication attempts
            reset_fail_tout: Reset failure timeout (seconds)
            sess_tout_idle: Session idle timeout (seconds)
            sess_tout_duration: Session duration timeout (seconds)
        """
        client = require_client()
        params: dict = {"domain": domain}
        if auth_type:
            params["auth_type"] = auth_type
        if server_side:
            params["server_side"] = server_side
        if logon_fmt:
            params["logon_fmt"] = logon_fmt
        if logon_domain:
            params["logon_domain"] = logon_domain
        if kerberos_domain:
            params["kerberos_domain"] = kerberos_domain
        if kerberos_kdc:
            params["kerberos_kdc"] = kerberos_kdc
        if max_failed_auths:
            params["max_failed_auths"] = max_failed_auths
        if reset_fail_tout:
            params["reset_fail_tout"] = reset_fail_tout
        if sess_tout_idle:
            params["sess_tout_idle_priv"] = sess_tout_idle
        if sess_tout_duration:
            params["sess_tout_duration_priv"] = sess_tout_duration

        resp = client.execute("adddomain", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_modify_sso_domain(
        domain: str,
        auth_type: str = "",
        server_side: str = "",
        logon_fmt: str = "",
        logon_domain: str = "",
        kerberos_domain: str = "",
        kerberos_kdc: str = "",
        max_failed_auths: str = "",
        reset_fail_tout: str = "",
        sess_tout_idle: str = "",
        sess_tout_duration: str = "",
        extra_params: str = "",
    ) -> str:
        """Modify an existing SSO domain.

        Args:
            domain: SSO domain name to modify
            auth_type: Authentication type
            server_side: Server-side auth type
            logon_fmt: Logon format string
            logon_domain: Logon domain
            kerberos_domain: Kerberos realm
            kerberos_kdc: Kerberos KDC address
            max_failed_auths: Max failed authentication attempts
            reset_fail_tout: Reset failure timeout (seconds)
            sess_tout_idle: Session idle timeout (seconds)
            sess_tout_duration: Session duration timeout (seconds)
            extra_params: Additional params as 'key1=val1&key2=val2'
        """
        client = require_client()
        params: dict = {"domain": domain}
        if auth_type:
            params["auth_type"] = auth_type
        if server_side:
            params["server_side"] = server_side
        if logon_fmt:
            params["logon_fmt"] = logon_fmt
        if logon_domain:
            params["logon_domain"] = logon_domain
        if kerberos_domain:
            params["kerberos_domain"] = kerberos_domain
        if kerberos_kdc:
            params["kerberos_kdc"] = kerberos_kdc
        if max_failed_auths:
            params["max_failed_auths"] = max_failed_auths
        if reset_fail_tout:
            params["reset_fail_tout"] = reset_fail_tout
        if sess_tout_idle:
            params["sess_tout_idle_priv"] = sess_tout_idle
        if sess_tout_duration:
            params["sess_tout_duration_priv"] = sess_tout_duration

        if extra_params:
            for pair in extra_params.split("&"):
                if "=" in pair:
                    k, v = pair.split("=", 1)
                    params[k.strip()] = v.strip()

        resp = client.execute("moddomain", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_delete_sso_domain(domain: str) -> str:
        """Delete an SSO domain.

        WARNING: This removes the SSO domain and associated sessions.

        Args:
            domain: SSO domain name to delete
        """
        client = require_client()
        resp = client.execute("deldomain", params={"domain": domain})
        return resp.to_text()

    @mcp.tool()
    def lm_get_sso_locked_users(domain: str) -> str:
        """List locked-out users in an SSO domain.

        Args:
            domain: SSO domain name
        """
        client = require_client()
        resp = client.execute("showdomainlockedusers", params={"domain": domain})
        return resp.to_text()

    @mcp.tool()
    def lm_unlock_sso_users(domain: str) -> str:
        """Unlock all locked-out users in an SSO domain.

        Args:
            domain: SSO domain name
        """
        client = require_client()
        resp = client.execute("unlockdomainusers", params={"domain": domain})
        return resp.to_text()

    # --- LDAP Endpoints ---

    @mcp.tool()
    def lm_list_ldap_endpoints() -> str:
        """List all LDAP endpoints configured on the LoadMaster."""
        client = require_client()
        resp = client.get("showldapep")
        return resp.to_text()

    @mcp.tool()
    def lm_add_ldap_endpoint(
        name: str,
        server: str,
        ldap_protocol: str = "ldaps",
        referral_count: str = "",
        timeout: str = "",
    ) -> str:
        """Create a new LDAP endpoint.

        Args:
            name: LDAP endpoint name
            server: LDAP server address
            ldap_protocol: Protocol - 'ldap', 'ldaps', or 'starttls'
            referral_count: Max referral follows
            timeout: Connection timeout in seconds
        """
        client = require_client()
        params: dict = {"name": name, "server": server, "LdapProtocol": ldap_protocol}
        if referral_count:
            params["ReferralCount"] = referral_count
        if timeout:
            params["Timeout"] = timeout
        resp = client.execute("addldapep", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_modify_ldap_endpoint(
        name: str,
        server: str = "",
        ldap_protocol: str = "",
        referral_count: str = "",
        timeout: str = "",
    ) -> str:
        """Modify an existing LDAP endpoint.

        Args:
            name: LDAP endpoint name to modify
            server: LDAP server address
            ldap_protocol: Protocol - 'ldap', 'ldaps', or 'starttls'
            referral_count: Max referral follows
            timeout: Connection timeout in seconds
        """
        client = require_client()
        params: dict = {"name": name}
        if server:
            params["server"] = server
        if ldap_protocol:
            params["LdapProtocol"] = ldap_protocol
        if referral_count:
            params["ReferralCount"] = referral_count
        if timeout:
            params["Timeout"] = timeout
        resp = client.execute("modldapep", params=params)
        return resp.to_text()

    @mcp.tool()
    def lm_delete_ldap_endpoint(name: str) -> str:
        """Delete an LDAP endpoint.

        Args:
            name: LDAP endpoint name to delete
        """
        client = require_client()
        resp = client.execute("delldapep", params={"name": name})
        return resp.to_text()
