# Real Servers

Real servers (RS) are the backend application servers that receive traffic from a virtual service. Each RS belongs to a VS and has configurable weight, forwarding method, health check behavior, and connection limits.

## Commands (8)

| Command | Description |
|---------|-------------|
| [`access/addrs`](access-addrs.md) | Add RS to a VS (supports sub-VS via numeric index) |
| [`access/delrs`](access-delrs.md) | Remove RS from a VS |
| [`access/modrs`](access-modrs.md) | Modify RS settings (weight, forward, limit) |
| [`access/showrs`](access-showrs.md) | Get RS details and health status |
| [`access/enablers`](access-enablers.md) | Bring RS back into rotation |
| [`access/disablers`](access-disablers.md) | Take RS out of rotation (graceful drain) |
| [`access/addrsrule`](access-addrsrule.md) | Associate a content rule with a RS |
| [`access/delrsrule`](access-delrsrule.md) | Remove a rule association from RS |

## Key Concepts

- **Sub-VS addressing**: To add RS to a sub-VS, use `vs=<numeric-index>` (not IP address)
- **Standalone VS addressing**: Use `vs=<IP>&port=<port>&prot=tcp`
- **Master VS**: Cannot add RS directly — must add to each sub-VS individually
- **Forwarding methods**: `nat` (default), `route`, `masq`
