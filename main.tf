provider "google" {
  project	= "firestore-project-514"
  region	= "northamerica-northeast1"
  zone		= "northamerica-northeast1-a"
}


resource "time_sleep" "wait_60_seconds" {
  create_duration = "60s"
}

resource "google_project_service" "firestore" {
  project 	= provider.google.project
  service 	= "firestore.googleapis.com"

  depends_on 	= [time_sleep.wait_60_seconds]
}

resource "google_firestore_database" "database" {
  project     			= provider.google.project
  name        			= "(default)"
  location_id 			= "northamerica-northeast1"
  type        			= "FIRESTORE_NATIVE"
  concurrency_mode		= "OPTIMISTIC"
  app_engine_integration_mode 	= "DISABLED"

  depends_on 			= [google_project_service.firestore]
}
