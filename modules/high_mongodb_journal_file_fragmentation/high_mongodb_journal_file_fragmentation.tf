resource "shoreline_notebook" "high_mongodb_journal_file_fragmentation" {
  name       = "high_mongodb_journal_file_fragmentation"
  data       = file("${path.module}/data/high_mongodb_journal_file_fragmentation.json")
  depends_on = [shoreline_action.invoke_mongodb_conf_edit]
}

resource "shoreline_file" "mongodb_conf_edit" {
  name             = "mongodb_conf_edit"
  input_file       = "${path.module}/data/mongodb_conf_edit.sh"
  md5              = filemd5("${path.module}/data/mongodb_conf_edit.sh")
  description      = "Increase the journal commit interval to reduce the frequency of disk writes."
  destination_path = "/tmp/mongodb_conf_edit.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_mongodb_conf_edit" {
  name        = "invoke_mongodb_conf_edit"
  description = "Increase the journal commit interval to reduce the frequency of disk writes."
  command     = "`chmod +x /tmp/mongodb_conf_edit.sh && /tmp/mongodb_conf_edit.sh`"
  params      = ["JOURNAL_COMMIT_INTERVAL_MS_500"]
  file_deps   = ["mongodb_conf_edit"]
  enabled     = true
  depends_on  = [shoreline_file.mongodb_conf_edit]
}

