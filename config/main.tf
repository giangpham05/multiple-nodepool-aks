/*
  To RUN, cd to prod folder, then:
    terraform init
    terraform plan -out out.plan
    terraform apply out.plan
  To DESTROY, run:
    terraform destroy
*/

/* ============= PART 2 - CLUSTER CONFIGURATION ============== */

# AKS namespaces
module "aks_namespaces" {
  source = "../modules/aks_namespaces"
}

# AKS Azure AD RBAC integration
module "aks_azuread_rbac" {
  source = "../modules/aks_azuread_rbac"
}

# AKS Dashboard configuration
module "kubernetes_dashboard" {
  source = "cookielab/dashboard/kubernetes"
  version = "0.9.0"

  kubernetes_namespace_create = true
  kubernetes_dashboard_csrf = ""
}

# AKS ELK Provisioning, Prometheus, Grafana

# AKS Ingress Controller for Load Balancing

