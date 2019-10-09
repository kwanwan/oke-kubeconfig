# oke-kubeconfig

Tool for downloading `kubeconfig` file from Oracle Container Engine (OKE) for Kubernetes cluster.

This tool need to run as a Wercker build pipeline with the following Wercker variables passed to it during the build time.

```
  Key:                  Value:
  OCIUSEROCID           your OCI user ID
  OCIAPIKEYFP           your API key fingerprint
  OCIAPIKEY_PRIVATE     your API private key created in Lab 100
  OCITENANTOCID         your OCI tenancy ID
  OCIOKEOCID            your OKE cluster ID
  OCIREGION             us-ashburn-1 or us-phoenix-1 for your tenancy
  OCIENDPOINT           containerengine.us-ashburn-1.oraclecloud.com  or  containerengine.us-phoenix-1.oraclecloud.com
  ```
