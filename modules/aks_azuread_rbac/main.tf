# Grant cluster-admin rights
resource "kubernetes_cluster_role_binding" "your_cluster_admins" {
  metadata {
    name = "your_cluster_admins"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"
    name      = var.ad_admin_user_id
  }

  subject {
    kind      = "Group"
    name      = var.ad_security_group_id
  }
}