variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "db_endpoint" {
  type = string
}

variable "ecr_url" {
  type = string
}

variable "alb_tg_arn" {
  type = string
}