resource "kubernetes_namespace" "development_namespace" {
  metadata {
    name = "development"
  }
}

resource "kubernetes_namespace" "production_namespace" {
  metadata {
    name = "production"
  }
}

resource "kubernetes_namespace" "uat_namespace" {
  metadata {
    name = "uat"
  }
}