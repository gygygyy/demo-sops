terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    mysql = {
      source  = "petoju/mysql"
      version = "~> 3.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 1.0"
    }
  }

  required_version = ">= 1.5.7"
}

provider "mysql" {
  endpoint = "${sensitive(data.sops_file.credentials.data["mysql.host"])}:3306"
  username = sensitive(data.sops_file.credentials.data["mysql.superuser.username"])
  password = sensitive(data.sops_file.credentials.data["mysql.superuser.password"])
}
