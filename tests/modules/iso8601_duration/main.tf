// main.tf

locals {
  inputs = [
    "P10Y5M3DT4H30M58S",
    "P10Y",
    "P5M",
    "P3D",
    "PT4H",
    "PT30M",
    "PT58S",
    "P10YT58S",
    "P5MT58S",
    "P3DT58S",
    "P10Y5M3D",
    "P10Y5M",
    "P10Y3D",
    "P5M3D",
    "P5MT4H",
    "P3DT4H",
    "P",
    "PT",
  ]
}

locals {
  regexp = "^P(?:(?P<year>[0-9]+)Y)?(?:(?P<month>[0-9]+)M)?(?:(?P<day>[0-9]+)D)?(?:[T](?:(?P<hour>[0-9]+)H)?(?:(?P<minute>[0-9]+)M)?(?:(?P<second>[0-9]+)S)?)?$"

  match = { for index, input in local.inputs : index => regex(local.regexp, input) }
  time  = local.match[0]
  duration = {
    year   = local.time["year"] != null ? tonumber(local.time["year"]) : 0
    month  = local.time["month"] != null ? tonumber(local.time["month"]) : 0
    day    = local.time["day"] != null ? tonumber(local.time["day"]) : 0
    hour   = local.time["hour"] != null ? tonumber(local.time["hour"]) : 0
    minute = local.time["minute"] != null ? tonumber(local.time["minute"]) : 0
    second = local.time["second"] != null ? tonumber(local.time["second"]) : 0
  }

  # Ignore the year and month for the purpose of this example
  hours           = local.duration.day * 24 + local.duration.hour
  added_time      = "${local.hours}h${local.duration.minute}m${local.duration.second}s"
  expiration_time = timeadd(timestamp(), local.added_time)
}

output "test" {
  value = local.match
}

output "duration" {
  value = local.duration
}

output "expiration_time" {
  value = local.expiration_time
}
