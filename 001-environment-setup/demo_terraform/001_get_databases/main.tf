# 取得 SOPS 加密檔案
data "sops_file" "credentials" {
  source_file = local.sops_encrypted_file
}

# 取得 所有資料庫
data "mysql_databases" "all" {
  pattern = "%"
}

# 顯示 所有資料庫
output "databases" {
  value = data.mysql_databases.all.databases
}
