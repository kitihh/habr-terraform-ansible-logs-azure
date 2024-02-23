resource "yandex_iam_service_account" "compute-editor" {
  description = "Service account used to manage virtual machines"
  name        = "compute-editor"
}

resource "yandex_resourcemanager_folder_iam_binding" "compute-editor" {
  folder_id = local.folder_id
  members = [
    "serviceAccount:${yandex_iam_service_account.compute-editor.id}"
  ]
  role = "compute.editor"
}


