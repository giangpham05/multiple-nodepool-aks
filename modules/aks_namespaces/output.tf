output "development_namespace" {
  value = kubernetes_namespace.development_namespace.id
}

output "production_namespace" {
  value = kubernetes_namespace.production_namespace.id
}

output "uat_namespace" {
  value = kubernetes_namespace.uat_namespace.id
}