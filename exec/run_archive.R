library(piggyback)
library(purrr)

get_releases <- piggyback::pb_releases(repo = "nwslR/nwsldata")

purrr::map(get_releases$tag_name, nwsldata::archive_nwsldata)
