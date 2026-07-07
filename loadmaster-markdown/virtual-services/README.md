# Virtual Services

Virtual services are the core load balancing objects in LoadMaster. Each VS defines a VIP (virtual IP + port) that accepts client traffic and distributes it to one or more real servers. VS can be standalone or use content switching (Master VS with sub-VS) for URL-based routing.

## Commands (7+10)

| Command | Description |
|---------|-------------|
| [`access/addvs`](access-addvs.md) | Create a new virtual service (supports template deployment) |
| [`access/modvs`](access-modvs.md) | Modify VS settings (also used to create sub-VS) |
| [`access/delvs`](access-delvs.md) | Delete a virtual service |
| [`access/showvs`](access-showvs.md) | Get detailed VS configuration and sub-VS list |
| [`access/listvs`](access-listvs.md) | List all virtual services (includes sub-VS) |
| [`access/exportvstmplt`](access-exportvstmplt.md) | Export VS config as a reusable template |
| [`access/dupvs`](access-dupvs.md) | Duplicate a virtual service or sub-VS (7.2.61+) |

### Kubernetes Ingress Controller (7.2.61+)

| Command | Description |
|---------|-------------|
| [`access/addlmingressk8sconf`](access-addlmingressk8sconf.md) | Upload a Kube config file |
| [`access/dellmingressk8sconf`](access-dellmingressk8sconf.md) | Delete the Kube config file |
| [`access/showlmingressk8sconf`](access-showlmingressk8sconf.md) | List contexts in the Kube config |
| [`access/getlmingressmode`](access-getlmingressmode.md) | Check the ingress operations mode |
| [`access/setlmingressmode`](access-setlmingressmode.md) | Set the ingress operations mode |
| [`access/getlmingressnamespace`](access-getlmingressnamespace.md) | Check the namespace being watched |
| [`access/setlmingressnamespace`](access-setlmingressnamespace.md) | Set the namespace to watch |
| [`access/getlmingresswatchtimeout`](access-getlmingresswatchtimeout.md) | Check the watch timeout |
| [`access/setlmingresswatchtimeout`](access-setlmingresswatchtimeout.md) | Set the watch timeout |
| [`access/restartlmingress`](access-restartlmingress.md) | Restart the ingress controller |

## Key Concepts

- **Standalone VS**: Single VIP with direct RS pool (e.g., SMTP on port 25)
- **Master VS + Sub-VS**: Content switching — Master VS on port 443 with sub-VS per URL path (e.g., Exchange 2019 with OWA, EWS, MAPI sub-VS)
- **Template deployment**: `addvs?template=<name>` creates a pre-configured VS from an uploaded template
- **Sub-VS addressing**: Sub-VS are identified by numeric `VSIndex`, not by IP+port
