output "cloud_run_uri" {
  description = "The URL of the deployed Cloud Run service"
  value       = google_cloud_run_service.terrarun.status[0].url
}
