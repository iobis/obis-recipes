## code to prepare logo internal data
## Run once with: source("data-raw/logos.R")

tf_ioc  <- tempfile(fileext = ".svg")
tf_obis <- tempfile(fileext = ".png")

download.file("https://obis.org/images/ioc_logo_black_2.svg", tf_ioc,  mode = "wb", quiet = TRUE)
download.file("https://obis.org/images/logo_simple.png",       tf_obis, mode = "wb", quiet = TRUE)

logos <- list(
    ioc  = readBin(tf_ioc,  "raw", file.size(tf_ioc)),
    obis = readBin(tf_obis, "raw", file.size(tf_obis))
)

usethis::use_data(logos, internal = TRUE, overwrite = TRUE)
