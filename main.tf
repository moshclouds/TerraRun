resource "google_cloud_run_service" "terrarun" {
  name     = "terrarun"
  location = var.cloud_run_location

  template {
    spec {
      containers {
        image = var.image_name
        ports {
          container_port = var.cloud_run_container_port
        }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = var.cloud_run_invoker
    members = [
      var.cloud_run_auths,
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.terrarun.location
  project     = google_cloud_run_service.terrarun.project
  service     = google_cloud_run_service.terrarun.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
