# 取得 SOPS 加密檔案
data "sops_file" "credentials" {
  source_file = local.sops_encrypted_file
}

resource "mysql_database" "db_terraform" {
  name                  = sensitive(data.sops_file.credentials.data["mysql.db_terraform.database"])
  default_character_set = "utf8mb4"
  default_collation     = "utf8mb4_general_ci"
}

resource "mysql_user" "db_terraform" {
  user               = sensitive(data.sops_file.credentials.data["mysql.db_terraform.username"])
  host               = "%"
  plaintext_password = sensitive(data.sops_file.credentials.data["mysql.db_terraform.password"])
}

resource "mysql_grant" "db_terraform" {
  user       = mysql_user.db_terraform.user
  database   = mysql_database.db_terraform.name
  host       = mysql_user.db_terraform.host
  privileges = ["ALL"]
}
