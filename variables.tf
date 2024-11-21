variable "gcp_project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}
variable "gcp_region" {
  description = "The region for GCP resources"
  type        = string
}
variable "cloud_run_location" {
  description = "The region for cloud run resources"
  type        = string
}
variable "image_name" {
  description = "the image name in gar"
  type        = string
}
variable "cloud_run_container_port" {
  description = "the container port in gcr"
  type        = number
}
variable "cloud_run_auths" {
  description = "the cloud run allowed auth"
  type        = string
}
variable "cloud_run_invoker" {
  description = "the cloud run invoker role"
  type        = string
}