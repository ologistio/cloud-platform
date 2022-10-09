variable "id" {
  description = "Identification object"
  type = object({
    org                 = string
    group               = string
    its_group           = string
    cost_centre         = string
    owner               = string
    owner_email         = string
    core_infrastructure = string
    application         = string
    component           = string
    stack               = string
  })
}

variable "loc" {
  description = "Location object"
  type = object({
    environment = string
    region      = string
    zones       = list(string)
  })
}
