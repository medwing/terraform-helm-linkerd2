gateway:
  # -- If the gateway component should be installed
  enabled: ${gateway.enabled}
  # -- The name of the gateway that will be installed
  name: ${gateway.name}
  # -- The port on which all the gateway will accept incoming traffic
  port: ${gateway.port}
  # -- Service Type of gateway Service
  serviceType: ${gateway.serviceType}
  # nodePort -- Set the gateway nodePort (for LoadBalancer or NodePort) to a specific value
  %{ if gateway.nodePort != "" }
  nodePort: ${gateway.nodePort}
  %{ endif }
  probe:
    # -- The path that will be used by remote clusters for determining whether the
    # gateway is alive
    path: ${gateway.probe.path}
    # -- The port used for liveliness probing
    port: ${gateway.probe.port}
    # nodePort -- Set the probe nodePort (for LoadBalancer or NodePort) to a specific value
    %{ if gateway.nodePort != "" }
    nodePort: ${gateway.nodePort}
    %{ endif }
    # -- The interval (in seconds) between liveness probes
    seconds: ${gateway.probe.seconds}
  # -- Annotations to add to the gateway service
  %{ if gateway.serviceAnnotations != "" }
  serviceAnnotations:
    ${gateway.serviceAnnotations}
  %{ else }
  serviceAnnotations: {}
  %{ endif }

  # -- Set loadBalancerIP on gateway service
  loadBalancerIP: ${gateway.loadBalancerIP}

# -- If the namespace should be installed
installNamespace: ${installNamespace}
# -- Control plane version
linkerdVersion: ${linkerdVersion}
# -- Service Mirror component namespace
namespace: ${namespace}
# -- The port on which the proxy accepts outbound traffic
proxyOutboundPort: ${proxyOutboundPort}
# -- If the remote mirror service account should be installed
remoteMirrorServiceAccount: ${remoteMirrorServiceAccount}
# -- The name of the service account used to allow remote clusters to mirror
# local services
remoteMirrorServiceAccountName: ${remoteMirrorServiceAccountName}
# -- Namespace of linkerd installation
linkerdNamespace: ${linkerdNamespace}
# -- Identity Trust Domain of the certificate authority
identityTrustDomain: ${identityTrustDomain}

# -- Create Roles and RoleBindings to associate this extension's
# ServiceAccounts to the control plane PSP resource. This requires that
# `enabledPSP` is set to true on the control plane install. Note PSP has been
# deprecated since k8s v1.21
enablePSP: ${enablePSP}
