provider "aws" {
  region  = var.region
  profile = "own"
  default_tags {
    tags = {
      "name"    = var.name
      "purpose" = var.purpose
    }
  }
}
