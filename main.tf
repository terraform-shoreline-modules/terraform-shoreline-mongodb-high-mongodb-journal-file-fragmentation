terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "high_mongodb_journal_file_fragmentation" {
  source    = "./modules/high_mongodb_journal_file_fragmentation"

  providers = {
    shoreline = shoreline
  }
}